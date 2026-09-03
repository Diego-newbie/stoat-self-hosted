terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.60.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "stoat_vm" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  clone {
    vm_id = var.template_id
    full  = true
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.vm_cores
    type  = "host"
  }

  memory {
    dedicated = var.vm_memory
  }

  disk {
    datastore_id = var.target_storage
    interface    = "scsi0"
    size         = var.vm_disk_size
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  serial_device {}

  initialization {
    ip_config {
      ipv4 {
        address = var.vm_ip_address
        gateway = var.vm_gateway
      }
    }

    user_account {
      username = var.ci_user
      keys     = [var.ssh_public_key]
    }
  }

  started = true

  lifecycle {
    ignore_changes = [
      clone,
      initialization,
      operating_system,
      vga,
    ]
  }
}
