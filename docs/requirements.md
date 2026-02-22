Based on my current Proxmox setup and the hardware configuration of my ASUS machine, here is a `requirements.md` file. This document outlines the technical specifications, current service architecture, and the intended project structure for my homelab.

---

# Requirements: Proxmox Homelab Project

## 1. Project Overview

This project manages a Proxmox VE-based homelab environment hosted on physical ASUS hardware. The goal is to provide a centralized, containerized infrastructure for automation, monitoring, development, and self-hosted services.

## 2. Hardware Specifications

* **Host Machine:** ASUS Motherboard
* **CPU:** Intel(R) Core(TM) i5-4670 (4 cores) @ 3.80 GHz
* **Memory:** 32 GB DDR3 (31.29 GiB detected)
* **Graphics:** NVIDIA GeForce RTX 2070 [Discrete]
* **Storage Interface:** Sabertooth Mark 2 with 6x SATA ports (1 currently in use)
* **Storage Pools:**
* **Boot/Root:** 66 GiB ext4 partition on `/dev/mapper/pve-root`
* **Data (tank):** ~900 GiB ZFS pool (`tank`) for backups and LXC storage



## 3. Software Stack

* **Hypervisor:** Proxmox VE 9.1.5
* **Base OS:** Debian GNU/Linux (Kernel 6.17.4-2-pve)
* **Shell:** zsh 5.9
* **Networking:** Linux Bridge (`vmbr0`) on `192.168.88.10/24`

## 4. Service Inventory (LXC Containers)

The environment currently runs the following services, primarily as Linux Containers (LXC):

| ID | Service Name | Purpose |
| --- | --- | --- |
| 100 | **cloudflared** | External tunneling and remote access |
| 102 | **n8n** | Workflow automation |
| 103 | **postgresql** | Primary relational database |
| 105 | **minio** | S3-compatible object storage |
| 106 | **prometheus** | Metrics collection and time-series data |
| 107 | **grafana** | Data visualization and dashboards |
| 108 | **paperless-ngx** | Document management system |
| 111 | **mongodb** | NoSQL database storage |
| 114 | **gitea** | Self-hosted Git service |
| 115 | **jenkins** | CI/CD automation server |
| 117 | **openwebui** | Interface for LLMs/AI |

## 5. Proposed Project Structure

Following the requested template, the repository will be organized to separate hardware configuration (metal), core platform services, and end-user applications.

```text
homelab/
├── apps/                # End-user services (LXC/VM configs)
│   ├── n8n/
│   ├── paperless-ngx/
│   ├── openwebui/
│   └── trilium/
├── docs/                # Documentation & How-to guides
│   ├── architecture/
│   ├── hardware-setup.md
│   └── backup-strategy.md
├── metal/               # Physical host configuration
│   ├── asus-sabertooth/
│   └── storage-zfs.yml
├── platform/            # Core infrastructure services
│   ├── cloudflared/
│   ├── gitea/
│   ├── monitoring/      # Prometheus & Grafana
│   └── databases/       # Postgres & MongoDB
├── scripts/             # Automation & Management scripts
│   ├── backup-tank
│   └── create-lxc
└── system/              # Proxmox-level system configurations
    ├── network/
    └── pve-cluster.yml

```

## 6. Storage & Backup Requirements

* **ZFS Integration:** All critical data and backups must reside on the `tank` ZFS pool.
* **Backup Path:** Containers should be backed up to `/tank/backups/lxc`.
* **Redundancy:** Future expansion should utilize the remaining 5 SATA ports for disk redundancy (RAIDZ).

---
To add automatic provisioning to the Proxmox homelab, the architecture will shift from manual LXC/VM creation to a **GitOps and Infrastructure-as-Code (IaC)** workflow.


# Requirements: Proxmox Homelab Project

## 1. Project Overview

This project manages a Proxmox VE-based homelab hosted on physical ASUS hardware. It utilizes a **Declarative Provisioning** model to automate the lifecycle of infrastructure and services.

## 2. Infrastructure as Code (IaC) Requirements

To achieve automatic provisioning, the following tools and methods are required:

* **Terraform/OpenTofu:** Used for "Metal-to-VM" provisioning. It will communicate with the Proxmox API to define CPU, RAM, and Disk resources for every node.
* **Cloud-Init:** All VM templates must be Cloud-Init compatible to allow for automatic injection of SSH keys, network configurations, and user accounts upon first boot.
* **Ansible:** Used for "Day 2" configuration. Once a VM/LXC is provisioned by Terraform, Ansible playbooks will handle package installation (Docker, Zsh, etc.) and security hardening.
* **FluxCD / ArgoCD:** (Optional but recommended for the `apps/` layer) To maintain the state of containerized applications via GitOps.

## 3. Hardware Specifications

* **Host:** ASUS Motherboard (Sabertooth Mark 2)
* **CPU:** Intel Core i5-4670 (4 cores)
* **Memory:** 32 GB DDR3
* **Storage:** 6x SATA ports. Primary pool: `tank` (ZFS).
* **Provisioning Network:** Isolated VLAN or dedicated bridge (`vmbr0`) for PXE/Cloud-Init data.

