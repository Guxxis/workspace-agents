# Projeto de Modernização de Infraestrutura e CI/CD
**Transformando a TI em um acelerador de negócios**

---

# O que é DevOps (e por que estamos aqui?)
*A ponte essencial entre o Código e o Cliente.*

- **O Elo que Faltava:** DevOps é a união entre o "Desenvolvimento" (Dev) e a "Operação de TI" (Ops).
- **O Papel do Engenheiro:** Se os desenvolvedores constroem o "carro", o papel do DevOps é construir a "rodovia pavimentada" para que eles possam acelerar sem bater.
- **Nosso Foco Principal:** Eliminar todo o trabalho braçal, manual e repetitivo. O objetivo é que a equipe de Devs foque 100% em criar produto, e não em "subir servidor".
- **Previsibilidade Absoluta:** Garantir que o que funciona na máquina do Dev vai funcionar exatamente igual em Produção, sem surpresas na hora da entrega.

---

# O Cenário Atual (Diagnóstico)
*Radiografia dos desafios que atrasam nossas entregas.*

- **Cultura de Código Local:** Repositórios são criados apenas no fim do projeto.
- **Caos de Governança:** Deploy 100% manual feito pelos desenvolvedores. Sem rastro do que foi alterado.
- **Insegurança Crítica:** Desenvolvedores com acesso root em servidores de produção.
- **Desconexão de Ferramentas:** Bitbucket e Jira não se conversam.
- **Solicitação Tardia:** Ambientes pedidos na última hora gerando gargalos.

---

# Os Riscos Iminentes
*O que acontece se não mudarmos hoje?*

- **Perda de Código:** Sem commits desde o início, uma falha de hardware local é fatal.
- **Gargalos de Deploy:** Dependência da disponibilidade de um dev específico para colocar em produção.
- **Inconsistência:** Mistura de ambientes de Homologação e Produção (Risco de quebra em tempo real).

---

# A Proposta de Solução
*O novo padrão operacional.*

- **Automação (Jenkins):** Fim do deploy manual. Pipelines testam e entregam o código com segurança.
- **Governança de Acessos:** Centralização via **Jumphost (Guacamole)**. Ninguém mais acessa a produção diretamente.
- **Sincronia Total:** Integração Jira-Bitbucket. Saberemos exatamente qual tarefa gerou qual linha de código.
- **Cultura de Commit:** Versionamento e backup desde o **Dia 1** de qualquer projeto.

---

# Padronização e Eficiência
*O "Como" vamos estruturar a base técnica.*

- **Bitbucket Organizado:** Repositórios padronizados (`api.portal.idealtrends.io`) e segmentados por empresa.
- **Gitflow & SemVer:** Bloqueio das branches principais. Alterações apenas com revisão (Pull Requests).
- **Scaffolding:** Templates prontos para novos projetos. Menos tempo configurando, mais tempo codando.
- **Infraestrutura como Código (IaC):** Servidores provisionados por scripts. Recriamos a infraestrutura em minutos em caso de desastre.

---

# [INSERIR DIAGRAMA EXCALIDRAW: FLUXO GITFLOW AQUI]
*(No Gamma, arraste a imagem PNG do fluxo de Gitflow para cá)*

---

# [INSERIR DIAGRAMA EXCALIDRAW: ARQUITETURA JUMPHOST AQUI]
*(No Gamma, arraste a imagem PNG do Jumphost/Arquitetura para cá)*

---

# Custos e Investimento
*Quanto custa a profissionalização?*

- **Custo Zero de Software:** Utilizaremos ferramentas Open Source líderes de mercado (Jenkins, Grafana, Guacamole).
- **Custo de Infraestrutura Baixo:** Apenas 1 servidor inicial (Jumphost) com custo mensal mínimo (~$20-$40).
- **Investimento de Tempo:** Dedicação focada para o setup inicial e treinamento do time.

---

# O Retorno sobre Investimento (ROI)
*Os ganhos diretos com a nova operação.*

- **Redução de Downtime:** Deploys seguros significam menos quedas em produção.
- **Eficiência Operacional:** Tempo de deploy reduzido de 30 minutos para menos de **2 minutos**.
- **Mitigação de Riscos:** Proteção total contra perda de código e bloqueio de acessos indevidos.

---

# Comparativo: O Salto de Qualidade

| Critério | Cenário Atual | Novo Padrão (DevOps) |
| :--- | :--- | :--- |
| **Segurança** | Devs com acesso Root | Acesso via Jumphost (Auditado) |
| **Versionamento** | Código local | Bitbucket desde o Dia 1 |
| **Deploy** | Manual (Lento) | Automático (< 2 min) |
| **Ambientes** | Misturados / Confusos | Segregados (Homolog/Prod) |
| **Rastreabilidade** | "Quem subiu o que?" | Link Jira-Commit Automático |

---

# Roadmap de Implantação (2 Meses)

## Mês 1: Fundação e Valor Tangível (Prova de Conceito)
- **Setup Inicial:** Criação do servidor Jumphost e esteira CI/CD (Jenkins).
- **Piloto (Projeto Ideal Plus):** Migração, segregação de ambientes e automação real de deploy.
- **Workshop Focado:** Treinamento prático com os desenvolvedores da PoC.

## Mês 2: Refinamento, Expansão e Escala
- **Governança Total:** Reorganização do Bitbucket, Jira e acessos centrais.
- **Observabilidade:** Métricas, logs e alertas de deploy no Slack/Discord.
- **Rollout Geral:** Treinamento de todos os Devs e POs e expansão para os demais sistemas.

---

# Obrigado!
**Prontos para acelerar nossas entregas com segurança?**
