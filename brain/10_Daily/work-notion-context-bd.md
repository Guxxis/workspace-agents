---
tags: [notion, project-status, work-history]
description: Base de dados para histórico de tarefas, decisões e status de projetos ativos no Notion.
type: daily
---
# Histórico e Status de Projetos Ativos - Notion Trabalho

Este arquivo serve como base de dados para o histórico de tarefas, decisões e status de projetos ativos no Notion de trabalho.

## Projetos Ativos

- **Novos servidores MPI+:**
  - **Status:** Em andamento.
  - **Última Atualização (13/04/26):** Definido com a M3 que o servidor destino será removido do firewall geral e terá um IP público próprio para comunicação direta com o Supabase. Isso resolve o impasse anterior de bloqueio na porta 8083.
- **Upgrade de Servidores (Ideal Plus 01 & Ideal Matriz):**
  - **Status:** Triagem (Criado em 13/04/26).
  - **Próximos Passos:** Executar upgrade de recursos (CPU, RAM, Disco) conforme especificações nos cards.
- **Auditoria Ideal:**
  - **Status:** Em andamento.
  - **Última Atualização (10/04/26):** Pendente escolha do servidor para ambientes de Homologação/Produção.
- **Painel Grafana M3:**
  - **Status:** Em andamento.
  - **Última Atualização (10/04/26):** Entrega parcial prevista para a próxima semana (CPU, RAM, DISCO, UPTIME).

---
*Última sincronização completa: 13/04/2026*

- **Otimização de Servidor VESTACP01:**
  - **Status:** Triagem (Criado em 24/04/26).
  - **IP:** 192.168.3.20.
  - **Detalhes:** Identificado gargalo de CPU causado por elevado número de leituras no banco de dados no sistema de cookies da doutores.
  - **Próximos Passos:** Analisar queries e otimizar sistema de cookies.
