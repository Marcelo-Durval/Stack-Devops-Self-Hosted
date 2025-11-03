#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Cria o usuário e o banco de dados para o N8N
    CREATE USER ${N8N_DB_USER} WITH PASSWORD '${N8N_DB_PASSWORD}';
    CREATE DATABASE ${N8N_DB_NAME} OWNER ${N8N_DB_USER};

    -- Cria o usuário e o banco de dados para o Appsmith
    CREATE USER ${APPSMITH_DB_USER} WITH PASSWORD '${APPSMITH_DB_PASSWORD}';
    CREATE DATABASE ${APPSMITH_DB_NAME} OWNER ${APPSMITH_DB_USER};
EOSQL