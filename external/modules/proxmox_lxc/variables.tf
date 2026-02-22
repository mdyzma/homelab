variable "target_node" {
  type        = string
  description = "The Proxmox node to deploy the LXC to"
}

variable "hostname" {
  type        = string
  description = "The hostname of the LXC"
}

variable "vmid" {
  type        = number
  description = "The VMID of the LXC"
}

variable "ostemplate" {
  type        = string
  description = "The OS template to use for the LXC"
  default     = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "unprivileged" {
  type        = bool
  description = "Whether the LXC should be unprivileged"
  default     = true
}

variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1
}

variable "memory" {
  type        = number
  description = "Memory in MB"
  default     = 512
}

variable "rootfs_storage" {
  type        = string
  description = "The storage pool for the rootfs"
  default     = "local-lvm"
}

variable "rootfs_size" {
  type        = string
  description = "The size of the rootfs"
  default     = "8G"
}

variable "network_bridge" {
  type        = string
  description = "The network bridge to use"
  default     = "vmbr0"
}

variable "ip" {
  type        = string
  description = "The IP address for the LXC (e.g., 192.168.88.100/24 or dhcp)"
  default     = "dhcp"
}

variable "gateway" {
  type        = string
  description = "The network gateway"
  default     = ""
}

variable "ssh_public_keys" {
  type        = string
  description = "SSH public keys to inject into the LXC"
  default     = ""
}

variable "onboot" {
  type        = bool
  description = "Whether the LXC should start on boot"
  default     = true
}

variable "tags" {
  type        = string
  description = "Tags for the LXC"
  default     = "terraform"
}

variable "mount_gpu" {
  type        = bool
  description = "Whether to mount NVIDIA GPU devices"
  default     = false
}

variable "env" {
  type        = map(string)
  description = "Environment variables for the LXC"
  default     = {}
}
