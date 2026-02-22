#!/bin/bash
# bootstrap-pve.sh
# One-command script to install git/ansible on a fresh Proxmox node

echo "Starting bootstrap process..."
apt-get update
apt-get install -y git ansible zsh
echo "Bootstrap complete."
