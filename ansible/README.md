# Ansible

Ansible is the configuration manager for the cluster. It is agentless — it connects over SSH and requires no agent on managed nodes. The control machine must be Linux (or WSL / a VM on Windows; Ansible does not run natively on Windows).

## Prerequisites

- SSH access to all managed nodes
- Linux control machine
- [`pipx`](https://pipx.pypa.io/) installed

## Installation

Install Ansible and the linter into their own isolated environment via `pipx`:

```bash
pipx install ansible
pipx inject ansible ansible-lint
```

Both `ansible` and `ansible-lint` are then available on `$PATH` without activating any virtual environment.

### Ansible Galaxy collections

The playbooks depend on two community collections:

```bash
ansible-galaxy collection install community.general
ansible-galaxy collection install community.postgresql
```

## Adapting to your cluster

### Inventory

Copy the example inventory and fill in the real IPs:

```bash
cp secrets/inventory.yml.exemple secrets/inventory.yml
```

The inventory has three groups:

| Group | Description |
|---|---|
| `storage` | Storage nodes running ZFS, PostgreSQL, NFS, iSCSI |
| `compute` | Compute nodes running K3s |
| `metal` | Meta-group containing both `storage` and `compute` |

### Secrets and variables

`secrets/passwords.yml` must exist before running the database play. It is not tracked in git. It must define at minimum:

```yaml
db_password: "your-postgres-password"
```

`group_vars/compute.yml` also references `main_storage_ip` and `subnet_ip_range`. Supply these either in a vars file or via `--extra-vars` at runtime.

## Cluster architecture

```
metal
├── storage  →  ZFS pool ("tank"), PostgreSQL, NFS export, iSCSI target, Sanoid snapshots
└── compute  →  K3s Kubernetes, connects to PostgreSQL on the storage node
```

## Roles

| Role | Hosts | Purpose |
|---|---|---|
| `hardening` | all | UFW firewall, deny-by-default, SSH key-only auth |
| `monitoring` | metal | smartmontools, htop, btop |
| `zfs` | storage | ZFS tools, pool import, dataset creation, optimisations |
| `zfs_snapshots` | storage | Sanoid automated snapshots (hourly/daily/monthly) |
| `storage` | storage | NFS + iSCSI exports, CSI driver sudo rules |
| `sql_server` | compute | PostgreSQL on ZFS mount, k3s_db database and user |
| `k3s` | compute | K3s cluster setup _(not yet implemented)_ |

## Running the playbook

Full run against all hosts:

```bash
ansible-playbook site.yml
```

Targeted runs using tags:

```bash
# Security hardening only
ansible-playbook site.yml --tags security

# Monitoring only
ansible-playbook site.yml --tags monitoring

# Full storage stack (ZFS, snapshots, NFS/iSCSI)
ansible-playbook site.yml --tags zfs,snapshots,storage,csi

# Database setup
ansible-playbook site.yml --tags kubernetes,sql_prep,sql

# K3s setup (placeholder — not yet implemented)
ansible-playbook site.yml --tags kubernetes,k3s_prep
```

Dry-run (no changes applied):

```bash
ansible-playbook site.yml --check
```
