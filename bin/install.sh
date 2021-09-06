#!/bin/bash
set -eu

source .config
export POSTGRES_USER=postgres
DB_NAME=wells

replace_placeholders() {
    sed -i "s/DB_USER/$DB_USER/" data/create_user.sql
    sed -i "s/DB_PASSWORD/$DB_PASSWORD/" data/create_user.sql
}

setup_db() {
    psql -c "CREATE DATABASE $DB_NAME;"
    psql -d $DB_NAME -f data/create_db.sql
    psql -d $DB_NAME -f data/create_user.sql
}

main() {
    replace_placeholders
    setup_db
}


main
