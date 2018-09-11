#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

#TODO: needs to be adapted for Yugabyte

# remote seed node address for bootstrapping 
if [ "$NETWORK_TYPE" = "PUBLIC" ]
	then 
        echo "NETWORK_TYPE is PUBLIC"
		#extract only IP from connection
        IFS=':' read -r -a array <<< "$PUBLIC_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
        nohup sudo ./yugabyte/bin/yb-tserver --tserver_master_addrs $SEED_IP:7100 --redis_proxy_bind_address $LOCAL_ADDRESS --cql_proxy_bind_address $LOCAL_ADDRESS --pgsql_proxy_bind_address $LOCAL_ADDRESS --rpc_bind_addresses $LOCAL_ADDRESS --local_ip_for_outbound_sockets $LOCAL_ADDRESS --fs_data_dirs "$PWD/yb-disk"  >& $PWD/yb-tserver.out &
        
	else 
		echo "NETWORK_TYPE not set or not set to PUBLIC, using PRIVATE network"
        #extract only IP from connection
        IFS=':' read -r -a array <<< "$CONTAINER_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
        nohup sudo ./yugabyte/bin/yb-tserver --tserver_master_addrs $SEED_IP:7100 --redis_proxy_bind_address $LOCAL_ADDRESS --cql_proxy_bind_address $LOCAL_ADDRESS --pgsql_proxy_bind_address $LOCAL_ADDRESS --rpc_bind_addresses $LOCAL_ADDRESS  --local_ip_for_outbound_sockets $LOCAL_ADDRESS --fs_data_dirs "$PWD/yb-disk"  >& $PWD/yb-tserver.out &
fi  

#cd cassandra/bin/

# IMPORTANT -Dcassandra.consistent.rangemovement=false otherwise adding data nodes in parallel will fail
# In a preloaded cluster this might cause (temporary) inconsistency of data  
#nohup sudo ./cassandra -R -Dcassandra.consistent.rangemovement=false >> /dev/null &


#echo "sleeping for 60s (120s recommended in ciscos blog post but with -Dcassandra.consistent.rangemovement=true) to ensure the finished rebalancing of the cassandra cluster...."
#sleep 60