---
tags: [meta, index, map]
description: Mapa estratégico e índice global de documentação DevOps, centralizando acessos a infraestrutura, governança e auditoria.
type: meta
---

# 🗺️ Work Index - Mapa Estratégico

Este arquivo serve como o ponto de entrada central para a organização do conhecimento profissional.

## 📁 Estrutura de Pastas

| Pasta | Objetivo |
| :--- | :--- |
| `00_Meta/` | Configurações do sistema, instruções do assistente, índice e [[Brain-Refresh\|protocolo de refresh]]. |
| `10_Daily/` | Registro de atividades diárias e decisões rápidas. |
| `12_Notes/` | Notas gerais, rascunhos e estudos técnicos. |
| `30_Work/` | **Core**: Documentação de infraestrutura, operações e guias de projeto. |
| `31_Gitflow/` | **Governance**: Padrões de Git, Commits, Tags e Bitbucket. |
| `20_Audit/` | Trilhas de auditoria, histórico de mudanças sensíveis. |
| `21_Diagnostics/` | Análises de incidentes, logs de erro e troubleshooting. |
| `90_Templates/` | Modelos para Jenkinsfiles, pipelines e auditorias. |

## 🚀 Documentação Core (30_Work)

### Infraestrutura e Servidores
- [[Server-Inventory]]: Inventário detalhado de todos os servidores e IPs.
- [[Server-Family]]: Organização dos servidores por famílias e propósitos.
- [[Infraestructure]]: Visão geral da arquitetura de rede e serviços.
- [[Profile-Config]]: Configurações de perfis e acessos.

### Operações
- [[Deploy]]: Guia e procedimentos de implantação.
- [[Ferramentas]]: Lista de ferramentas e utilitários aprovados.
- [[Notion-Context]]: Integração e contexto do workspace no Notion.
- [[Backup-Policy]]: Política de backup, retenção e janelas de execução.

## ⚖️ Governança e Repositórios (31_Gitflow)

### Padrões de Código e Versão
- [[31_Gitflow/Gitflow|Gitflow]]: Fluxo de trabalho para ramificação e releases.
- [[31_Gitflow/Commit-Convention|Commit Convention]]: Padrão de mensagens de commit (Conventional Commits).
- [[31_Gitflow/Tag-Convention|Tag Convention]]: Padrão de versionamento e tags de release.
- [[31_Gitflow/Bitbucket-Standards|Bitbucket Standards]]: Padrões de nomenclatura e organização do Bitbucket.
- [[30_Work/Stacks-Default|Stacks Default]]: Tecnologias e stacks padrão utilizadas nos projetos.

## 🔍 Auditoria e Diagnósticos (20_Audit / 21_Diagnostics)

### Auditorias Recentes
- [[20_Audit/Audit-DSW-MKT01|Audit DSW-MKT01]]: Limpeza de disco e sessões órfãs.
- [[20_Audit/Audit-DSW-SOLUCOES-DSW01|Audit SOLUCOES-DSW01]]: Verificação de integridade de backups.

### Diagnósticos e RCAs
- [[21_Diagnostics/Diagnostic-DSW-MKT01|Diagnostic DSW-MKT01]]: Detalhamento técnico da exaustão de disco.
- [[21_Diagnostics/Diagnostic-DSW-SOLUCOES-DSW01-backup|Diagnostic SOLUCOES-DSW01]]: Falha de backup por falta de espaço.

## 📝 Notas e Snippets (12_Notes)
- [[12_Notes/Operational-Snippets|Operational Snippets]]: Comandos rápidos para Postgres, WordPress e utilitários.
- [[12_Notes/bitbucket-pipelines|Bitbucket Pipelines Note]]: Estudos e rascunhos sobre configurações de pipeline.

## ⚙️ Templates e Utilitários
- [[90_Templates/Template-Auditoria-Servidor|Modelo de Auditoria]]: Modelo para novos logs de auditoria.
- [[90_Templates/Jenkinsfile]]: Modelo base para pipelines Jenkins.
- [[90_Templates/input-modelo-fluxo|Modelo de Entrada (Fluxo)]]: Para novos processos.
- [[90_Templates/output-modelo-fluxo|Modelo de Saída (Fluxo)]]: Para documentação final.