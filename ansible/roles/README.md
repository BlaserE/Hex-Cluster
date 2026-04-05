# Roles
The "Toolbox." 
Each subdirectory here should be a self-contained unit of configuration (e.g., `roles/zfs`, `roles/sql`, `roles/k3s`). This keeps the code modular and reusable.

## Hardening
This is the role for hardening the cluster's security.
It includes installing the packages for `ufw` and opens ports accordingly.