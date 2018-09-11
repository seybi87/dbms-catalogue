#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
LOCAL_DNS=$(dig +short -x $LOCAL_ADDRESS)

PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
PUBLIC_DNS=$(dig +short -x $PUBLIC_ADDRESS)

# seed node address for bootstrapping 
#sed -i "s/- seeds: \"127.0.0.1\"/- seeds: \"$LOCAL_ADDRESS\"/g" cassandra/conf/cassandra.yaml

##### IMPORTANT NOTE: DO NOT USE PRIVATE IP otherwise the Yugabyte will refuse connections (not clear why) #########

#enable detailed logging via --v 4

#starting Yugabyte master
nohup sudo ./yugabyte/bin/yb-master  --master_addresses $LOCAL_ADDRESS:7100 --rpc_bind_addresses $LOCAL_ADDRESS --replication_factor $REPLICATIONFACTOR --fs_data_dirs "$PWD/yb-disk"  >& $PWD/yb-master.out & 

echo "sleeping for 30s until yugabyte master is up and running...."
sleep 30

#starting Yugabyte server
nohup sudo ./yugabyte/bin/yb-tserver --tserver_master_addrs $LOCAL_ADDRESS:7100 --redis_proxy_bind_address $LOCAL_ADDRESS --cql_proxy_bind_address $LOCAL_ADDRESS --pgsql_proxy_bind_address $LOCAL_ADDRESS --rpc_bind_addresses $LOCAL_ADDRESS --local_ip_for_outbound_sockets $LOCAL_ADDRESS --fs_data_dirs "$PWD/yb-disk"  >& $PWD/yb-tserver.out &
echo "sleeping for 60s until yugabyte server is up and running...."
sleep 60


# create YCSB keyspace
#yugabyte/bin/cqlsh $LOCAL_ADDRESS  -f yugabyte/ycsb.cql >> cqlsh.out

