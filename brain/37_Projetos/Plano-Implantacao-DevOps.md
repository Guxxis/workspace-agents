---
tags: [devops, roadmap, planning, ci-cd, infrastructure]
description: Plano de implantação completo para a nova infraestrutura DevOps.
type: work
---

# 🚀 Plano de Implantação: Hub de Automação CI/CD e Padronização Infra

Este documento detalha a estratégia para organizar e profissionalizar a estrutura de trabalho, implementando padrões de mercado e automação robusta.

## 📋 Objetivos Principais
- **Padronização**: Organizar Jira e Bitbucket sob uma governança clara.
- **Segurança & Orquestração**: Centralizar a automação no **Hub de Automação (DevOps Toolkit)**.
- **Automação**: Implementar pipelines CI/CD com Jenkins para Homologação e Produção.
- **Observabilidade**: Centralizar métricas com Grafana (Cloud e Local).
- **Resiliência**: Implementar ciclo de Backup/Rollback automático em cada deploy de produção.
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

### 2.1. Infraestrutura e Acessos (Hub DevOps)
- [x] **Configuração da Central (DevOps Toolkit)**: Instalação do OS (Digital Ocean), Hardening e firewall via Terraform/Ansible.
- [x] **Acesso Administrativo**: Garantir acesso seguro ao Hub apenas para o time de DevOps.
- [x] **Revogação de Privilégios**: Remover acessos root diretos nos servidores de aplicação; implementar sudo com auditoria.
- [x] **Proteção de Homologação**: Configurar **htpasswd** em todos os ambientes de homologação.
- [x] **Organização de SSHs**: Padronização e centralização de chaves no Bitbucket e no Hub DevOps.
- [ ] **Separação por Famílias**: Segregação física/lógica de Prod e Homolog.

### 2.2. Ferramentas (Jenkins, Grafana & Zabbix)
- [x] **Configuração do Jenkins**: Instalação via Docker, segurança (RBAC) e Nodes.
- [x] **Integração Jira-Bitbucket**: Garantir que cada commit apareça no card do Jira correspondente.
- [x] **Configuração do Zabbix & Grafana**: Monitoramento de saúde e observabilidade.
- [x] **Alertas**: Notificações automáticas no Slack/Discord sobre status de deploy.

### 2.3. Padronização e Governança
- [x] **Governança de Stack**: Laravel (Core/Sistemas) e Typescript (PoCs/IA).
- [x] **Bitbucket Standards**: Ajuste de nomenclatura de repos e projetos por família.
- [x] **Commit & Tag Convention**: Workshops de **Conventional Commits** e versionamento semântico.
- [x] **Cultura de Versionamento**: Estabelecer obrigatoriedade de repositório desde o dia 1 do projeto.

### 2.4. Treinamento e Cultura
- [x] **Workshop 1**: Gitflow, Commits e Vínculo Jira-Bitbucket.
- [x] **Workshop 2**: Deploy via Jenkins e uso do ambiente de Homologação.
- [x] **Guia de Solicitação**: Processo formal para novos projetos e ambientes.

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
4. **Ciclo de Rollback**: Validar a reversão de versão em < 60 segundos.

---

## 🔄 Estratégia de Backup & Rollback (Produção)

Para garantir a continuidade do negócio, todo deploy em produção seguirá o fluxo de segurança:
1. **Snapshot Pré-Deploy**: Dump automático do Banco de Dados e backup dos arquivos atuais.
2. **Atomic Symlink**: Deploy em pastas datadas; o servidor aponta apenas para a versão estável.
3. **Health Check Post-Deploy**: Se o sistema não responder 200 OK após o deploy, o rollback é automático.
4. **Manual Trigger**: Botão no Jenkins para "Rollback para Versão Anterior" acessível ao DevOps.

---

## 📅 Cronograma & Checklist de Execução (2 Meses)
*Acompanhamento passo a passo do projeto, focado na entrega rápida de valor.*