## 4. Automatic Provisioning Workflow

The project structure is updated to include provisioning logic:

```text
homelab/
├── apps/                # Application deployment (Helm/K8s or Docker-Compose)
├── docs/                # Documentation
├── external/            # Terraform/OpenTofu code
│   ├── main.tf          # Proxmox Provider setup
│   ├── variables.tf     # VM IDs, node names, and resource limits
│   ├── terraform.tfvars # Sensitive credentials (ignored by git)
│   └── modules/         # Reusable modules for LXC and VM types
├── metal/               # Ansible playbooks for physical host & OS config
│   ├── roles/
│   │   ├── pve-init/    # Post-install host hardening
│   │   └── zfs-setup/   # Automatic pool and dataset creation
│   └── site.yml
├── scripts/             # Helper scripts
│   ├── create-template  # Script to build Cloud-Init Ubuntu/Debian templates
│   └── vault-encrypt    # Script to manage secrets for Ansible
└── system/              # Core Proxmox system configs

```

## 5. Automated Service Inventory

Current services to be migrated to the automated provisioning manifest:

* **Databases:** PostgreSQL (103), MongoDB (111).
* **Storage:** Minio (105).
* **DevOps:** Gitea (114), Jenkins (115), OpenWebUI (117).
* **Management:** Paperless-ngx (108), Cloudflared (100).

## 6. Security & Secrets Management

* **Proxmox API Token:** Provisioning must use a restricted API Token (PVEAdmin role) rather than the root password.
* **SSH Keys:** No passwords allowed for automated provisioning; all access is via ed25519 SSH keys injected during the Cloud-Init phase.
* **SOPS/Ansible Vault:** All secrets in the repository must be encrypted before being pushed to Git.

---

### Implementation Note: Creating the "Seed" Template

Before the `external/` Terraform code can run, you must have a "Gold Image" or Template on your Proxmox host. I recommend adding a script to your `scripts/` folder that downloads an Ubuntu Cloud-Image and converts it into a Proxmox template (`template-1000`).
To ensure that this infrastructure can be rebuilt from scratch using only the repository, you need to bridge the gap between "bare metal" and the running Proxmox environment. Based on the project structure you are following, you must implement **Pre-Provisioning** and **State Management**.


### 1. Automated Base OS Installation (Pre-Seed/Kickstart)


* **PXE Boot/iPXE:** Add a `metal/pxe_server` role to handle network booting for new nodes.
* **Debian Preseed:** A configuration file in `metal/roles/prerequisites/files/` that automates the Proxmox installer (setting up the `/dev/mapper/pve-root` partition and `vmbr0` bridge).

### 2. Infrastructure as Code (IaC) for Proxmox Resources

You currently have many LXCs running (IDs 100–117). To rebuild these from the repo, you need declarative definitions in the `external/` folder.

* **Terraform Proxmox Provider:** Define the specific CPU, RAM, and Disk requirements for each service (e.g., giving the `openwebui` container access to the RTX 2070 GPU).
* **Cloud-Init Templates:** Scripts in `scripts/` to create a "Gold Image." Without this, Terraform cannot "spawn" the VMs.

### 3. ZFS Pool Re-import Logic

Your `tank` pool (900 GiB) contains your data and backups. The repository must include a way to safely re-import this pool if the OS is wiped.

* **Ansible ZFS Role:** A task in `metal/roles/zfs_setup/` that runs `zfs import -a` and ensures the mount points for `/tank/backups` and `/tank/data` are restored before the containers start.

### 4. Secret Management (The "Key to the Kingdom")

To rebuild from scratch, you cannot store passwords in plain text.

* **SOPS or Ansible Vault:** Encrypted files in `external/terraform.tfvars` and `metal/group_vars/all.yml`.
* **GPG/Age Keys:** Instructions in `docs/getting-started/` on how to provide the decryption key to the automation suite so it can access the Proxmox API.

### 5. Updated Project Structure for Rebuildability

Add these specific files to your tree to support the "scratch" build:

```text
homelab/
├── metal/
│   ├── inventories/
│   │   └── prod.yml          # Defines the ASUS host IP and SSH details
│   └── roles/
│       ├── nvidia-passthrough/ # Automates driver install for the RTX 2070
│       └── pve-bridge/        # Configures vmbr0 bridge automatically
├── external/
│   ├── main.tf               # Terraform logic to create LXCs 100-117
│   └── provider.tf           # Proxmox API connection logic
├── scripts/
│   ├── bootstrap-pve.sh      # One-command script to install git/ansible on a fresh node
│   └── make-template.sh      # Downloads Ubuntu Cloud image and makes PVE template
└── docs/
    └── recovery/
        └── full-rebuild.md   # Step-by-step "Disaster Recovery" guide

```

### 6. Summary of Dependencies

| Component | Responsibility | Tool |
| --- | --- | --- |
| **Metal** | BIOS to Proxmox OS | PXE / Debian Preseed |
| **System** | Networking & Storage (ZFS) | Ansible |
| **Compute** | Creating LXCs/VMs | Terraform / OpenTofu |
| **Apps** | Installing n8n, Gitea, etc. | Ansible / Docker-Compose |

