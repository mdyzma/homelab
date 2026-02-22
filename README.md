# Proxmox Homelab

This repository manages a Proxmox VE-based homelab hosted on physical ASUS hardware. It follows a Declarative Provisioning model using Terraform for infrastructure and Ansible for configuration.

## Project Structure

- `apps/`: End-user services (LXC/VM configs and deployments).
- `docs/`: Architecture documentation and recovery guides.
- `external/`: Terraform/OpenTofu code for Proxmox provisioning.
- `metal/`: Ansible playbooks for physical host and OS configuration.
- `platform/`: Core infrastructure services (databases, monitoring, etc.).
- `scripts/`: Automation and management scripts.
- `system/`: Proxmox-level system configurations (networking, cluster).

## Hardware Specifications

- **Host:** ASUS Motherboard (Sabertooth Mark 2)
- **CPU:** Intel Core i5-4670 (4 cores)
- **Memory:** 32 GB DDR3
- **Storage:** 6x SATA ports. Primary pool: `tank` (ZFS).

## Getting Started

Refer to [docs/requirements.md](docs/requirements.md) for detailed specifications and the provisioning workflow.
