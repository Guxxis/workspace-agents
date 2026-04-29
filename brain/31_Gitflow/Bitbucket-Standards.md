---
tags: [bitbucket, standards, git, infrastructure, organization]
description: Padronização de nomenclatura, acessos e chaves SSH para o Bitbucket.
type: work
---

# 🏗️ Bitbucket Standards & Organization

Este documento define os padrões de governança para o workspace do Bitbucket, garantindo organização, segurança e automação eficiente.

## 1. Nomenclatura de Projetos (Groups)
Os projetos no Bitbucket devem ser usados para agrupar repositórios por unidade de negócio ou squad.

| Projeto | Key | Descrição |
| :--- | :--- | :--- |
| **Ince** | `INCE` | Projetos relacionados ao ecossistema Ince. |
| **Soin** | `SOIN` | Projetos relacionados ao ecossistema Soin. |
| **Infrastructure** | `INFRA` | Repositórios de IaC, scripts de automação e ferramentas DevOps. |
| **Labs** | `LABS` | Projetos em fase de prova de conceito (PoC). |

## 2. Nomenclatura de Repositórios
Todos os repositórios devem seguir o padrão **kebab-case** (letras minúsculas separadas por hífen).

**Padrão:** `[squad]-[nome-do-app]-[tipo]`

- **Squads**: `in` (Ince), `so` (Soin), `it` (Ideal Trends).
- **Tipos**: `api`, `frontend`, `mobile`, `worker`, `docs`, `iac`.
- **Exemplos**:
    - `in-checkout-api`
    - `so-dashboard-frontend`
    - `it-automation-scripts`

## 3. Organização de Acessos
O acesso deve ser gerenciado via **User Groups** para evitar permissões individuais.

- **`Admins`**: Acesso total (CTO / DevOps Leads).
- **`Developers`**: Acesso de escrita e criação de branches. Merge bloqueado sem PR.
- **`QA / Viewers`**: Acesso apenas de leitura para auditoria e testes.

## 4. Gestão de Chaves SSH
Para segurança e rastreabilidade, seguimos estas regras:

### 4.1. Chaves Pessoais
- Cada desenvolvedor deve usar sua própria chave SSH.
- **Identificação**: O label da chave deve ser `nome.sobrenome@empresa`.

### 4.2. Access Keys (Deployment Keys)
- Usadas para automação (Pipelines, Servidores).
- **Escopo**: Use chaves com acesso apenas de leitura (Read-only) nos servidores de produção.
- **Identificação**: O label deve indicar o servidor e ambiente. Ex: `deploy-dsw-mkt01-prod`.

---
> [!TIP]
> Use o [[31_Gitflow/Tag-Convention|Tag Convention]] e [[31_Gitflow/Commit-Convention|Commit Convention]] em conjunto com estes padrões para manter o histórico do repositório limpo.
