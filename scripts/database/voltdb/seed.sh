#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"

#TODO: add nohup
#TODO: add env for number of nodes
./voltDB/bin/voltdb start --dir=voltdb_data --count=2 --host=$LOCAL_ADDRESS


#nohup sudo ./cockroachDB/cockroach start --insecure --host=$LOCAL_ADDRESS >seed.out 2>&1 &


echo "sleeping for 90s until CockroachDB is up and running...."
sleep 90

# create usertable (no YCSB DB required as databases do not exist in VoltDB)

echo "CREATE TABLE usertable (YCSB_KEY VARCHAR(255) PRIMARY KEY, FIELD0 VARCHAR(255), FIELD1 VARCHAR(255), FIELD2 VARCHAR(255), FIELD3 VARCHAR(255), FIELD4 VARCHAR(255), FIELD5 VARCHAR(255), FIELD6 VARCHAR(255), FIELD7 VARCHAR(255), FIELD8 VARCHAR(255), FIELD9 VARCHAR(255));" | ./voltDB/bin/sqlcmd --servers=$LOCAL_ADDRESS


