---
tags: [docker, n8n, maintenance, snippets]
description: Comandos para limpeza de volumes, truncar tabelas do n8n e deploy de stack.
type: work
---

# 🐳 Docker & n8n Maintenance Snippets

## Limpeza de Banco de Dados (Postgres n8n)
Executar dentro do servidor onde o stack está rodando.

```bash
# Remove todas as imagens não utilizadas, containers parados e caches de build
docker system prune -a -f

# 1. Limpa a tabela de dados pesados (o maior vilão)
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "TRUNCATE TABLE execution_data CASCADE;"

# 2. Limpa a tabela de histórico de execuções
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "TRUNCATE TABLE execution_entity CASCADE;"

# 3. Agora que as tabelas estão vazias, o VACUUM vai funcionar instantaneamente para devolver o espaço pro disco
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "VACUUM FULL ANALYZE;"
```

## Deploy e Atualização
```bash
# Deploy da stack n8n
export $(grep -v '^#' .env | xargs) && docker stack deploy -c n8n.yaml n8n

# Forçar atualização dos serviços
docker service update --force n8n_n8n_editor && docker service update --force n8n_n8n_webhook && docker service update --force n8n_n8n_worker
```
