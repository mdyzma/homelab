# Disaster Recovery Guide

This guide outlines the steps to rebuild the entire homelab environment from scratch using this repository.

## Phase 1: Bare Metal Recovery
1. **Host Install:** Install Proxmox VE (Debian base) on the ASUS hardware.
2. **Network:** Configure `vmbr0` with IP `192.168.88.10`.
3. **ZFS:** Re-import the `tank` pool:
   ```bash
   zfs import -a
   ```

## Phase 2: Host Configuration
1. **Bootstrap:** Run the bootstrap script to install Git and Ansible:
   ```bash
   ./scripts/bootstrap-pve.sh
   ```
2. **Provision Host:** Run the Ansible playbook to configure drivers and ZFS:
   ```bash
   ansible-playbook -i metal/inventories/prod.yml metal/site.yml --limit proxmox
   ```

## Phase 3: Infrastructure Provisioning
1. **Templates:** Ensure the Ubuntu Cloud image template (ID 1000) exists:
   ```bash
   ./scripts/make-template.sh
   ```
2. **Terraform:** Apply the infrastructure manifest:
   ```bash
   cd external/
   terraform init
   terraform apply
   ```

## Phase 4: Service Configuration
1. **LXC Hardening:** Apply the common configuration to all containers:
   ```bash
   ansible-playbook -i metal/inventories/prod.yml metal/site.yml --limit lxc_containers
   ```
