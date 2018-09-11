#!/bin/bash

#Put the DBMS initialising commands here: db creation
sleep 30

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

# cluster name
#sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'DB-Evaluator'/g" cassandra/conf/cassandra.yaml
# internal cluster communication 
#sed -i "s/listen_address: localhost/listen_address: $LOCAL_ADDRESS/g" cassandra/conf/cassandra.yaml
# remote client connections
#sed -i "s/rpc_address: localhost/rpc_address: $LOCAL_ADDRESS/g" cassandra/conf/cassandra.yaml

#Write CQL file to configure 
touch yugabyte/ycsb.cql 

echo "create keyspace ycsb WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': $REPLICATIONFACTOR };" >> yugabyte/ycsb.cql 
echo "USE ycsb;" >> yugabyte/ycsb.cql 
echo "create table usertable (y_id varchar primary key, field0 varchar, field1 varchar, field2 varchar, field3 varchar, field4 varchar, field5 varchar, field6 varchar, field7 varchar, field8 varchar, field9 varchar);" >> yugabyte/ycsb.cql 



#sed -i \"s/listen_address: localhost/listen_address: $LOCALIP/g\" $CONFIG; \
#sed -i \"s/rpc_address: localhost/rpc_address: 0.0.0.0/g\" $CONFIG; \
#sed -i \"s/# broadcast_rpc_address: 1.2.3.4/broadcast_rpc_address: $LOCALIP/g\" $CONFIG;"