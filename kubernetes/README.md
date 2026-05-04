# Kubernetes

This directory contains the GitOps bootstrap layer for the k3s cluster. The cluster itself is provisioned by Ansible (see [`../ansible/`](../ansible/)).

## Structure

```
kubernetes/
├── bootstrap/
│   └── argocd/         # ArgoCD installation — managed by Ansible, never by ArgoCD itself
├── apps/               # ArgoCD Application resources — applied once to hand off to GitOps
└── README.md
```

**ArgoCD does not manage its own installation.** If ArgoCD breaks, re-apply `bootstrap/` to restore it without needing a running ArgoCD instance.

## Bootstrap sequence

### 1. Install ArgoCD

```bash
kubectl apply -k kubernetes/bootstrap/argocd/
```

Wait for ArgoCD to become ready:

```bash
kubectl wait --for=condition=available --timeout=120s \
  deployment/argocd-server -n argocd
```

### 2. Register the personal services repo

Edit `apps/personal-services.yaml` to set the correct `repoURL` and `path`, then apply:

```bash
kubectl apply -f kubernetes/apps/personal-services.yaml
```

ArgoCD will begin syncing the personal-services repository automatically.

## Accessing the ArgoCD UI

ArgoCD is exposed via a Traefik Ingress (k3s default). ArgoCD's server runs in insecure mode so Traefik handles TLS termination.

The Ingress is defined in `apps/argocd-ingress.yaml`. Edit the `host` field to match your DNS entry before applying:

```bash
kubectl apply -f kubernetes/apps/argocd-ingress.yaml
```

Then access ArgoCD at `https://argocd.your-domain.tld`.

Initial admin password:

```bash
kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 -d
```

### Emergency / one-time access (no DNS)

If Traefik is not yet configured or DNS is not set up, you can temporarily use port-forwarding:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
