---
tags: [devops, roadmap, detalhado, backup, rollback]
description: Cronograma detalhado item a item para a implantação do Hub de Automação e Padronização.
type: work
---
# 🗺️ Roadmap Detalhado: Implantação DevOps (8 Semanas)

Este documento detalha cada etapa, descrição técnica e prazos para a modernização da infraestrutura, conforme aprovado pela liderança.

## 📅 Mês 1: Fundação e Prova de Conceito (PoC)

### Etapa 1: Provisionamento e Segurança Zero Trust
**Prazo:** Semana 1 e 2
- **Descrição:** Criação da infraestrutura core onde todas as ferramentas residirão.
- **Itens Detalhados:**
    1. **IaC Provisioning:** Criar scripts Terraform para subir o Droplet na Digital Ocean, configurar VPC e Firewall (bloqueio total de portas externas).
    2. **Configuração via Ansible:** Playbook para instalar Docker, Docker Compose e realizar o Hardening do SO (Remover root SSH, fail2ban).
    3. **Cloudflare Zero Trust (Tunnel):** Instalação do `cloudflared` para criar o túnel seguro. O servidor não terá IP público acessível.
    4. **Ingress Controller (Traefik):** Configuração do Traefik para gerenciar subdomínios internos com SSL automático.
    5. **Acesso Seguro:** Configuração do Cloudflare Access (SSO com e-mail corporativo) para proteger a entrada das ferramentas.

### Etapa 2: Automação e Projeto Piloto (Ideal Plus)
**Prazo:** Semana 3 e 4
- **Descrição:** Implementação da esteira CI/CD no primeiro projeto real para validar o modelo.
- **Itens Detalhados:**
    1. **Jenkins Setup:** Instalação e configuração de Plugins (Bitbucket, Jira, Pipeline, Slack).
    2. **Gitflow Enforcement:** Configuração de permissões no Bitbucket do projeto Ideal Plus (Main/Develop bloqueadas).
    3. **Jenkinsfile PoC:** Criação da pipeline com estágios: `Build` -> `Tests` -> `Deploy Homolog`.
    4. **Segregação de Ambientes:** Configuração física de Homolog e Produção para o projeto Ideal Plus, garantindo que homolog tenha proteção `htpasswd`.
    5. **Workshop Técnico 01:** Treinamento prático com os desenvolvedores do Ideal Plus sobre como usar o novo fluxo.

---

## 📅 Mês 2: Governança, Rollback e Expansão

### Etapa 3: Governança de Código e Integração Jira
**Prazo:** Semana 5 e 6
- **Descrição:** Organização total do workspace e integração entre as ferramentas de gestão.
- **Itens Detalhados:**
    1. **E-mail Central DevOps:** Criação da conta `devops@idealtrends.com.br` e centralização de todas as SSH Keys de servidores nesta conta.
    2. **Limpeza de SSHs:** Auditoria e remoção de todas as chaves SSH pessoais dos servidores de aplicação, forçando o uso do Hub/Guacamole.
    3. **Integração Jira-Bitbucket:** Configurar o DVCS no Jira para que commits e PRs apareçam dentro dos cards de tarefa.
    4. **Formulário de Onboarding (Jira):** Criar o formulário padrão para novos projetos, capturando stack, ambientes e acessos necessários.
    5. **Scaffolding Repos:** Criação de repositórios "Template" (Laravel/Node) com Jenkinsfile e Dockerfile já padronizados.

### Etapa 4: Observabilidade e Estratégia de Rollback
**Prazo:** Semana 7 e 8
- **Descrição:** Implementação de monitoramento e garantia de disponibilidade com plano de desastre.
- **Itens Detalhados:**
    1. **Zabbix & Grafana:** Deploy dos containers e configuração de dashboards de saúde dos servidores (CPU, Disco, RAM, HTTP Status).
    2. **Alertas:** Integração de alertas críticos via Slack/Discord.
    3. **Ciclo de Backup e Rollback (Produção):**
        - **Pré-Deploy Backup:** Toda pipeline de produção deve realizar um Snapshot automático (ou dump de DB + Rsync de arquivos) antes de alterar o código.
        - **Atomic Deployment:** Implementação de deploy via Symlink (Pasta `current` aponta para `releases/timestamp`).
        - **Botão de Rollback:** Criação de um job no Jenkins que permite ao DevOps voltar para a versão anterior em menos de 60 segundos com um clique.
    4. **Workshop Geral:** Apresentação dos resultados para todo o time de Devs e POs.
    5. **Rollout Final:** Início da migração dos demais projetos (MPI, Busca Cliente, etc) para o novo padrão.

---

## 🔄 Estratégia de Backup & Rollback (Detalhamento)

Para garantir a segurança das operações em produção, o ciclo de deploy seguirá este padrão técnico:

1. **TRIGGER:** Merge em `main` ou criação de `Tag`.
2. **BACKUP STAGE:** 
   - O Jenkins executa um dump do banco de dados para um volume de backup persistente.
   - O Jenkins cria uma cópia da pasta da aplicação atual antes de baixar o novo código.
3. **DEPLOY STAGE:** O novo código é baixado em uma pasta nova (ex: `/var/www/releases/202605041600`).
4. **SWITCH STAGE:** O link simbólico `/var/www/html` é atualizado para apontar para a nova pasta.
5. **HEALTH CHECK:** O Jenkins testa se o site retornou status 200.
6. **ROLLBACK AUTOMÁTICO:** Se o Health Check falhar, o Jenkins volta o link simbólico para a pasta anterior e restaura o banco de dados imediatamente.

---
> [!IMPORTANT]
> Este plano detalhado serve como base para o acompanhamento semanal com a liderança. Cada etapa concluída deve ser reportada com as métricas de ganho obtidas.
