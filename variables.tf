variable "proxmox_endpoint" {
  description = "URL do endpoint da API do Proxmox VE (ex: https://192.168.15.10:8006/)"
  type        = string
  default     = "https://192.168.15.10:8006/"
}

variable "proxmox_api_token_id" {
  description = "ID do Token da API Proxmox (ex: terraform-prov@pve!terraform-token)"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "Secret do Token da API Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Desabilitar checagem estrita de certificado TLS do Proxmox"
  type        = bool
  default     = true
}

variable "target_node" {
  description = "Nó do cluster Proxmox de destino"
  type        = string
  default     = "pve"
}

variable "template_id" {
  description = "ID numérico do template Cloud-Init no Proxmox"
  type        = number
  default     = 9000
}

variable "vm_id" {
  description = "ID numérico da VM a ser criada"
  type        = number
  default     = 500
}

variable "vm_name" {
  description = "Nome da VM a ser criada"
  type        = string
  default     = "stoat-server"
}

variable "vm_cores" {
  description = "Quantidade de núcleos vCPU"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Quantidade de memória RAM em MB"
  type        = number
  default     = 3072
}

variable "vm_disk_size" {
  description = "Tamanho do disco em GB"
  type        = number
  default     = 30
}

variable "target_storage" {
  description = "Storage de destino no Proxmox para os discos da VM"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Bridge de rede do Proxmox"
  type        = string
  default     = "vmbr0"
}

variable "vm_ip_address" {
  description = "Endereço IPv4 com máscara CIDR para a VM"
  type        = string
  default     = "192.168.15.200/24"
}

variable "vm_gateway" {
  description = "Gateway IPv4 padrão da rede"
  type        = string
  default     = "192.168.15.1"
}

variable "ci_user" {
  description = "Usuário padrão criado via Cloud-Init"
  type        = string
  default     = "diego"
}

variable "ssh_public_key" {
  description = "Chave SSH pública injetada na VM para autenticação"
  type        = string
}
