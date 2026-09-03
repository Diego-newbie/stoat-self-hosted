module "stoat_vm" {
  source = "./modules/proxmox_vm"

  target_node    = var.target_node
  template_id    = var.template_id
  vm_id          = var.vm_id
  vm_name        = var.vm_name
  vm_cores       = var.vm_cores
  vm_memory      = var.vm_memory
  vm_disk_size   = var.vm_disk_size
  target_storage = var.target_storage
  network_bridge = var.network_bridge
  vm_ip_address  = var.vm_ip_address
  vm_gateway     = var.vm_gateway
  ci_user        = var.ci_user
  ssh_public_key = var.ssh_public_key
}
