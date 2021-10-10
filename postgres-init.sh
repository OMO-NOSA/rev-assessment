#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER django_user;
    CREATE DATABASE django_db;
    GRANT ALL PRIVILEGES ON DATABASE django_db TO django_user;
EOSQL
