---
tags: [jira, backlog, devops, epics, tasks]
description: Estrutura de Backlog (Épicos e Tasks) para importação ou criação manual no Jira.
type: work
---
# 📋 Backlog de Implantação: Hub DevOps

Este documento contém a estrutura pronta para ser levada ao Jira, organizada por Épicos e Tasks, com estimativas de esforço (Story Points ou Dias).

## 🏢 Projeto Jira Sugerido
- **Tipo**: Jira Software (Company-managed)
- **Template**: Kanban
- **Recurso Ativo**: Timeline (Roadmap)

---

## 🚀 Estrutura Ágil (Épico e Sprints)

### 👑 ÉPICO CENTRAL: [PROJETO] Implantação Hub DevOps & Padronização
*Objetivo Geral: Criar o Hub de Automação, estabelecer governança e migrar projetos iniciais.*
*(Todas as tarefas abaixo devem ser vinculadas a este Épico).*

---

### 🏃‍♂️ SPRINT 01: Fundação & Zero Trust Security
*Duração estimada: 10 dias (1 Sprint)*

| ID | Tarefa (Summary) | Descrição (Description) | Esforço (Days) |
| :--- | :--- | :--- | :--- |
| T01.2 | Provisionamento IaC (Terraform) | Criação de Droplet, VPC, Firewall e Reserved IP via scripts. | 3 |
| T01.3 | Configuração & Hardening (Ansible) | Playbook para Docker, Fail2ban, UFW e desativação de root. | 2 |
| T01.4 | Setup Cloudflare Tunnel | Criação do túnel seguro para eliminar necessidade de portas abertas. | 1 |
| T01.5 | Ingress Controller (Traefik) | Configuração do roteador de tráfego interno com SSL Automático. | 1 |
| T01.6 | Políticas Cloudflare Access | Configuração de SSO/MFA para proteger acesso às ferramentas. | 1 |
| T01.7 | Acesso administrativo HUB | Conceder acesso administrativo ao HUB apenas para o time de Devops via VPN | 2 |

### 🏃‍♂️ SPRINT 02: Piloto CI/CD & Automação (Ideal Plus)
*Duração estimada: 13,5 dias (1 a 2 Sprints)*

| ID | Tarefa (Summary) | Descrição (Description) | Esforço (Days) |
| :--- | :--- | :--- | :--- |
| T02.1 | Jenkins Core Setup | Instalação Dockerizada, configuração de Nodes e Plugins. | 2 |
| T02.2 | Governança Bitbucket (Piloto) | Bloqueio de branches fixas e regras de merge (PR obrigatório). | 0,5 |
| T02.3 | Setup Ambientes Segregados | Configuração de Prod e Homolog (com htpasswd) no servidor destino. | 1 |
| T02.4 | Pipeline CI/CD (Jenkinsfile) | Desenvolvimento da esteira: Build -> Unit Tests -> Linter -> Deploy. | 2 |
| T02.5 | Automação Backups Pré-Deploy | Integração de DB Dump e Backup de arquivos na pipeline Jenkins. | 1 |
| T02.6 | Implementação Deploy Atômico | Migração para estrutura de Symlinks para Rollback instantâneo. | 1 |
| T02.7 | Botão Rollback e Health Check | Configuração do Job de Rollback e Health Check Pós-Deploy. | 2 |
| T02.8 | Workshop Técnico Squad Piloto | Treinamento sobre Gitflow, Commits e uso da nova Pipeline. | 2 |
| T02.9 | Sustentação das automações | Garantir que as automações e fluxos estão de acordo com o esperado e prestar suporte | 2 |

### 🏃‍♂️ SPRINT 03: Monitoramento e Observabilidade (PoC)
*Duração estimada: 10 dias (1 Sprint)*

| ID | Tarefa (Summary) | Descrição (Description) | Esforço (Days) |
| :--- | :--- | :--- | :--- |
| T03.1 | Monitoramento Saúde (Zabbix) | Configuração de templates de monitoramento de host e containers. | 4 |
| T03.2 | Dashboard Visibilidade (Grafana) | Criação de painéis visuais para monitorar tráfego e saúde do Hub. | 3 |
| T03.3 | Alertas em Mensageiros (Slack, Discord) | Criação de Alertas de acordo com o nossos thresholds internos | 1 |
| T03.4 | Sustentação dos monitoramentos | Garantir que os alertas e monitoramentos estão de acordo com o esperado | 2 |

### 🏃‍♂️ SPRINT 04: Governança & Padronização Jira-Bitbucket
*Duração estimada: 13 dias (1 a 2 Sprints)*

| ID | Tarefa (Summary) | Descrição (Description) | Esforço (Days) |
| :--- | :--- | :--- | :--- |
| T04.1 | Perfil de Governança | Criar um email corporativo com a resposabilidade de governança centralizada | 0,5 |
| T04.2 | Centralização de SSH Keys | Migração de chaves para conta devops@ e remoção de chaves pessoais. | 0,5 |
| T04.3 | Organização Ambiente Bitbucket | Segregar nivel de acesso, projetos e repositorios | 1 |
| T04.4 | Formulário Onboarding Jira | Criação de Issue Type e Formulário para novas requisições de infra. | 2 |
| T04.5 | Scaffolding de Repositórios | Criação de templates (Laravel/Node) para novos projetos "dia 1". | 1 |
| T04.6 | Workshop POs | Apresentação da nova estrutura, padronização e automações no geral | 2 |
| T04.7 | Workshop Técnico | Apresentação da nova estrutura, gitflow, ci/cd, pipelines, monitoramento | 2 |
| T04.8 | Sustentação Geral | Garantir que todas as pontas estão funcionando como esperado | 4 |

### 🏃‍♂️ SPRINT 05: Mapeamento de Projetos e Migração
*Duração estimada: 9 dias (1 Sprint)*

| ID | Tarefa (Summary) | Descrição (Description) | Esforço (Days) |
| :--- | :--- | :--- | :--- |
| T05.1 | Identificar Projetos ativos | Validar com cada Stakeholder ou PO o funcionamento dos sistemas | 3 |
| T05.2 | Organização Projetos ativos | Movimentar e organizar repositorios dentros dos respectivos projetos | 1 |
| T05.3 | Inventário de servidores por família | Inventário de Infraestrutura e Padronização de Hosts por Empresa | 3 |
| T05.4 | Plano de Ação Migração Legados | Criar um plano de ação para a migração de sistemas legados | 2 |

---

## 📥 Como configurar no Jira?

1.  **Criação do Épico Central**: No seu projeto Jira (DevOps), crie manualmente um Épico chamado `[PROJETO] Implantação Hub DevOps & Padronização`.
2.  **Criação das Sprints**: No Backlog do projeto, crie 5 Sprints vazias (ex: `Sprint 01: Fundação`, `Sprint 02: Piloto`, etc.).
3.  **Importação de Tarefas via CSV**:
    *   Copie as tabelas acima para o Excel e salve como CSV.
    *   No Jira, vá em *System -> External System Import -> CSV*.
    *   Mapeie: `Tarefa` -> Summary, `Descrição` -> Description, `Esforço` -> Story Points / Original Estimate.
4.  **Vínculo e Planejamento**:
    *   No board (visão de Backlog), selecione todas as tarefas recém-importadas e vincule-as ao Épico central criado no passo 1.
    *   Arraste as tarefas correspondentes (ex: T01.x) para dentro da `Sprint 01`, e assim por diante para montar a sua esteira de Sprints.
