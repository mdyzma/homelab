# Proxmox Homelab

This repository manages a Proxmox VE-based homelab hosted on physical ASUS hardware. It follows a **Declarative Provisioning** model using Terraform for infrastructure and Ansible for configuration.

## 📚 Documentation Index

- **[Architecture Overview](docs/architecture/overview.md)**: Hardware, Storage (ZFS), and Network design.
- **[Service Catalog](docs/service-catalog.md)**: Inventory of LXCs, Static IPs, and service purposes.
- **[Disaster Recovery](docs/recovery/full-rebuild.md)**: Step-by-step guide to rebuilding from scratch.

## 🛠 Project Structure

- `apps/`: End-user services (LXC/VM configs and deployments).
- `external/`: Terraform code for Proxmox provisioning.
- `metal/`: Ansible playbooks for physical host and OS configuration.
- `scripts/`: Automation and management scripts.

## 🚀 Quick Start

### 1. Provision Infrastructure
```bash
cd external/
terraform init
terraform apply
```

### 2. Configure & Harden
```bash
ansible-playbook -i metal/inventories/prod.yml metal/site.yml
```

## 💻 Hardware Specs
- **CPU:** Intel Core i5-4670 (4 cores)
- **RAM:** 32 GB DDR3
- **GPU:** NVIDIA RTX 2070
- **Storage:** ZFS `tank` pool (~900 GiB)
