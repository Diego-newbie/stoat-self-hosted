output "vm_id" {
  description = "ID da VM criada no Proxmox"
  value       = proxmox_virtual_environment_vm.stoat_vm.vm_id
}

output "vm_name" {
  description = "Nome da VM criada"
  value       = proxmox_virtual_environment_vm.stoat_vm.name
}

output "vm_ip" {
  description = "Endereço IP configurado"
  value       = var.vm_ip_address
}
