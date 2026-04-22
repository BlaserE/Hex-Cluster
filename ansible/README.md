# Ansible
Ansible is the version controller of the cluster.
It is agentless and thus can be run against any managed nodes. 
It requires SSH access as well a linux environment.

It can run on a linux VM on windows as well. 
Just use your preffered method of instantiating VMs. 

It does not work on windows natively, otherwise.

## Getting Started
Ansible requires a python environment.

```python
cd /path/to/Clustern/ansible
python3 -m venv .venv
source .venv/bin/activate
```

After that, you will be in the venv environment.
From there, you will run the following commands :
```bash
pip install --upgrade pip
pip install ansible ansible-lint
```

## Adapting to your cluster
Obviously, there are never two identical setups. 
That is why I have attempted to make this as modular as possible. 


To begin, you must understand Ansible well enough. 

# Running Ansible
