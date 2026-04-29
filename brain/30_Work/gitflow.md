---
tags: [git, gitflow, ci-cd, bitbucket, jira]
description: Definição do fluxo de trabalho de Git Flow integrado ao CI/CD e JIRA.
type: work
---

# Git Flow & CI/CD Documentation

Este documento define o padrão de desenvolvimento, versionamento e automação para os projetos da Ideal Trends, utilizando **Git Flow** integrado ao **Bitbucket Pipelines** e **JIRA**.

## 1. Estrutura de Branches

As branches devem seguir rigorosamente a nomenclatura abaixo para garantir a integração com o JIRA (`INCE`) e gatilhos de pipeline.

| Branch | Origem | Destino | Descrição |
| :--- | :--- | :--- | :--- |
| `main` | - | - | Código estável em produção. |
| `develop` | `main` | - | Código em estágio de integração/homologação (Staging). |
| `feature/*` | `develop` | `develop` | Novas funcionalidades. Ex: `feature/INCE-123-login-social` |
| `bugfix/*` | `develop` | `develop` | Correções de bugs em desenvolvimento. |
| `release/*` | `develop` | `main` & `develop` | Preparação para produção. Ex: `release/INCE-456-v1.1.0` |
| `hotfix/*` | `main` | `main` & `develop` | Correções críticas em produção. Ex: `hotfix/INCE-999-v1.1.1` |

## 2. Ciclo de Vida do Desenvolvimento

### 2.1. Iniciando uma Tarefa (Feature)
1.  Crie uma branch a partir da `develop`.
2.  **Nomeclatura**: `feature/INCE-XXX-descricao`. O prefixo `INCE-XXX` é vital para o JIRA.
3.  Desenvolva e realize commits seguindo a [Commit Convention](file:///c:/Users/gustavo.goncalves/projetos/workspace/brain/90_Templates/Commit-Convention.md).

### 2.2. Integração (Pull Request para Develop)
1.  Ao finalizar a feature, abra um PR para a branch `develop`.
2.  **Pipeline**: O gatilho `pullrequest-created` ativará automaticamente os **Testes Unitários**.
3.  Após aprovação e sucesso dos testes, realize o merge.
4.  O merge para `develop` dispara o **Deploy em Staging (Homologação)**.

### 2.3. Lançamento (Release)
1.  Quando a `develop` estiver estável, crie uma branch `release/INCE-XXX-vX.Y.Z`.
2.  **Pipeline**:
    -   Executa **Testes E2E** e de Integração.
    -   Cria automaticamente uma **Tag** (ex: `v1.2.0`) baseada no nome da branch.
3.  Abra um Pull Request para a `main`.
4.  Realize o merge do PR para a `main`.

### 2.4. Produção e Sincronização
1.  O merge na `main` dispara o **Deploy em Produção**.
2.  **Sync-back**: Após o deploy, a pipeline realiza o merge automático da `main` de volta para a `develop` (`main -> develop`) para garantir que correções de release/hotfix não sejam perdidas.

## 3. Padrões Complementares

-   **Commits**: Veja o arquivo [Commit-Convention.md](file:///c:/Users/gustavo.goncalves/projetos/workspace/brain/90_Templates/Commit-Convention.md).
-   **Tags**: Veja o arquivo [Tag-Convention.md](file:///c:/Users/gustavo.goncalves/projetos/workspace/brain/90_Templates/Tag-Convention.md).

## 4. Comandos Úteis

### Criar Release
```bash
git checkout develop
git pull origin develop
git checkout -b release/INCE-123-v1.1.0
git push origin release/INCE-123-v1.1.0
```

### Criar Hotfix
```bash
git checkout main
git pull origin main
git checkout -b hotfix/INCE-456-v1.1.1
git push origin hotfix/INCE-456-v1.1.1
```

---

> [!NOTE]
> Toda automação é gerenciada pelo arquivo `bitbucket-pipelines.yml`. Certifique-se de que a variável `REPO_TOKEN` esteja configurada no repositório.