```
# Remove todas as imagens não utilizadas, containers parados e caches de build
docker system prune -a -f

# 1. Limpa a tabela de dados pesados (o maior vilão)
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "TRUNCATE TABLE execution_data CASCADE;"

# 2. Limpa a tabela de histórico de execuções
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "TRUNCATE TABLE execution_entity CASCADE;"

# 3. Agora que as tabelas estão vazias, o VACUUM vai funcionar instantaneamente para devolver o espaço pro disco
docker exec -it $(docker ps -q -f name=postgres_postgres) psql -U postgres -d n8n -c "VACUUM FULL ANALYZE;"
```
```
export $(grep -v '^#' .env | xargs) && docker stack deploy -c n8n.yaml n8n
```
```
docker service update --force n8n_n8n_editor && docker service update --force n8n_n8n_webhook && docker service update --force n8n_n8n_worker
```