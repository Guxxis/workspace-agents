---
context: work
status: active
tags:
  - infrastructure
  - audit
  - backup
  - dsw-solucoes-dsw01
type: action-plan
---

# 🕵️‍♂️ Plano de Ação: Auditoria de Disco no DSW-SOLUCOES-DSW01

**Servidor:** DSW-SOLUCOES-DSW01 (`192.168.3.135` - Família `M3-SOIN-SISTEMAS`)
**Problema Relatado:** Partição `/backup` atingindo 100% de uso devido ao volume gerado a partir de fevereiro, travando rotinas essenciais de segurança de dados.
**Objetivo:** Auditar o consumo de disco localmente no servidor via SSH, analisar especificamente o inchaço dos backups de fevereiro e identificar se é possível mudar a política de retenção para limpar espaço antigo, adiando ou confirmando a necessidade do upgrade de 100GB sugerido pela M3.

> **Instrução para o Claude CLI:** Você atuará como Engenheiro SRE focado em Backup e Recuperação de Desastres (BDR). Sua missão é conectar-se ao servidor listado via terminal WSL (ex: `ssh root@192.168.3.135`) e investigar o problema na partição `/backup`. **REGRA DE OURO:** Sob nenhuma circunstância você deve apagar arquivos de backup (`rm *`) na Fase 1 e 2. Seus comandos destrutivos apenas podem rodar após a aprovação explícita do usuário na Fase 3.

---

## 🛠️ Fase 1: Reconhecimento e Confirmação Geral
1. **Verificar Espaço Real:** 
   Execute `df -h /backup` para confirmar os limites absolutos da partição.
2. **Avaliar a Frequência do Dano:**
   Rode um simples `mount | grep backup` ou `cat /etc/fstab | grep backup` para entender as opções da montagem (se houver peculiaridades NFS ou discos lógicos).

## 📊 Fase 2: Diagnóstico da Anomalia (A Busca pelo Volume de Fevereiro)
A M3 informou um crescimento drástico iniciado em fevereiro. Precisamos entender o que gerou isso (Ex: Um novo sistema adicionado ao backup, o banco de dados que cresceu absurdamente, ou a rotina que parou de deletar os arquivos velhos).

1. **Visão Macro dos Entulhos:**
   Rode um sumário dos arquivos que tomam mais espaço no topo da montanha:
   ```bash
   du -h --max-depth=2 /backup | sort -rh | head -n 20
   ```
2. **Análise por Retenção (Buscando o "Esquecido"):**
   Busque pelos backups mais antigos. Identifique se ainda temos backups parados do começo de Fevereiro ou até de Janeiro empilhando:
   ```bash
   find /backup -type f -mtime +15 -exec ls -lh {} \; | sort -k5 -hr | head -n 30
   ```
   *Insight para o Claude: Se este servidor utilizar rsync, tar ou cronjobs caseiros para backup, veja a data (`ls -ltr /backup`) em que os scripts de retenção possivelmente falharam.*

## 🧹 Fase 3: Proposta de Limpeza e Ajuste da Retenção
*Claude: Baseado nos arquivos listados na Fase 2, mostre ao usuário quantos GB podemos liberar em recortes de tempo. Peça a autorização indicando os comandos.*

- [ ] **Limpar Retenções Históricas Longas:** Remova backups de X dias atrás. Sugira apagar qualquer coisa com mais de 10 a 14 dias se houver acumulação excessiva de meses atrás:
   ```bash
   find /backup -type f -mtime +15 -name "*.tar.gz" -exec rm -vf {} \;
   ```
- [ ] **Remover Backups Órfãos ou Crachados:** As vezes o disco de backup atinge 100% no meio da geração de um tar, gerando um lixo corrompido imenso no meio da madrugada. Limpe pacotes inconsistentes.
- [ ] **Ajuste Preventivo:** Identifique onde fica o script de backup (`crontab -l` ou arquivos em `/etc/cron.daily/`) e sugira ao usuário diminuir as "retenções" passadas para ele (exemplo: manter 5 backups ao invés de 15), se aplicável.

## 📈 Fase 4: Avaliação Final e Veredito (O Upgrade de 100GB)
1. Execute novamente `df -h /backup` após o expurgo.
2. É aceitável que a partição de backup trabalhe cheia (normalmente 70-80%), porque se espera o preenchimento, mas ela não pode travar. 
3. **Decisão Crítica:** Se os backups recém gerados legitimamente ocupam muito espaço e manter apenas 5 ou 7 dias já gasta mais de 85% do disco, significa que os sistemas da empresa de fato escalaram. Neste caso, confirme a autorização com o usuário e valide para a M3 o pedido do **Upgrade Lógico de +100GB**, evitando que novas falhas prejudiquem a janela de segurança.
