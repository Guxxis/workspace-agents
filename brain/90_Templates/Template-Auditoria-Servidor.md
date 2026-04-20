---
context: work
status: active
tags:
  - infrastructure
  - audit
  - template
type: action-plan-template
---

# 🕵️‍♂️ Plano de Ação: Auditoria de Incidente em Servidor

**Servidor:** [NOME_DO_SERVIDOR] (`[IP_DO_SERVIDOR]` - Família `[FAMILIA_DO_SERVIDOR]`)
**Problema Relatado:** [COLE_AQUI_A_NOTIFICACAO_OU_DESCRICAO_DO_ALERTA]
**Partição/Alvo Principal:** `[EX: /home, /backup, /var, /]`
**Objetivo:** Investigar a causa raiz do alerta localmente via SSH, identificar os recursos processuais ou ofensores de disco e executar ações mitigadoras, para validar ou refutar a necessidade de upgrade de infraestrutura sugerido.

> **Instrução para o Agente / Claude CLI:** Você atuará como Engenheiro SRE focado em estabilidade e diagnóstico de infraestrutura Linux. Sua missão é conectar-se ao servidor listado via terminal WSL (ex: `ssh root@[IP_DO_SERVIDOR]`) e investigar o alerta. 
> **REGRA DE OURO 1:** Sob nenhuma circunstância você deve executar comandos destrutivos ou de mutação de estado (e.g., `rm`, `truncate`, `kill`, `systemctl restart`) nas Fases 1 e 2. Suas ações modificadoras apenas podem rodar após a aprovação explícita do usuário na Fase 3.
> **REGRA DE OURO 2:** Este plano de auditoria inicial deve sempre ser lido a partir da pasta `brain/31_Audit`. Ao finalizar a Fase 4 e termos um "Veredito (RCA)", você DEVE salvar o diagnóstico final e detalhado (contendo os problemas encontrados, as soluções aplicadas e a decisão de upgrade confirmada ou cancelada) na pasta `brain/32_Diagnostics`. 
---


## 🛠️ Fase 1: Reconhecimento e Validação do Estado Atual
1. **Verificar Limites de Espaço e Inodes (Se aplicável a disco):** 
   ```bash
   df -h [PARTICAO_ALVO]
   df -i [PARTICAO_ALVO]
   ```
2. **Entender Metadados e Pontos de Montagem:**
   ```bash
   mount | grep [PARTICAO_ALVO] || cat /etc/fstab | grep [PARTICAO_ALVO]
   ```
3. **Validação de Carga (Se o problema for CPU/RAM):**
   ```bash
   top -b -n 1 | head -n 15
   free -m
   ```

## 📊 Fase 2: Diagnóstico da Anomalia (A Busca pelo Ofensor)
Baseie-se na natureza do problema para guiar a investigação.

* **Se for Explosão de Disco / Logs / Backups:**
  1. *Visão Top-Down do Volume:*
     ```bash
     du -h --max-depth=2 [PARTICAO_ALVO] | sort -rh | head -n 20
     ```
  2. *Procura por Arquivos Massivos Perdidos:*
     ```bash
     find [PARTICAO_ALVO] -type f -size +300M -exec ls -lh {} \; | sort -k5 -hr | head -n 20
     ```
  3. *Procura por Entulho de Backup Antigo (exemplo para arquivos intocados há > 15 dias):*
     ```bash
     find [PARTICAO_ALVO] -type f -mtime +15 -exec ls -lh {} \; | sort -k5 -hr | head -n 20
     ```

* **Se for Vazamento de Memória, Zombie Process ou CPU travada:**
  - Execute um `ps aux --sort=-%mem | head -n 15` para achar quem segura RAM.
  - Verifique `dmesg -T | grep -i oom` para saber se processos falharam por falta de RAM.

## 🧹 Fase 3: Proposta de Atuação (Aguardando Aprovação)
*Claude: Com base nos achados da Fase 2, liste ao usuário opções claras do que pode ser limpo ou contornado. Inclua o impacto de cada sugestão e exija a aprovação dele para executar.*

- [ ] **Limpar Arquivos Antigos/Órfãos:** Excluir backups antigos, pacotes de migração esquecidos (`.zip`, `.tar.gz`, `.sql`) cruzando a idade segura estipulada pela política. *(Comando gerado dinamicamente: `find ... -exec rm -vf {} \;`)*
- [ ] **Rotacionar ou Truncar Logs:** Não exclua usando `rm` para arquivos de serviços ativos. Use `> caminho/pro/log` ou `truncate -s 0 caminho/pro/log`.
- [ ] **Intervenção Operacional:** Matar um processo travado, limpar cache estagnado ou limpar spools (ex: caixas de email/painéis).

## 📈 Fase 4: Avaliação Final e Veredito (RCA)
Nesta fase, provamos a efetividade da intervenção e decretamos se a infraestrutura aguenta rodar como está ou precisa mesmo de fôlego (upgrade).

1. Execute a validação de saúde do estado (ex: de novo o `df -h [PARTICAO_ALVO]`).
2. Se a mitigação baixou os sintomas abaixo dos limiares de segurança (e.g. voltou pra 60% de uso de disco ou encerrou a fila infinita de CPU): Pule o custo do upgrade no provedor. Assuma o erro de acúmulo lógico (como reconfiguração de `cron` ou retenção).
3. **Decisão Crítica (Confirmação de Upgrade Lógico):** Se mesmo enxugando lixo e velharias de rede a partição/recurso se manter esgarçada (e.g., limpa não baixa de 85%), valide com o usuário que os bancos orgânicos da aplicação cresceram. Portanto, oficializem juntos que a recomendação oriunda do alerta/provedor de gastar com Upgrade procede irrefutavelmente.
