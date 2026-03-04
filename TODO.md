# 🤖 Ideias de Agentes para DevOps/SRE

Lista de agentes para auxiliar no dia a dia de um Engenheiro DevOps Junior:

## 🏗️ Infraestrutura e Automação (IaC)
- [ ] **Agente Code Reviewer (IaC):** Analisa Pull Requests de Terraform e Ansible buscando boas práticas, segurança (checkov/tfsec) e possíveis quebras de estado.
- [ ] **Agente Migration Helper:** Auxilia na migração de recursos entre provedores cloud ou na atualização de versões de provedores Terraform.

## 📈 Observabilidade e SRE
- [ ] **Agente Dashboard Builder:** Cria e atualiza painéis no Grafana ou Datadog baseados em novas métricas expostas por aplicações.
- [ ] **Agente Alert Analyst:** Analisa a recorrência de alertas e sugere ajustes de thresholds para evitar fadiga de alertas (Alert Fatigue).
- [ ] **Agente Post-Mortem Draft:** Coleta logs e métricas de um incidente recente para rascunhar um documento de Post-Mortem.

## 🚢 CI/CD e Segurança
- [ ] **Agente Pipeline Optimizer:** Analisa o tempo de execução dos steps de CI e sugere cacheamento ou paralelismo para acelerar o deploy.
- [ ] **Agente Vulnerability Patcher:** Identifica dependências vulneráveis e sugere PRs de atualização automaticamente.

## ☁️ FinOps e Cloud
- [ ] **Agente Cost Guardian:** Monitora gastos diários e alerta sobre picos anômalos de custo em serviços gerenciados.

## 🛠️ Troubleshoot
- [ ] **Agente K8s Debugger:** Analisa eventos de Pods (CrashLoopBackOff, OOMKilled) e sugere correções baseadas em logs.
