#! /bin/bash
echo "************* BEGIN: Executing server-healthcheck.sh *************"
/opt/mssql-tools18/bin/sqlcmd -No -U sa -P ${MSSQL_SA_PASSWORD} -Q 'SELECT 1' || exit 1
