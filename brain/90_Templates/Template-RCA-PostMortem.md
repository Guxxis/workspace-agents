---
tags: [template, rca, post-mortem, deployment, infrastructure]
description: Modelo para análise pós-incidente e causa raiz (RCA) de falhas em deploy ou infraestrutura.
type: template
---

# 🛠️ Post-Mortem / RCA: [Título do Incidente]

**Data:** [DD/MM/AAAA]
**Severidade:** [Crítica | Alta | Média]
**Duração do Incidente:** [HH:MM]
**Servidores Impactados:** [Ex: DSW-MKT01]

---

## 📝 Resumo Executivo
[Breve descrição do que aconteceu, quem foi impactado e qual foi a resolução imediata.]

## 📊 Linha do Tempo (Timeline)
- **[HH:MM]**: Detecção do problema via [Monitoramento/Alerta/Usuário].
- **[HH:MM]**: Início do troubleshooting.
- **[HH:MM]**: Identificação da causa provável.
- **[HH:MM]**: Aplicação do hotfix/rollback.
- **[HH:MM]**: Normalização dos serviços.

## 🔍 Análise de Causa Raiz (Root Cause)
[Detalhamento técnico do porquê o problema ocorreu. Use "Os 5 Porquês" se necessário.]
1. Por que...?
2. Por que...?
...

## 🧹 Ações Corretivas e Preventivas
- [ ] **Imediata**: [O que foi feito para apagar o fogo]
- [ ] **Médio Prazo**: [O que será feito para evitar que se repita]
- [ ] **Documentação**: [Links para arquivos atualizados no brain]

---
> [!IMPORTANT]
> Este documento foca no processo, não em culpados. O objetivo é a melhoria contínua da infraestrutura.