### 🚀 Mês 1: Infraestrutura Core e Prova de Conceito (PoC)

#### 🛠️ Semanas 1 e 2: Fundação & Setup Inicial
- [x] **IaC Provisioning (Terraform)**: Script para criar Droplet na Digital Ocean, configurar VPC e Firewall rules.
- [x] **Configuração Automatizada (Ansible)**: Playbook para instalação de Docker, Jenkins e Hardening do OS *(Nota: Monitoramento inicial será via agente nativo da Digital Ocean)*.
- [x] **Hardening Inicial**: Configuração de fail2ban e desativação de login root via SSH (integrado ao Ansible).
- [x] **Stack de Gestão**: 
    - [x] Deploy Jenkins (Container via Ansible).
    - [x] Deploy do Hub de Operações (Toolkit para Ansible e Scripts).

#### 🧪 Semana 3: O Piloto (PoC - Ideal Plus)
- [x] **Setup do Repositório**: Aplicar nomenclatura `deploy.idealplus.idealtrends.io`.
- [x] **Gitflow Enforcement**: Bloqueio de branches `main` e `develop` no Bitbucket.
- [x] **Jenkins Pipeline**:
    - [x] Escrita do `Jenkinsfile` com estágios: Build -> Unit Tests -> Linter.
    - [x] Configuração de Webhooks Bitbucket -> Jenkins.
    - [x] Automação de Deploy em Homolog (via Develop merge).
- [x] **Segurança de Homolog**: Implementação de `htpasswd` no servidor de destino.

#### 🎓 Semana 4: Validação & Workshop Intermediário
- [x] **Workshop Focado (PoC)**:
    - [x] Alinhamento prático sobre **Gitflow** e **Commits** estritamente com os devs envolvidos na PoC.
    - [x] Demonstração do fluxo de aprovação de PR e acompanhamento do Pipeline.
- [x] **Ajustes Finos**: Refinamento da esteira CI/CD baseado nos primeiros feedbacks de uso real.

---

### 📈 Mês 2: Governança, Observabilidade e Expansão

#### 🔐 Semanas 5 e 6: Padronização & Integração Jira
- [x] **Governança Bitbucket**:
    - [x] Criação do e-mail central: `devops@idealtrends.com.br`.
    - [x] Migração de SSH keys de servidores para a conta central.
    - [x] Limpeza de chaves SSH legadas do Workspace.
- [x] **Vínculo Jira-Bitbucket**: Configurar aplicação de link para que commits com ID (ex: `INCE-123`) apareçam nos cards.
- [x] **Scaffolding de Projetos**:
    - [x] Criação de repositório "Template Laravel" com Docker, CI/CD e Padrões de Commit inclusos.
    - [x] Documentação do processo de solicitação de novo projeto.

#### 📊 Semana 7: Observabilidade Avançada & Famílias
- [x] **Famílias de Servidores**:
    - [x] Mapeamento e inventário de servidores por "Empresa".
    - [x] Padronização de nomes de hosts e organização no inventário.
- [x] **Monitoramento Adicional (Opcional)**:
    - [x] Deploy Zabbix & Grafana para métricas avançadas que a Digital Ocean não cobre.
    - [x] Configuração de Alertas de falha de deploy no Slack/Discord.

#### 🌐 Semana 8: Treinamento Geral & Rollout
- [x] **Workshop Geral**:
    - [x] Apresentação final para **todos os Devs e POs do time**.
    - [x] Apresentação dos resultados e ganhos da PoC.
- [x] **Rollout Geral**: Início da migração gradativa dos demais sistemas (MPI, Busca Cliente, etc.) para o novo padrão.

---
> [!IMPORTANT]
> A conclusão de cada tarefa deve ser documentada nos respectivos arquivos de referência em `brain/30_Work/`.

---
> [!NOTE]
> Este plano foi atualizado para uma janela de 2 meses, focando o 1º mês na PoC e Infra Base, deixando Governança e Observabilidade Avançada para o 2º mês.
