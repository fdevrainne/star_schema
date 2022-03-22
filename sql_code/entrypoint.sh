#!/bin/bash

echo 'Starting the container to run the sql codes'

psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB -a -f sql_code/create_schema.sql
psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB -a -f sql_code/load_data.sql
psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB -a -f sql_code/create_and_load_star_schema.sql
