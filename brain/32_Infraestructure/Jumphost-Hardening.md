---
tags: [security, devops, infra, jumphost, hardening]
description: Arquitetura de segurança, hardening e gestão de acessos para o servidor Jumphost (Bastion).
type: work
---

# 🛡️ Arquitetura de Segurança: Jumphost (Bastion Server)

Este documento define os padrões de segurança e *hardening* para o servidor Jumphost. Como ele possui acesso (porta 22) para todos os servidores da infraestrutura (Produção e Homologação), ele é um ativo crítico.

## 1. Princípio de Zero Portas Abertas (Inbound)

O firewall da Cloud (Digital Ocean) deve ser configurado com **Default Deny** para Inbound. Nenhuma porta deve ser exposta para a internet pública.

### 1.1 Acesso aos Painéis (Jenkins e Grafana)
- **Tecnologia:** Cloudflare Tunnels (Zero Trust).
- **Como Funciona:** O agente `cloudflared` roda no Jumphost e abre uma conexão *outbound* para a Cloudflare.
- **Camada de Proteção:** O acesso a `jenkins.idealtrends.com` passa por um Cloudflare Access Application, exigindo 2FA (SSO do Google/Microsoft ou OTP por e-mail) antes de expor a interface HTTP das ferramentas.

### 1.2 Acesso SSH Administrativo
- **Tecnologia:** Tailscale (WireGuard Mesh VPN).
- **Como Funciona:** O acesso SSH só é permitido através do IP virtual da VPN.
- **Configuração SSH:** O `sshd_config` deve conter `ListenAddress <IP_DO_TAILSCALE>` para garantir que a porta 22 não escute na interface pública (`eth0`).

## 2. Hardening do Sistema Operacional

As seguintes configurações devem ser aplicadas automaticamente via **Ansible**:

- **Autenticação:**
  - `PasswordAuthentication no` (Acesso exclusivo por par de chaves).
  - `PermitRootLogin no` (Proibido o uso do usuário root).
- **Firewall Local (UFW):**
  - `ufw default deny incoming`
  - `ufw default allow outgoing`
  - `ufw allow in on tailscale0 to any port 22`
- **Auditoria:**
  - Logs de autenticação enviados para um sistema centralizado ou mantidos em retenção para auditoria.

## 3. Gestão de Chaves e Acessos

**Regra de Ouro:** Chaves privadas com privilégios administrativos **nunca** devem ser armazenadas no disco do Jumphost.

### 3.1 Acesso Humano (Sysadmins/DevOps)
- Administradores conectam-se usando a técnica de **ProxyJump**.
- Comando: `ssh -J devops@jumphost usuario@servidor-producao`.
- A chave privada permanece apenas na máquina física do administrador. O Jumphost atua apenas como túnel TCP seguro.

### 3.2 Acesso de Máquina (Jenkins CI/CD)
- O Jenkins precisará de chaves SSH para executar deploys em servidores remotos.
- **Mitigação de Risco:** 
  - As chaves do Jenkins devem acessar um usuário estritamente restrito (ex: `deployer`) nos servidores de destino.
  - O usuário `deployer` não deve ter permissão de `sudo` genérico, podendo rodar apenas os comandos exatos de restart da aplicação (ex: `sudo systemctl restart api`).

## 4. Análise de Riscos e Contingência

| Risco | Impacto | Mitigação |
| :--- | :--- | :--- |
| **SPOF (Ponto Único de Falha)** | Queda do Jumphost impede deploys e acessos. | Infraestrutura como Código (Terraform/Ansible) atualizada para reconstrução do servidor em < 10 minutos. |
| **Vazamento do Jenkins** | Invasor consegue acesso à interface do Jenkins e roda jobs maliciosos. | Proteção do Cloudflare Access impedindo acessos não autorizados. Bloqueio no Bitbucket impedindo injeção de código não revisado (Gitflow). |
| **Ransomware / Worm Lateral** | Invasor toma controle OS do Jumphost e tenta pular para Produção. | Restrição de UFW de saída. O Jumphost só tem permissão de falar nas portas estritamente necessárias das famílias de servidores (ex: 22). |
