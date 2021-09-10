#!/bin/bash
set -eu

source .config
export POSTGRES_USER=postgres
DB_NAME=wells

set_config() {
    sed -i "s/DB_USER/$DB_USER/" data/create_user.sql
    sed -i "s/DB_PASSWORD/$DB_PASSWORD/" data/create_user.sql
}

setup_db() {
    psql -c "CREATE DATABASE $DB_NAME;"
    psql -d $DB_NAME -f data/create_db.sql
    if [[ $READ_ONLY == true ]]; then
	psql -d $DB_NAME -c "REVOKE CREATE ON SCHEMA public FROM public;"
    fi
    psql -d $DB_NAME -f data/create_user.sql
}

main() {
    set_config
    setup_db
}


main
