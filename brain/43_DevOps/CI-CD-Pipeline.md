---
tags: [devops, automation, ci-cd, github-actions]
description: Estratégia de automação de deploys utilizando GitHub Actions.
type: work
---
# 🚀 Pipeline de CI/CD

## 🛠️ Fluxo Automatizado
Utilizamos o **GitHub Actions** para garantir que cada commit na `main` resulte em uma versão estável em produção.

### Etapas do Workflow:
1. **Lint & Test**: Validação de código Angular e testes unitários.
2. **Docker Build**: Criação da imagem da aplicação.
3. **Docker Push**: Envio para o registry (ex: `guxxis/freela-backend:latest`).
4. **Deploy**:
    - Conexão SSH via chaves seguras (Secrets).
    - Comando `docker service update` para o Swarm realizar o rolling update.

---

## 📁 Variáveis de Ambiente
- `DATABASE_URL`: Injetado via Docker Secrets ou Environment Variables no Swarm.
- `API_KEY`: Chave única para comunicação segura entre front e back.
