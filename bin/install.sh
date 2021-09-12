#!/bin/bash
set -eu

source .config
export POSTGRES_USER=postgres
DB_NAME=wells

main() {
    psql -c "CREATE DATABASE $DB_NAME;"
    psql -d $DB_NAME -f data/create_db.sql
    if [[ $READ_ONLY == true ]]; then
        echo "Making $DB_USER read only..."
	psql -d $DB_NAME -c "REVOKE CREATE ON SCHEMA public FROM public;"
    fi
    psql -d $DB_NAME -f data/create_user.sql
}


main
