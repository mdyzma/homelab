variable "proxmox_api_url" {
  description = "The URL for the Proxmox API"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The API Token ID for Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "The API Token Secret for Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "The Proxmox node to deploy to"
  type        = string
  default     = "pve"
}

variable "ssh_public_key" {
  description = "The SSH public key to inject into all LXC/VMs"
  type        = string
  default     = ""
}
