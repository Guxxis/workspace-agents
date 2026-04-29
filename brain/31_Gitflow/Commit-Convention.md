---
tags: [git, commits, standards, jira]
description: Padronização de mensagens de commit para rastreabilidade e integração com JIRA.
type: work
---
# Commit Convention

Padronização de mensagens de commit para garantir rastreabilidade e integração automática com o JIRA.

## Formato Geral

```text
<tipo>(<escopo>): <descrição curta> [ID-JIRA]
```

### Componentes

1.  **Tipo (Type)**: Indica a natureza da alteração.
2.  **Escopo (Scope)**: (Opcional) Indica a parte do projeto afetada (ex: api, front, auth).
3.  **Descrição**: Resumo claro do que foi feito (em português ou inglês, conforme padrão do time).
4.  **ID JIRA**: OBRIGATÓRIO para linkar com a tarefa (ex: `INCE-123`).

## Tipos Permitidos

| Tipo | Descrição | Exemplo |
| :--- | :--- | :--- |
| `feat` | Nova funcionalidade | `feat(api): adiciona endpoint de busca INCE-45` |
| `fix` | Correção de bug | `fix(ui): ajusta cor do botão de login INCE-12` |
| `docs` | Alteração em documentação | `docs: atualiza README com guia de deploy` |
| `style` | Formatação, pontos-e-vírgula, etc (sem alteração de código) | `style: lint no controller de usuários` |
| `refactor` | Refatoração de código que não altera comportamento | `refactor(auth): simplifica lógica de JWT` |
| `test` | Adição ou correção de testes | `test: adiciona unitários para o módulo financeiro` |
| `chore` | Tarefas de build, ferramentas ou bibliotecas | `chore: atualiza dependência do prisma` |

## Integração com JIRA (Smart Commits)

Utilize comandos especiais no commit para interagir com o card no JIRA:

-   **Comentário**: `INCE-123 #comment O deploy foi realizado com sucesso.`
-   **Tempo Gasto**: `INCE-123 #time 1h 30m`
-   **Transição de Status**: `INCE-123 #done` ou `INCE-123 #close` (depende do workflow configurado).

---

> [!IMPORTANT]
> O ID da tarefa (`INCE-XXX`) deve estar presente no título ou no corpo do commit para que o Bitbucket realize o vínculo automático.
