---
tags: [devops, roadmap, planning, ci-cd, infrastructure]
description: Plano de implantação completo para a nova infraestrutura DevOps.
type: work
---

# 🚀 Plano de Implantação: CI/CD, Jumphost e Padronização Infra

Este documento detalha a estratégia para organizar e profissionalizar a estrutura de trabalho, implementando padrões de mercado e automação robusta.

## 📋 Objetivos Principais
- **Padronização**: Organizar Jira e Bitbucket sob uma governança clara.
- **Segurança**: Centralizar acessos via Jumphost (Bastion).
- **Automação**: Implementar pipelines CI/CD com Jenkins para Homologação e Produção.
- **Observabilidade**: Centralizar métricas com Grafana.
- **Segregação**: Organizar servidores por "Família" ou Grupo.

---

## 🛠️ Fase 1: Governança e Padronização (Jira & Bitbucket)

### 1.1. Estrutura do Jira
- **Projetos por Família**: Criar ou ajustar projetos para refletir os grupos (Ex: `FAM-A`, `FAM-B`, `INFRA`, `INTERNAL`).
- **Workflows**: Padronizar estados (To Do, In Progress, Review, QA, Done).
- **Issue Type "Infra/DevOps"**: Criar um tipo de tarefa específico para solicitações de ambiente, banco de dados ou acessos.
- **Responsabilidade Direta**: Toda tarefa de infra deve ser atribuída ao responsável de DevOps dentro do board do próprio projeto, garantindo visibilidade para a Squad.
- **Automação**: Integrar Jira com Bitbucket para transição automática de tickets baseada em PRs e Commits.

### 1.2. Estrutura do Bitbucket
- **Projetos (Groups)**: Seguir o padrão documentado em [[31_Gitflow/Bitbucket-Standards|Bitbucket Standards]].
- **Permissões**: Implementar Branch Permissions (bloquear push na `main` e `develop`).
- **Templates**: Criar repositórios de "Scaffolding" (Node.js, PHP, Python) já com Dockerfile e Jenkinsfile integrados.

---

## 🏗️ Fase 2: Implementação Detalhada (Checklist)

Abaixo, a lista de pontos críticos que serão validados e implementados após aprovação:

### 2.1. Infraestrutura e Acessos
- [ ] **Configuração do Servidor (Jumphost)**: Instalação do OS, Hardening e firewall.
- [ ] **Acesso Centralizado (Guacamole)**: Implementação do Guacamole como portal único de acesso a hosts.
- [ ] **Revogação de Privilégios**: Remover acessos root diretos; implementar sudo com auditoria.
- [ ] **Proteção de Homologação**: Configurar **htpasswd** em todos os ambientes de homologação.
- [ ] **Organização de SSHs**: Padronização e centralização de chaves no Bitbucket (Access Keys).
- [ ] **Separação por Famílias**: Segregação física/lógica de Prod e Homolog.

### 2.2. Ferramentas (Jenkins, Grafana & Zabbix)
- [ ] **Configuração do Jenkins**: Instalação via Docker, segurança (RBAC) e Nodes.
- [ ] **Integração Jira-Bitbucket**: Garantir que cada commit apareça no card do Jira correspondente.
- [ ] **Configuração do Zabbix & Grafana**: Monitoramento de saúde e observabilidade.
- [ ] **Alertas**: Notificações automáticas no Slack/Discord sobre status de deploy.

### 2.3. Padronização e Governança
- [ ] **Governança de Stack**: Laravel (Core/Sistemas) e Typescript (PoCs/IA).
- [ ] **Bitbucket Standards**: Ajuste de nomenclatura de repos e projetos por família.
- [ ] **Commit & Tag Convention**: Workshops de **Conventional Commits** e versionamento semântico.
- [ ] **Cultura de Versionamento**: Estabelecer obrigatoriedade de repositório desde o dia 1 do projeto.

### 2.4. Treinamento e Cultura
- [ ] **Workshop 1**: Gitflow, Commits e Vínculo Jira-Bitbucket.
- [ ] **Workshop 2**: Deploy via Jenkins e uso do ambiente de Homologação.
- [ ] **Guia de Solicitação**: Processo formal para novos projetos e ambientes.

---

## 📝 Processo de Solicitação (Onboarding)

