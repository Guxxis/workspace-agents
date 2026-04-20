---
context: work
status: active
tags:
  - infrastructure
  - audit
  - dsw-mkt01
  - disk-cleanup
type: action-plan
---

# 🕵️‍♂️ Plano de Ação: Auditoria de Disco no DSW-MKT01

**Servidor:** DSW-MKT01 (`149.18.102.74` - Família `M3-SOIN-SITES`)
**Problema Relatado:** Diretório `/home` está próximo de 100% de uso na partição.
**Objetivo:** Auditar o consumo de disco localmente no servidor via SSH, localizar ofensores (como arquivos muito grandes dispersos, logs rotacionados não compactados e backups antigos guardados por tempo além do estrito necessário) e realizar limpeza cautelosa para adiar ou confirmar a real necessidade do upgrade adicional sugerido.

> **Instrução para o Claude CLI:** Você é o Operador Sênior SRE nesta missão. Você tem acesso SSH pelo terminal (WSL). Sua missão é conectar-se ao servidor (ex: `ssh root@149.18.102.74`), e então encadear as **Fases** abaixo. **AVISO IMPORTANTE:** Antes de executar NARRATIVAS DESTRUTIVAS (ex: `rm`, `truncate`, `>`), você deve primeiro apresentar suas descobertas listadas em um output amigável e PEDIR APROVAÇÃO, excetuando comandos de visualização e busca (ex: `du`, `df`, `find`, `ls`).

---

## 🛠️ Fase 1: Reconhecimento e Confirmação Geral
1. **Verificar Espaço Real:** 
   Execute `df -h /home` para identificar a capacidade total e o uso em GB/TB da partição.
2. **Verificar Inodes:** 
   Execute `df -i /home` para ter certeza de que o uso atingiu o limite de área estrita (blocos) e que não caímos em um cenário de exaustão de indexnode.

## 📊 Fase 2: Caça aos Gulosos (Levantamento Analítico)
1. **Mapeamento de Pastas Pesadas:**
   Rodar um sumário dos subdiretórios no primeiro nível e ordenar por tamanho:
   ```bash
   du -sh /home/* | sort -rh | head -n 20
   ```
2. **Localização de Arquivos Massivos Grosseiros:**
   Vá direto atrás de eventuais elefantes brancos, como zips de 1GB isolados ou .sql salvos no chão do diretório do usuário:
   ```bash
   find /home -type f -size +300M -exec ls -lh {} \; | sort -k5 -hr
   ```

*Insight para o Claude: Servidores como este `SITES` frequentemente usam Vesta/Hestia/cPanel. Atente-se à pasta `/home/backup/` ou aos diretórios `tmp` e `log` em `/home/<usuario>/web/<site>/logs/`.*

## 🧹 Fase 3: Proposta de Limpeza Segura
*Claude: Agora, repasse as descobertas feitas nas etapas anteriores para o usuário avaliar. Utilize o checklist sugerido abaixo como inspiração e peça licença para rodar os comandos correspondentes listados após a aprovação dele.*

- [ ] **Limpar Acúmulo de Backups em `/home/backup`:** Se houver pacotes com mais de X dias, rodar `find /home/backup -type f -mtime +7 -name "*.tar" -exec rm -f {} \;` (Ajuste o `-mtime` conforme instrução do usuário).
- [ ] **Esvaziar Logs Históricos Não Rotacionados:** Ao identificar um `error.log` imenso, limpe a agulha sem quebrar as engrenagens ativas rodando no disco: `> /home/usuario/path/do/arquivo.log` ou `truncate -s 0 /...`. Não use `rm` nestes sem cautela intensa.
- [ ] **Remoção de Entulho Disperso:** Retirar arquivos como `.sql`, `.zip`, `.tar.gz` criados temporariamente por devs em passagens anteriores, além de resquícios pontuais em `/tmp`.

## 📈 Fase 4: Avaliação Final
1. Finalizadas as limpezas autorizadas acima, force a reavaliação via `df -h /home`.
2. Se o cenário de risco cair drasticamente e retornar a um limite salutar (e.g. menos que 75% estourando), sugira ao usuário pular o gasto do upgrade e focar no conserto definitivo do gatilho na infraestrutura (ajuste de `logrotate`, ou política mais rigorosa de dias limite no cron de backup).
3. Se ao contrário, a faxina em pontos clássicos não trouxer espaço de volta o bastante, legitime o pedido formal feito pela M3 de expandimento, embasando os log reports coletados como justificativa final.
