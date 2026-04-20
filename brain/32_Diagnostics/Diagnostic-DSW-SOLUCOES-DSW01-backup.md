---
context: work
status: active
tags:
  - infrastructure
  - audit
  - backup
  - dsw-solucoes-dsw01
  - diagnostic
type: diagnostic-report
date: 2026-04-20
server: DSW-SOLUCOES-DSW01
ip: 192.168.3.135
---

# 🔍 Diagnóstico: Partição /backup — DSW-SOLUCOES-DSW01

**Data:** 2026-04-20
**Servidor:** DSW-SOLUCOES-DSW01 (`192.168.3.135` — Família M3-SOIN-SISTEMAS)
**Auditado por:** Claude CLI (persona SRE-BDR)
**Referência:** [[Audit-DSW-SOLUCOES-DSW01]]

---

## 📊 Estado Atual da Partição

| Item | Valor |
|---|---|
| **Dispositivo** | `/dev/sdc1` |
| **Tipo** | `ext4` (disco local, sem NFS) |
| **Tamanho Total** | 492 GB |
| **Usado** | 373 GB (**80%**) |
| **Disponível** | 96 GB |
| **Montagem** | `defaults` — sem restrições especiais |

> ⚠️ A M3 reportou 100% de uso. O estado atual em 80% sugere que uma limpeza manual emergencial foi realizada antes desta auditoria, ou backups de meses anteriores (Fev/Mar) expiraram naturalmente.

---

## 🗂️ Estrutura de Backup

```
/backup/
├── files/          → 370 GB  ← CULPADO
│   └── Apr/
│       ├── Mon/    → 122 GB  (backup de 20/04 — hoje)
│       ├── Sat/    → 125 GB  (backup de 18/04 — 2 dias atrás)
│       └── Sun/    → 123 GB  (backup de 19/04 — ontem)
└── banco/          → 3.3 GB  (saudável)
    └── Apr/
        └── (dumps SQL por dia-da-semana, histórico acumulado)
```

### Scripts de backup (crontab root)
| Horário | Script | Destino |
|---|---|---|
| `00:30 diário` | `/usr/local/m3solutions/dados.sh` | `/backup/files/` |
| `05:30 diário` | `/usr/local/m3solutions/banco.sh` | `/backup/banco/` |

---

## 🐛 Bug Confirmado: Deadlock de Disco no `dados.sh`

### Causa Raiz

O arquivo `/var/www/ferramentademarketing.com.br` cresceu para **~120–125 GB** (crescimento iniciado em fevereiro, conforme relatado pela M3). O script `dados.sh` tem um **defeito de design**: a limpeza de arquivos antigos ocorre **depois** da geração do backup:

```bash
# Fluxo atual (problemático):
[1] tar cvfz <novo_arquivo>.tar.gz /var/www/...  # cria arquivo novo
[2] find /backup/files/* -mtime +1 -iname '*.gz' -exec rm -r {} \;  # apaga antigos
```

### O Ciclo de Deadlock

Quando o site ultrapassou ~80 GB de tamanho, o processo se tornou autodestrutivo:

1. Disco com ~X% livre inicia o `tar` de ~120 GB
2. O `tar` esgota o espaço livre no meio da execução → arquivo parcial/corrompido é criado
3. O disco trava em **100%**
4. A linha `find ... rm` até executa, mas o arquivo novo (parcial, com menos de 1 dia) não é deletado
5. Na noite seguinte, o ciclo se repete → arquivos velhos acumulam

### Evidência do Estado Atual

O backup de **Sábado 18/04 (125 GB)** deveria ter sido deletado pelo script de Segunda-feira (20/04) às ~04:17, pois o arquivo tinha ~47h de idade e o critério é `-mtime +1` (>24h). O arquivo **ainda está presente**, confirmando que a limpeza falhou silenciosamente — provavelmente porque o disco estava cheio quando o script de Domingo tentou executar, deixando o Sábado acumulado.

---

## 🧹 Fase 3 — Proposta de Limpeza (AGUARDANDO AUTORIZAÇÃO)

### Liberação Imediata: 125 GB

