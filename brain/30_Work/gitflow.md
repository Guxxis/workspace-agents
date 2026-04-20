---
context: work
status: active
tags:
  - gitflow
  - conventional-commits
  - bitbucket
type: documentation
---

# Bitbucket

## Padrao de Repositorios

Modelo de versionamento de codigo: GitFlow adaptado
- branch main → branch de produção
- branch develop → branch de desenvolvimento
- branch feature/ticket-jira → branch de desenvolvimento de novas funcionalidades
- branch hotfix/ticket-jira → branch de correção de bugs


## Novo Repositorios (Projeto ou Testes)

- Projeto → atrelado a empresa (ex: doutores-da-web, grupo-ideal-trends, ideal-marketing)
- Nome → nome do projeto sempre com o dominio e subdominio se tiver (ex: doutores-da-web.com.br, blog.doutores-da-web.com.br)
- Default Branch → main
- arquivo README.md → deve conter informações sobre o projeto, como instalar, como rodar, como testar, como fazer deploy, etc

## Padrao de Commits

**escopo:** mensagem no imperativo do que mudou no codigo

### Lista de escopos

- **build:** Alterações que afetam o sistema de build ou dependências externas.
- **ci:** Alterações nos arquivos de configuração e scripts de integração contínua
- **docs:** Alterações exclusivamente na documentação.
- **feat:** Adição de uma nova funcionalidade.
- **fix:** Correção de um bug.
- **perf:** Alteração no código para melhorar o desempenho.
- **refactor:** Alteração no código que não corrige um bug nem adiciona uma nova funcionalidade.
- **style:** Alterações que não afetam a lógica do código
- **test:** Adição de testes ausentes ou correção de testes existentes.
- **remove:** Exclusão de arquivos, funcionalidades obsoletas ou não utilizadas

### **Exemplo**

`remove: deleta arquivos antigos`

`feat: adiciona pagina contato`

`fix: corrige botao do menu`

## Commits

```bash
git clone [repositorio]
git checkout -b [feature]/[ticket jira]
git add .
git commit -m “scopo: mensagem commit”
git push origin [feature]/[ticket jira]
git pull origin [feature]/[ticket jira]
```

## Conflitos

```bash
git clone [repositorio]
git checkout [feature]/[ticket jira]
git merge master
git checkout [--ours || --theirs] . (vai depender da situação)
git add .
git commit -m “fix: corrigi commit”
git push origin [feature]/[ticket jira]
```

## Tags

```bash
git tag v1.1.0 -m "Adicionando nova funcionalidade X"
git tag
git push origin v1.1.0
git push origin --tags
git tag -d v1.0.0
git push origin --delete v1.0.0
git show v1.0.0
```

## Reset

```bash
git reset --soft HEAD~1
git reset
```