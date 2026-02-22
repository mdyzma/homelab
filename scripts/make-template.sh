#!/bin/bash
# make-template.sh
# Downloads Ubuntu Cloud image and makes PVE template

# Configuration
IMAGE_URL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
STORAGE_POOL="local-lvm"
VM_ID=1000
VM_NAME="ubuntu-2204-template"

echo "Downloading cloud image..."
# wget $IMAGE_URL -O /tmp/cloud-image.img

echo "Creating template $VM_ID..."
# qm create $VM_ID --memory 2048 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci
# qm set $VM_ID --scsi0 $STORAGE_POOL:0,import-from=/tmp/cloud-image.img
# qm set $VM_ID --ide2 $STORAGE_POOL:cloudinit
# qm set $VM_ID --boot c --bootdisk scsi0
# qm set $VM_ID --serial0 socket --vga serial0
# qm template $VM_ID

echo "Template creation complete."
