output "stoat_vm_id" {
  description = "ID da VM do Stoat criada no Proxmox"
  value       = module.stoat_vm.vm_id
}

output "stoat_vm_name" {
  description = "Nome da VM do Stoat"
  value       = module.stoat_vm.vm_name
}

output "stoat_vm_ip" {
  description = "Configuração de rede da VM"
  value       = module.stoat_vm.vm_ip
}

output "stoat_ssh_command" {
  description = "Comando para conectar via SSH na máquina virtual"
  value       = "ssh ${var.ci_user}@${split("/", var.vm_ip_address)[0]} -i ~/.ssh/id_homelab"
}