Deletar o backup de Sábado 18/04, que tem 2 dias e já deveria ter sido removido pela rotina automática:

```bash
# AGUARDANDO AUTORIZAÇÃO — não executado
rm -v /backup/files/Apr/Sat/ferramentademarketing.com.br-2026-Apr-18-00h-30m-01s.tar.gz
```

**Resultado:** 80% → ~55% de uso (373 GB → ~248 GB)

### Liberação Adicional (opcional): +123 GB

Se a política de retenção for reduzida para apenas 1 dia (apenas backup de hoje):

```bash
# AGUARDANDO AUTORIZAÇÃO — não executado
rm -v /backup/files/Apr/Sun/ferramentademarketing.com.br-2026-Apr-19-00h-30m-01s.tar.gz
```

**Resultado combinado:** 80% → ~30% de uso (~125 GB usados)

### Tabela de Decisão

| Ação | GB liberados | Uso pós-limpeza | Risco |
|---|---|---|---|
| Deletar apenas Sábado (2 dias) | 125 GB | ~55% | ✅ Nenhum |
| Deletar Sábado + Domingo | 248 GB | ~30% | ✅ Nenhum (Mon preservado) |
| Manter tudo | 0 GB | 80% | ⚠️ Pode chegar a 100% amanhã |

---

## 🔧 Correção Estrutural do Script `dados.sh`

### Problema Adicional: Limpeza antes do Backup

A limpeza deve rodar **antes** do `tar`, não depois. Assim, o disco tem espaço disponível quando o backup começa.

**Correção sugerida para `/usr/local/m3solutions/dados.sh`:**

```bash
# LINHA ATUAL (no final do script):
find /backup/files/* -mtime +1 -iname '*.gz' -exec rm -r {} \;

# MOVER PARA ANTES DO LOOP DE TAR (adicionar logo após mkdir):
find /backup/files -mtime +1 -iname '*.gz' -exec rm -f {} \;
```

> Nota: trocar `/backup/files/*` por `/backup/files` (sem glob) para garantir busca recursiva correta em todos os meses/dias.

### Política de Retenção Recomendada

| Parâmetro | Atual | Recomendado |
|---|---|---|
| Retenção `dados.sh` | `-mtime +1` (>24h) | `-mtime +1` (manter, mas mover para antes) |
| Retenção `banco.sh` | `-mtime +3` (>3 dias) | `-mtime +3` (adequado, manter) |
| Ordenação do script | backup → limpeza | **limpeza → backup** |

---

## 📈 Fase 4 — Veredito sobre o Upgrade de +100 GB

### Situação com a correção aplicada

Com o script corrigido (limpeza antes do backup), o disco manterá sempre **no máximo 2 cópias** do backup de arquivos durante a janela de transição (~4h de backup). Projeção de uso:

| Cenário | GB usados | % da partição |
|---|---|---|
| 1 cópia ativa + 1 em geração | ~125 + ~125 GB + 3 GB banco | ~52% |
| Pico máximo (2 cópias completas) | ~250 GB + 3 GB | ~52% |

**Com 492 GB de partição e backups de ~125 GB: o upgrade de +100 GB NÃO é necessário** — desde que o script seja corrigido e a limpeza anteceda o backup.

### Recomendação Final

- ✅ **Corrigir o `dados.sh`** (mover limpeza para antes do tar)
- ✅ **Deletar o backup de Sábado 18/04** (limpeza manual pontual)
- ⏸️ **Adiar o upgrade de +100 GB** — reavaliar em 30 dias após a correção
- 📋 **Monitorar** o tamanho de `/var/www/ferramentademarketing.com.br` — se crescer além de 200 GB, o upgrade passa a ser necessário mesmo com a correção

---

## 📋 Checklist de Ações

- [ ] Autorizar e executar limpeza do backup de Sábado 18/04 (125 GB)
- [ ] Corrigir `dados.sh`: mover `find ... rm` para antes do loop de tar
- [ ] Validar execução do script corrigido na próxima madrugada
- [ ] Executar `df -h /backup` no dia seguinte para confirmar estabilização
- [ ] Comunicar à M3 que o upgrade pode ser adiado (com justificativa técnica)
