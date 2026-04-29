---
tags: [git, tags, versioning, semver]
description: Padrão de versionamento (SemVer) e criação automática de tags de release.
type: work
---
# Tag Convention (Versioning)

O projeto utiliza o padrão de **Semantic Versioning (SemVer)** para a criação de tags de release.

## Formato da Tag

```text
v<MAJOR>.<MINOR>.<PATCH>
```
Exemplo: `v1.2.3`

### Regras de Incremento

1.  **MAJOR**: Alterações incompatíveis com versões anteriores (Breaking Changes).
    -   Ex: Mudança radical na API, troca de banco de dados sem retrocompatibilidade.
2.  **MINOR**: Adição de funcionalidades de maneira compatível com versões anteriores.
    -   Ex: Novos endpoints, novas telas, melhorias significativas.
3.  **PATCH**: Correções de bugs (bugfixes) de maneira compatível com versões anteriores.
    -   Ex: Ajuste de CSS, correção de lógica interna, hotfixes urgentes.

## Fluxo de Criação

-   As tags são geradas **automaticamente** pelo Bitbucket Pipelines.
-   A versão é extraída do nome da branch:
    -   `release/INCE-100-v1.2.0` -> Gera tag `v1.2.0`
    -   `hotfix/INCE-101-v1.2.1` -> Gera tag `v1.2.1`

## Repositório de Tags

Para visualizar as versões disponíveis, acesse a aba **"Commits > Tags"** no Bitbucket.

---

> [!TIP]
> Nunca altere uma tag já criada. Se houver um erro na release, crie um novo `hotfix` e incremente o `PATCH`.
