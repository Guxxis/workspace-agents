---
tags: [work, standards, backup, bdr, infrastructure]
description: Política global de backup, retenção e recuperação de desastres.
type: work
---

# 🛡️ Política de Backup e Retenção (BDR)

Este documento define os padrões para cópias de segurança de todos os servidores e sistemas da infraestrutura.

## 📅 Janelas de Execução
- **Arquivos (Web/App)**: Diário às 00:30.
- **Bancos de Dados**: Diário às 05:30.

## 🧹 Regras de Retenção (Retention)
- **Servidores Padrão**: 7 dias (ciclo semanal).
- **Servidores Críticos**: 15 dias.
- **Off-site (Nuvem/S3)**: 30 dias para backups mensais.

## ⚠️ Ordem de Operação (Importante)
Para evitar *deadlocks* de disco em partições limitadas (conforme visto no [[Diagnostic-DSW-SOLUCOES-DSW01-backup|RCA do SOLUCOES-DSW01]]), a ordem de execução nos scripts deve ser:

1. **Limpeza**: Remover backups expirados (`find -mtime +X -exec rm`).
2. **Compressão**: Iniciar o novo backup (`tar` ou `mysqldump`).
3. **Validação**: Verificar integridade do arquivo gerado.

## 🔍 Monitoramento
Sempre validar o uso da partição `/backup` via:
```bash
df -h | grep backup
```
Se o uso exceder 85%, uma revisão manual da retenção é necessária.
