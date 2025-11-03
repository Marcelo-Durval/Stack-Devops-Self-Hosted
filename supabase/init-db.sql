-- Arquivo: supabase/init-db.sql
-- Este script é rodado automaticamente pelo Postgres na primeira vez que ele inicia.
-- Ele usa as variáveis de ambiente do arquivo .env para criar os bancos.

-- Cria o usuário e o banco de dados para o N8N
CREATE USER ${N8N_DB_USER} WITH PASSWORD '${N8N_DB_PASSWORD}';
CREATE DATABASE ${N8N_DB_NAME} OWNER ${N8N_DB_USER};

-- Cria o usuário e o banco de dados para o Appsmith
CREATE USER ${APPSMITH_DB_USER} WITH PASSWORD '${APPSMITH_DB_PASSWORD}';
CREATE DATABASE ${APPSMITH_DB_NAME} OWNER ${APPSMITH_DB_USER};