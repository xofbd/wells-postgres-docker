#!/bin/bash

export POSTGRES_USER=postgres

DB_NAME=wells

psql -c "CREATE DATABASE $DB_NAME;"
psql -d $DB_NAME -f data/create_db.sql
psql -d $DB_NAME -f data/create_user.sql
