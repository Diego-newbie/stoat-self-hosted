# Stoat Self-Hosted on Proxmox VE (Terraform + Ansible)

Este repositório contém a infraestrutura e a automação completas para auto-hospedar uma instância do **[Stoat (ex-Revolt)](https://github.com/stoatchat/self-hosted)** em um ambiente local com **Proxmox VE**, utilizando **Terraform**, **Ansible** e **Cloudflare Tunnel**.

---

## 🏛️ Arquitetura

- **Hypervisor**: Proxmox VE (PVE)
- **Provisionamento (IaC)**: Terraform (Módulo modular para Cloud-Init)
- **Configuração (CaC)**: Ansible (Docker Engine, dependências, geração de segredos e orquestração)
- **Serviços**: Stack Docker Compose oficial do Stoat:
  - Frontend Web & Caddy Router
  - API, WebSockets (Events) e Notificações (Pushd)
  - Chamadas de Voz, Vídeo e Compartilhamento de Tela (LiveKit WebRTC)
  - Banco de Dados (MongoDB) e Cache/Mensageria (Valkey/Redis, RabbitMQ)
  - Armazenamento de Arquivos e Mídia (MinIO S3, Autumn, January)
- **Exposição Externa**:
  - **Web & API**: Cloudflare Tunnel (ligado ao Edge no Brasil, latência de ~15ms)
  - **Voz e Vídeo (WebRTC)**: Port Forwarding no roteador (UDP `50000-50100` e TCP `7881`)

---

## 📁 Estrutura do Repositório

```text
.
├── main.tf                  # Instanciação do módulo stoat_vm
├── outputs.tf               # Saídas do Terraform (IP, VMID, comando SSH)
├── variables.tf             # Variáveis raiz do Terraform
├── provider.tf              # Configuração do provedor Proxmox (bpg/proxmox)
├── terraform.tfvars.example # Template de variáveis e credenciais do Proxmox
├── README.md                # Documentação do projeto
├── modules/
│   └── proxmox_vm/          # Módulo reutilizável para VM Cloud-Init
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── README.md
└── ansible/
    ├── ansible.cfg          # Configurações do Ansible
    ├── inventory.ini        # Inventário de hosts
    ├── playbook.yml         # Playbook principal de automação
    ├── group_vars/
    │   └── all.yml          # Variáveis globais do Stoat
    └── roles/
        ├── common/          # Atualização e pacotes essenciais do SO
        ├── tailscale/       # Instalação do Tailscale
        ├── docker/          # Instalação do Docker CE e Docker Compose
        └── stoat/           # Clone, geração de segredos e subida da stack
```

---

## 🚀 Como Executar

### 1. Provisionar a VM com Terraform

1. Copie o arquivo de exemplo de variáveis:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Preencha o `terraform.tfvars` com:
   - Endpoint e Token da API do Proxmox;
   - ID do Template Cloud-Init base (Ubuntu 22.04);
   - Recursos da VM (vCPUs, RAM, Disco);
   - Chave SSH pública.

3. Inicialize e aplique o plano:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

---

### 2. Configurar o Ambiente com Ansible

1. Prepare o ambiente virtual Python e instale as dependências:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install ansible-core
   ansible-galaxy collection install ansible.posix community.general community.docker
   ```

2. Ajuste o domínio em `ansible/group_vars/all.yml` se necessário:
   ```yaml
   stoat_domain: "stoat.seudominio.com"
   ```

3. Execute o playbook:
   ```bash
   cd ansible
   ansible-playbook playbook.yml
   ```

---

### 3. Exposição Externa e Chamadas (WebRTC)

1. **Web e WebSocket (Cloudflare Tunnel)**:
   - Crie um túnel no painel do Cloudflare Zero Trust apontando o subdomínio para `http://localhost:8880`.
   - Instale o serviço `cloudflared` na VM:
     ```bash
     sudo cloudflared service install <SEU_TOKEN>
     ```

2. **Chamadas de Voz e Compartilhamento de Tela (LiveKit)**:
   - Redirecione as portas no seu roteador para o IP local da VM:
     - **UDP**: `50000` a `50100`
     - **TCP**: `7881`

---

## 🔒 Segurança

- Arquivos de credenciais locais (`terraform.tfvars`, chaves privadas e arquivos de estado `.tfstate`) estão devidamente ignorados no `.gitignore`.
- Segredos criptográficos do Stoat (VAPID, chaves de encriptação e tokens LiveKit) são gerados dinamicamente na máquina de destino via OpenSSL.
