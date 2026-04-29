---
tags: [meta, prompt, notion, sync]
description: Protocolo de sincronização entre Notion e arquivos de contexto local.
type: meta
---

# Fluxo de Atualização Notion
Este workflow define como o Agente deve interagir com o Notion e manter a sincronia com os arquivos de contexto local.

## 1. Contexto Profissional
- **Regras e Diretrizes:** Seguir rigorosamente o arquivo [[30_Work/Notion-Context.md]]
- **Histórico e Status:** Consultar e atualizar o arquivo [[10_Daily/work-notion-context-bd.md]] para registrar progresso de projetos, upgrades de servidores e decisões técnicas.

## 3. Protocolo de Sincronização

Após qualquer criação de página, atualização de status ou log de progresso no Notion:

1.  **Validar no Notion:** Confirmar que a alteração foi persistida.
2.  **Atualizar Contexto Local:** Refletir a mudança no arquivo `-bd.md` correspondente.
3.  **Resumo:** Informar ao usuário que tanto o Notion quanto o arquivo de contexto foram sincronizados.