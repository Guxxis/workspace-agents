---
tags: [apresentacao, executivo, roadmap, devops, pitch]
description: Estrutura detalhada para apresentação aos superiores sobre o projeto de Infraestrutura e CI/CD.
type: work
---

# 📊 Storytelling: Projeto de Modernização de Infraestrutura e CI/CD

Este roteiro foi estruturado para uma narrativa convincente, do problema à solução, ideal para uso no **NotebookLM**.

## 1. Apresentação e Objetivo do Projeto
*O "Porquê" da mudança - Radiografia do Caos Atual.*

- **Cenário Atual (Diagnóstico)**:
    - **Cultura de "Código Local"**: Repositórios são criados apenas no fim do projeto; desenvolvimento sem versionamento ou backup.
    - **Caos de Governança**: Deploy 100% manual feito pelos devs; não há rastro do que foi alterado.
    - **Insegurança Crítica**: Desenvolvedores com acesso **root** em servidores de produção; ambientes de homologação e produção misturados.
    - **Desconexão de Ferramentas**: Bitbucket e Jira não se conversam; o Bitbucket é "terra de ninguém".
    - **Solicitação Tardia**: Ambientes são pedidos na hora da entrega, gerando correria e erros.

- **Problemas Críticos Identificados**:
    - **Risco de Perda de Código**: Sem commits desde o dia 1, um problema local no PC do dev é fatal.
    - **Gargalos de Deploy**: Dependência total da disponibilidade do dev para subir código.
    - **Inconsistência de Stack**: Falta de diretriz entre Laravel (padrão) e novas linguagens (Typescript).

- **Proposta de Solução (O Remédio)**:
    - **Padronização de Stack**: Laravel para core/sistemas e Typescript para PoCs e IA.
    - **Automatização (Jenkins)**: Fim do deploy manual; pipelines cuidam da entrega com segurança.
    - **Governança de Acessos**: Revogação de acessos root; centralização via **Guacamole** e proteção de homologação com **htpasswd** para acesso via web.
    - **Sincronia Jira-Bitbucket**: Vínculo obrigatório para rastreabilidade de cada linha de código.
    - **Integração DevOps no Ciclo de Vida**: O DevOps deixa de ser um "apagador de incêndio" e vira parte do fluxo. Solicitações de ambiente via Jira, com prazos e responsáveis claros.
- **Cultura de Commit Antecipado**: Workshop para mudar o mindset: versionamento desde o primeiro dia.

- **Ganhos Esperados (Cenário Pós-Melhoria)**:
    - **Rastreabilidade Total**: Saber qual card do Jira gerou qual commit e quando foi para o ar.
    - **Velocidade e Qualidade**: Testes automatizados e deploys rápidos reduzem o tempo de entrega e bugs em produção.
    - **Organização Escalável**: Facilidade para configurar novos projetos e ambientes em minutos, não dias.
- **Previsibilidade Total**: Fim das surpresas na entrega. A infraestrutura é planejada e configurada junto com o início do desenvolvimento.

## 2. Padronização e Organização
*O "Como" vamos estruturar a base - Eficiência através da Norma.*

- **Bitbucket (Governança de Código)**:
    - **Organização por Empresa**: Projetos segmentados (MPI Solutions, Busca Cliente, etc.).
    - **Nomenclatura Técnica**: Repositórios seguindo o padrão `funcao.sistema.dominio.extensao` (ex: `api.portal.idealtrends.io`).
    - **Limpeza de SSH**: Centralização de chaves de servidores em conta única (`devops@`) e chaves pessoais em perfis individuais.

- **Gitflow (Fluxo de Trabalho)**:
    - **Branches Blindadas**: `main` e `develop` bloqueadas para push; alterações apenas via Pull Request aprovado pelo DevOps.
    - **Padrão de Nomeclatura**: Obrigatoriedade do ID do Card Jira em todas as branches temporárias (`feature/INCE-123-login`).
    - **Automação de Limpeza**: Branches temporárias excluídas automaticamente após o merge.
    - > [!NOTE]
    - > **[INSERIR DIAGRAMA EXCALIDRAW: FLUXO GITFLOW]** - Visualização de como o código viaja da feature até a produção com segurança.

- **Commit & Tag (Rastreabilidade)**:
    - **Conventional Commits**: Mensagens claras e padronizadas para gerar logs automáticos.
    - **Semantic Versioning (SemVer)**: Controle de versão (Major.Minor.Patch) para rastrear o impacto de cada entrega.

- **CI/CD (Automação de Esteira)**:
    - **PR para Develop**: Disparo automático de testes unitários e linters (garantia de qualidade antes do merge).
    - **Merge para Develop**: Deploy imediato em Homologação.
    - **Release/Produção**: Testes E2E, geração de tags e deploy automático em produção com sincronia reversa para garantir a estabilidade.

