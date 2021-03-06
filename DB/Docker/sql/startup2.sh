#!/bin/bash
database=SecMaster
wait_time=15s
password=PMFinTech@

echo importing data will start in $wait_time...
sleep $wait_time
echo importing data...

echo $password
/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i ./init.sql

for entry in $(find ./tables -iname '*.sql'); 
do
  echo executing $entry
  /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
done

for entry in $(find ./procs -iname '*.sql');
do
  echo executing $entry
  /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $password -i $entry
done


for entry in $(find ./data -iname '*.csv');
do
  shortname=$(echo $entry | cut -f 2 -d '.' | cut -f 3 -d '/')
  tableName=$database.dbo.$shortname
  echo importing $tableName from $entry
  /opt/mssql-tools/bin/bcp $tableName in $entry -c -t',' -F 2 -S 0.0.0.0 -U sa -P $password
done

echo finished running startup