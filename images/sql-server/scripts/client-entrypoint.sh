#! /bin/bash
echo "************* BEGIN: Executing client-entrypoint.sh *************"

/opt/mssql-tools18/bin/sqlcmd -No -S db-server -U sa -P ${MSSQL_SA_PASSWORD} -i /tmp/a_my_src/db/db-create.sql

echo "************* END: Executing client-entrypoint.sh ***************"
