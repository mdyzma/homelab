# Core Platform Services (LXC)

module "lxc_cloudflared" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "cloudflared"
  vmid        = 100
  memory      = 256
  cores       = 1
  ip          = "192.168.88.247/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,network"
}

module "lxc_n8n" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "n8n"
  vmid        = 102
  memory      = 1024
  cores       = 1
  ip          = "192.168.88.246/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "apps,automation"
}

module "lxc_postgresql" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "postgresql"
  vmid        = 103
  memory      = 2048
  cores       = 2
  rootfs_size = "16G"
  ip          = "192.168.88.231/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,database"
}

module "lxc_minio" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "minio"
  vmid        = 105
  memory      = 1024
  cores       = 1
  ip          = "192.168.88.228/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,storage"
}

module "lxc_prometheus" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "prometheus"
  vmid        = 106
  memory      = 2048
  cores       = 1
  ip          = "192.168.88.243/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,monitoring"
}

module "lxc_grafana" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "grafana"
  vmid        = 107
  memory      = 512
  cores       = 1
  ip          = "192.168.88.242/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,monitoring"
}

module "lxc_paperless_ngx" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "paperless-ngx"
  vmid        = 108
  memory      = 2048
  cores       = 2
  ip          = "192.168.88.241/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "apps,docs"
}

module "lxc_mongodb" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "mongodb"
  vmid        = 111
  memory      = 2048
  cores       = 1
  ip          = "192.168.88.227/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,database"
}

module "lxc_gitea" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "gitea"
  vmid        = 114
  memory      = 1024
  cores       = 1
  ip          = "192.168.88.223/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,devops"
}

module "lxc_jenkins" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "jenkins"
  vmid        = 115
  memory      = 2048
  cores       = 2
  ip          = "192.168.88.222/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "platform,devops"
}

module "lxc_ollama" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "ollama"
  vmid        = 116
  memory      = 8192
  cores       = 4
  mount_gpu   = true
  ip          = "192.168.88.216/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "apps,ai"
}

module "lxc_openwebui" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "openwebui"
  vmid        = 117
  memory      = 4096
  cores       = 2
  ip          = "192.168.88.206/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "apps,ai"
  # Connection to Ollama: OLLAMA_BASE_URL=http://192.168.88.216:11434
}

module "lxc_trilium" {
  source      = "./modules/proxmox_lxc"
  target_node = var.proxmox_node
  hostname    = "trilium"
  vmid        = 120 # Added VMID as it was in structure but not in previous main.tf
  memory      = 1024
  cores       = 1
  ip          = "192.168.88.240/24"
  gateway     = "192.168.88.1"
  ssh_public_keys = var.ssh_public_key
  tags        = "apps,docs"
}
