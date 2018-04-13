#!/bin/bash
database=SecMaster
wait_time=15s
password=PMFinTEch@

echo importing data will start in $wait_time...
sleep $wait_time
echo importing data...

/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i ./init.sql

for entry in "table/*.sql"
do
  echo executing $entry
  /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
done

for entry in "procs/*.sql"
do
  echo executing $entry
  /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
done


for entry in "data/*.csv"
do
  shortname=$(echo $entry | cut -f 1 -d '.' | cut -f 2 -d '/')
  tableName=$database.dbo.$shortname
  echo importing $tableName from $entry
  /opt/mssql-tools/bin/bcp $tableName in $entry -c -t',' -F 2 -S 0.0.0.0 -U sa -P $password
done