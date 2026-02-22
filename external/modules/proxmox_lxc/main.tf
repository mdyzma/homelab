resource "proxmox_lxc" "container" {
  target_node  = var.target_node
  hostname     = var.hostname
  vmid         = var.vmid
  ostemplate   = var.ostemplate
  unprivileged = var.unprivileged
  cores        = var.cores
  memory       = var.memory
  onboot       = var.onboot
  tags         = var.tags

  # Flagging for Ansible/Manual post-config if GPU is needed
  description = var.mount_gpu ? "GPU_PASSTHROUGH_ENABLED" : ""

  ssh_public_keys = var.ssh_public_keys

  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }

  network {
    name   = "eth0"
    bridge = var.network_bridge
    ip     = var.ip
    gw     = var.gateway
  }
}
