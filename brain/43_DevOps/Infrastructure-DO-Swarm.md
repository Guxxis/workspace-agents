---
tags: [devops, infra, digital-ocean, docker-swarm]
description: Guia de infraestrutura utilizando Docker Swarm na Digital Ocean.
type: work
---
# 🐳 Infraestrutura: Digital Ocean & Swarm

## 🏗️ Orquestração: Docker Swarm
Optamos pelo Swarm pela simplicidade em comparação ao Kubernetes, mantendo a capacidade de alta disponibilidade e deploys sem downtime.

### Componentes Chave:
- **Reverse Proxy**: **Traefik** (SSL Automático via Let's Encrypt).
- **Registry**: Docker Hub ou GHCR.
- **Nodes**: Início com 1 Single-Node Cluster (Droplet DO).

---

## 🔒 Hardening do Servidor
1. **Firewall (UFW)**: Portas 22, 80, 443 liberadas.
2. **SSH**: Desativar login por senha, permitir apenas chaves.
3. **Updates**: Unattended-upgrades para patches de segurança.

---

## 📈 Escalabilidade
A arquitetura Multi-Tenant permite que, ao adicionar novos clientes, apenas criemos novos containers de Frontend no Swarm, todos apontando para o mesmo serviço de Backend (Java).
