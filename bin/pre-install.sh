#!/bin/bash
#
# Pre-install tasks to run before calling the entry point script.
set -eu

source .config

lock_db() {
    if [[ $LOCK_DB == true ]]; then
	echo "Locking admin account..."
	sed -i "s/all all all/all $DB_USER all/g" /usr/local/bin/docker-entrypoint.sh
    fi
}

set_config() {
    sed -i "s/DB_USER/$DB_USER/" data/create_user.sql
    sed -i "s/DB_PASSWORD/$DB_PASSWORD/" data/create_user.sql
}

main() {
    lock_db
    set_config
}


main
