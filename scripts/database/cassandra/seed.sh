#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

# seed node address for bootstrapping 
sed -i "s/- seeds: \"127.0.0.1\"/- seeds: \"$LOCAL_ADDRESS\"/g" cassandra/conf/cassandra.yaml


nohup sudo ./cassandra/bin/cassandra -R >> /dev/null &


echo "sleeping for 30s until cassandra is up and running...."
sleep 60

# create YCSB keyspace
cassandra/bin/cqlsh  -f cassandra/ycsb.cql $LOCAL_ADDRESS >> cqlsh.out