- **Famílias de Servidores (Gestão de Custo e Infra)**:
    - **Segregação por Unidade de Negócio**: Servidores agrupados por empresa para controle operacional e de custo.
    - **Estrutura por Grupo**: Cada "família" possui seus servidores de Homolog, Prod e Infra (Firewall).
    - **Infraestrutura como Código (IaC)**: Uso de **Terraform** e **Ansible** para o provisionamento do Jumphost (Digital Ocean), garantindo que a infra central seja replicável e documentada via código.
    - > [!NOTE]
    - > **[INSERIR DIAGRAMA EXCALIDRAW: ARQUITETURA JUMPHOST]** - Como o Bastion centraliza a segurança e isola a produção.

- **Scaffolding (Onboarding)**:
    - **Questionário Padrão**: Definição automática de stack, repositório e pipeline no início de cada projeto.

## 3. Travas e Desafios (Riscos)
*O que pode atrasar ou dificultar o projeto.*

- **Resistência Cultural**: Mudança no workflow diário dos desenvolvedores (ex: fim do push direto na main).
- **Curva de Aprendizado**: Adaptação às novas ferramentas (Jenkins, Gitflow, Conventional Commits).
- **Legado Complexo**: A limpeza inicial de SSHs e repositórios antigos pode ser mais demorada que o previsto.
- **Dependências Externas**: Necessidade de criação de contas centrais (TI) e liberação de acessos em firewalls externos.
- **Manutenção do Ritmo de Entrega**: Conciliar a migração com as entregas de projetos em andamento.

## 4. Custo e Investimento
*Quanto custa a profissionalização e qual o retorno (ROI).*

- **Infraestrutura de Servidores (Cloud/Local)**:
    - **Servidor Central (Jumphost/Jenkins)**: 01 Instância (ex: 4 vCPU, 8GB RAM, 100GB SSD). Custo estimado baixo (aprox. $20-$40/mês se for cloud).
    - **Observabilidade**: Sem custo de licença (Open Source).
- **Ferramentas (Software)**:
    - **Custo Zero em Licenciamento**: Jenkins (Automação), Grafana/Zabbix (Monitoramento), Guacamole (Segurança), htpasswd (Privacidade).
- **Recurso Humano & Tempo**:
    - **Tempo de Implantação**: 4 semanas de dedicação focada para o setup inicial e PoC.
    - **Treinamentos**: 02 Workshops internos (2h cada) para nivelamento técnico do time.
- **ROI (Retorno sobre Investimento)**:
    - **Redução de Downtime**: Monitoramento proativo evita quedas e perda de vendas.
    - **Eficiência Operacional**: Deploys em segundos, não minutos/horas.
    - **Mitigação de Risco**: Proteção contra perda de código e acessos indevidos (Segurança).

### 📊 Comparativo: O Salto de Qualidade

| Critério | Cenário Atual (Caos) | Novo Padrão (DevOps) |
| :--- | :--- | :--- |
| **Segurança** | Devs com acesso Root | Acesso via Jumphost (Auditado) |
| **Versionamento** | Código local (risco alto) | Bitbucket desde o Dia 1 |
| **Deploy** | Manual (15-30 min) | Automático (< 2 min) |
| **Ambientes** | Misturados / Confusos | Segregados (Homolog/Prod) |
| **Visibilidade** | Nenhuma / Caixa Preta | Dashboards Zabbix/Grafana |
| **Rastreabilidade** | "Quem subiu o que?" | Link Jira-Commit Automático |

## 5. Plano de Implantação (Roadmap)
*O cronograma para a transformação digital.*

- **Semana 1: Fundação & Governança**:
    - Setup do servidor Jumphost e Hardening.
    - Instalação do Jenkins, Zabbix e Grafana.
    - Organização de Acessos e Grupos no Bitbucket/Jira.
- **Semana 2: O Piloto (PoC - Ideal Plus)**:
    - Migração e padronização do primeiro projeto real.
    - Implementação da Pipeline Jenkinsfile (Build -> Test -> Homolog -> Prod).
    - Validação do fluxo de Gitflow com o time.
- **Semana 3: Expansão & Segurança**:
    - Configuração de SSHs centralizados e revogação de acessos diretos.
    - Implementação do Guacamole e proteção htpasswd global.
    - Configuração de Alertas no Slack/Discord.
- **Semana 4: Consolidação & Treinamento**:
    - Workshops de cultura de Commit e Gitflow.
    - Rollout da padronização para os demais repositórios.
    - Dashboards finais de monitoramento.

---
> [!TIP]
> Ao apresentar, foque em como a **Padronização** resolve o cenário de "bagunça" atual, transformando a TI em um acelerador de negócios.