Para cada novo projeto ou necessidade de infra, o fluxo deve ser:
1. **Abertura de Ticket no Jira**: Criar tarefa do tipo "Infra/DevOps" no board do projeto.
2. **Atribuição**: Marcar o responsável por DevOps.
3. **Preenchimento do Questionário**: Incluir no ticket as informações:
    - **Nome do Sistema/Domínio**: (Ex: `idealplus.idealtrends.io`)
    - **Stack Técnica**: (Laravel, Node.js, React, etc.)
    - **Repositórios Necessários**: (API, Frontend, Microservices)
    - **Ambientes**: (Apenas Homolog? Prod também?)
    - **Integrações**: (Precisa de banco de dados, Redis, S3?)
    - **Time de Acesso**: (Quais usuários precisam de acesso ao Bitbucket?)

*Benefício: Previsibilidade total da configuração e rastreabilidade da demanda.*

---

## 🔄 Fase 3: Prova de Conceito (PoC) - Projeto Ideal Plus

O projeto **Ideal Plus** será o laboratório para validar:
1. **Migração do Código**: De local para Bitbucket (se necessário).
2. **Setup de Ambientes**: Criar Homolog (com htpasswd) e Prod segregados.
3. **Pipeline**: Jenkinsfile rodando testes e deploy automático.

---

## 📅 Cronograma & Checklist de Execução
*Acompanhamento passo a passo do projeto.*

### 🛠️ Semana 1: Fundação & Infraestrutura Central
- [ ] **IaC Provisioning (Terraform)**: Script para criar Droplet na Digital Ocean, configurar VPC e Firewall rules.
- [ ] **Configuração Automatizada (Ansible)**: Playbook para instalação de Docker, Jenkins, Zabbix e Hardening do OS.
- [ ] **Hardening Inicial**: Configuração de fail2ban e desativação de login root via SSH (integrado ao Ansible).
- [ ] **Stack de Gestão**: 
    - [ ] Deploy Jenkins (Container via Ansible).
    - [ ] Deploy Zabbix & Grafana (Container via Ansible).
    - [ ] Deploy Apache Guacamole (Portal de Acesso).
- [ ] **Governança Bitbucket**:
    - [ ] Criação do e-mail central: `devops@idealtrends.com.br`.
    - [ ] Migração de SSH keys de servidores para a conta central.
    - [ ] Limpeza de chaves SSH legadas do Workspace.

### 🧪 Semana 2: PoC & Pipeline (Projeto Ideal Plus)
- [ ] **Setup do Repositório**: Aplicar nomenclatura `deploy.idealplus.idealtrends.io`.
- [ ] **Gitflow Enforcement**: Bloqueio de branches `main` e `develop` no Bitbucket.
- [ ] **Jenkins Pipeline**:
    - [ ] Escrita do `Jenkinsfile` com estágios: Build -> Unit Tests -> Linter.
    - [ ] Configuração de Webhooks Bitbucket -> Jenkins.
    - [ ] Automação de Deploy em Homolog (via Develop merge).
- [ ] **Segurança de Homolog**: Implementação de `htpasswd` no servidor de destino.

### 🔐 Semana 3: Padronização & Integração Jira
- [ ] **Vínculo Jira-Bitbucket**: Configurar aplicação de link para que commits com ID (ex: `INCE-123`) apareçam nos cards.
- [ ] **Famílias de Servidores**:
    - [ ] Mapeamento e inventário de servidores por "Empresa".
    - [ ] Padronização de nomes de hosts e organização no inventário.
- [ ] **Scaffolding de Projetos**:
    - [ ] Criação de repositório "Template Laravel" com Docker, CI/CD e Padrões de Commit inclusos.
    - [ ] Documentação do processo de solicitação de novo projeto.

### 🎓 Semana 4: Treinamento & Rollout
- [ ] **Workshop de Equipe**:
    - [ ] Treinamento em **Conventional Commits** e **Gitflow**.
    - [ ] Demonstração do fluxo de PR e aprovação técnica.
- [ ] **Dashboards de Observabilidade**:
    - [ ] Configuração de painéis no Grafana para saúde dos servidores.
    - [ ] Alertas de falha de deploy no Slack/Discord.
- [ ] **Rollout Geral**: Início da migração gradativa dos demais sistemas para o novo padrão.

---
> [!IMPORTANT]
> A conclusão de cada tarefa deve ser documentada nos respectivos arquivos de referência em `brain/30_Work/`.

---
> [!NOTE]
> Este plano foi atualizado com a inclusão do Zabbix e o projeto Ideal Plus como PoC em 30/04.
