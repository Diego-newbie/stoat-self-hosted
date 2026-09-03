# Módulo Proxmox VM

Este módulo é responsável por clonar um template Cloud-Init no Proxmox VE e provisionar uma máquina virtual com os recursos (CPU, RAM, Disco, Rede e SSH) devidamente configurados.

## Entradas (Inputs)

| Nome | Descrição | Tipo | Padrão |
|------|-----------|------|--------|
| `target_node` | Nome do nó Proxmox | `string` | - |
| `template_name` | Nome do template base | `string` | - |
| `vm_id` | ID numérico da VM | `number` | - |
| `vm_name` | Nome da VM | `string` | - |
| `vm_cores` | Quantidade de vCPUs | `number` | `2` |
| `vm_memory` | Quantidade de RAM em MB | `number` | `3072` |
| `vm_disk_size` | Tamanho do disco | `string` | `"30G"` |
| `target_storage` | Storage de destino | `string` | `"local-lvm"` |
| `network_bridge` | Bridge de rede | `string` | `"vmbr0"` |
| `vm_ip_config` | String Cloud-Init de IP | `string` | - |
| `ci_user` | Usuário padrão do SO | `string` | `"ubuntu"` |
| `ssh_public_key` | Chave SSH pública | `string` | - |

## Saídas (Outputs)

| Nome | Descrição |
|------|-----------|
| `vm_id` | ID numérico da VM provisionada |
| `vm_name` | Nome da VM provisionada |
| `vm_ip` | IP configurado para a VM |
