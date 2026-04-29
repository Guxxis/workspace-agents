---
tags: [diagnostic, infrastructure, dsw-mkt01, disk-cleanup]
description: Diagnóstico detalhado de uso de disco e ofensores no servidor DSW-MKT01.
type: diagnostic
---

# 🔍 Diagnóstico de Disco — DSW-MKT01

**Servidor:** DSW-MKT01 (`192.168.3.130` interno / `149.18.102.74` externo)
**Data da Auditoria:** 2026-04-20
**Auditado por:** Claude CLI (Operador Sênior SRE)

---

## 📊 Fase 1: Estado da Partição

| Métrica | Valor |
|---|---|
| Partição | `/dev/sdb1` → `/home` (ext4) |
| Capacidade Total | 197 GB |
| **Usado** | **182 GB (97%!)** |
| Disponível | 5,7 GB |
| Inodes usados | 47% (6.126.843 / 13.107.200) — sem exaustão |

> ⚠️ O problema é de **blocos de dados**, não de inodes.

---

## 🔴 Ofensor Principal: Sessions PHP Órfãs

| Diretório | Arquivos | Tamanho Estimado |
|---|---|---|
| `/home/admin/tmp/sess_*` | **1.774.798 arquivos** | ~168 GB |

Arquivos PHP de sessão (`sess_xxxxxxxx`) acumulados sem limpeza pelo garbage collector do PHP. Cresceram sem controle e dominam quase toda a partição.

---

## 🟠 Ofensores Secundários (arquivos +300 MB)

| Arquivo | Tamanho | Data |
|---|---|---|
| `/home/josepaulo/web/josepaulogit.com/public_html/wp-content/ai1wm-backups/josepaulogit.com-20221107-134146-a7pbib.wpress` | 3,0 GB | Nov/2022 |
| `/home/josepaulo/web/josepaulogit.com/public_html/wp-content/ai1wm-backups/josepaulogit.com-20221014-124926-dqry4a.wpress` | 2,7 GB | Out/2022 |
| `/home/josepaulo/web/josepaulogit.com/public_html/wp-content/ai1wm-backups/josepaulogit.com-20221101-185223-es5kb1.wpress` | 2,6 GB | Nov/2022 |
| `/home/admin/Rox/josepaulo_wpgit_ROX.sql` | 773 MB | Out/2022 |
| `/home/admin/web/vidronovo.com.br/public_html/.git/objects/pack/pack-ad346f...pack` | 476 MB | Jun/2025 |
| `/home/admin/web/moinhosantoantonio.com.br/public_html/.git/objects/pack/pack-c3cda1...pack` | 446 MB | Mar/2026 |
| `/home/admin/web/sacoadesivopersonalizado.com.br/sacoadesivopersonalizado.com.br.tar.gz` | 303 MB | Jun/2018 |

---

## 🧹 Propostas de Limpeza

### [A] CRÍTICO — Purgar sessions PHP antigas (~168 GB)

```bash
find /home/admin/tmp -maxdepth 1 -name "sess_*" -type f -mtime +7 -delete
```

> Remove sessões com mais de 7 dias. Sessões PHP ativas têm vida útil inferior a 24h.
> **Impacto estimado: liberar ~168 GB**

**Ação preventiva pós-limpeza:** Configurar `session.gc_probability` e `session.gc_divisor` no `php.ini`, ou adicionar cron para limpeza periódica:
```bash
# Adicionar ao crontab do root
0 3 * * * find /home/admin/tmp -maxdepth 1 -name "sess_*" -type f -mtime +2 -delete
```

---

### [B] ALTO — Remover backups WordPress de 2022 (~8,3 GB)

```bash
rm -f /home/josepaulo/web/josepaulogit.com/public_html/wp-content/ai1wm-backups/*.wpress
```

> Backups do plugin All-in-One WP Migration com mais de 3 anos. Verificar se há cópia externa antes de remover.
> **Libera ~8,3 GB**

---

### [C] MÉDIO — Remover SQL dump antigo (773 MB)

```bash
rm -f /home/admin/Rox/josepaulo_wpgit_ROX.sql
```

> Dump SQL de Out/2022 guardado no diretório `/home/admin/Rox/`. Verificar necessidade antes de remover.
> **Libera ~773 MB**

---

### [D] BAIXO — Remover tar.gz de 2018 (303 MB)

```bash
rm -f "/home/admin/web/sacoadesivopersonalizado.com.br/sacoadesivopersonalizado.com.br.tar.gz"
```

> Arquivo compactado de 2018 (8 anos). Muito provavelmente obsoleto.
> **Libera ~303 MB**

---

## 📈 Impacto Esperado da Limpeza

| Ação | Liberação |
|---|---|
| [A] Sessions PHP | ~168 GB |
| [B] Backups .wpress | ~8,3 GB |
| [C] SQL dump | ~773 MB |
| [D] tar.gz 2018 | ~303 MB |
| **Total** | **~177 GB** |

Após a limpeza, a partição deve retornar a ~5 GB usados de 197 GB (**~3%**), eliminando completamente a necessidade de upgrade de disco.

---

## ✅ Verificação Final (Fase 4)

Após executar as limpezas, rodar:
```bash
df -h /home
```

Se o uso cair abaixo de 75%, **o upgrade de disco não é necessário**. Focar no conserto definitivo do gatilho (cron de limpeza de sessions + política de retenção de backups).
