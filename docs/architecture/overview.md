# Architecture Overview

## Hardware: ASUS Sabertooth Mark 2
- **CPU:** Intel Core i5-4670 (4 cores)
- **Memory:** 32 GB DDR3
- **Graphics:** NVIDIA GeForce RTX 2070 (Discrete)
- **Storage:** 6x SATA ports. Primary pool: `tank` (ZFS).

## Storage Strategy (ZFS)
- **Pool Name:** `tank` (~900 GiB)
- **Usage:** Backup storage, LXC volumes, and persistent application data.
- **Backup Path:** `/tank/backups/lxc`

## Network Design
- **Bridge:** `vmbr0` (Linux Bridge)
- **Subnet:** `192.168.88.0/24`
- **Gateway:** `192.168.88.1`
- **Provisioning:** Static IP assignment via Terraform with Mikrotik DHCP leases as reference.

## Provisioning Workflow
1. **Terraform:** Manages "Metal-to-LXC" (Resources, IPs, Hostnames).
2. **Ansible:** Manages "Day 2" configuration (Packages, Hardening, App Setup).

## Maintenance & Automation
The following maintenance tasks are scheduled on the Proxmox host via cron:

| Task | Schedule | Command |
| :--- | :--- | :--- |
| **LXC Backup** | Monthly (1st @ 02:00) | `vzdump --all` to `/tank/backups/lxc` |
| **ZFS Scrub** | Monthly (1st @ 04:00) | `zpool scrub tank` |

## Terminal & Shell Environment
The homelab uses a modern CLI stack across all LXCs:
- **Shell:** Zsh + Oh My Zsh
- **Prompt:** [Starship](https://starship.rs/)
- **Navigation:** `zoxide` (z), `fzf`
- **Utilities:** `htop`, `mc`, `dfc`, `bat`

### Client Requirements
To correctly render icons in the Starship prompt and other CLI tools, your terminal (e.g., iTerm2, Kitty) must use a **Nerd Font**.
- **Recommended:** [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip)
