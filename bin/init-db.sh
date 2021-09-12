#!/bin/bash
#
# Initialization script for the database that is run by
# /usr/local/bin/docker-entrypoint.sh when container is created
set -eu

source .config
export POSTGRES_USER=postgres
DB_NAME=wells

main() {
    psql -c "CREATE DATABASE $DB_NAME;"
    psql -d $DB_NAME -f sql/create_db.sql
    if [[ $READ_ONLY == true ]]; then
        echo "Making $DB_USER read only..."
	psql -d $DB_NAME -c "REVOKE CREATE ON SCHEMA public FROM public;"
    fi
    psql -d $DB_NAME -f sql/create_user.sql
}


main
