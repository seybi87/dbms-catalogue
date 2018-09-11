#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')


# remote seed node address for bootstrapping 
if [ "$NETWORK_TYPE" = "PUBLIC" ]
	then 
        echo "NETWORK_TYPE is PUBLIC"
		#extract only IP from connection
        IFS=':' read -r -a array <<< "$PUBLIC_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
        sed -i "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEED_IP\"/g" cassandra/conf/cassandra.yaml
	else 
		echo "NETWORK_TYPE not set or not set to PUBLIC, using PRIVATE network"
        #extract only IP from connection
        IFS=':' read -r -a array <<< "$CONTAINER_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
        sed -i "s/- seeds: \"127.0.0.1\"/- seeds: \"$SEED_IP\"/g" cassandra/conf/cassandra.yaml
fi  

cd cassandra/bin/

# IMPORTANT -Dcassandra.consistent.rangemovement=false otherwise adding data nodes in parallel will fail
# In a preloaded cluster this might cause (temporary) inconsistency of data  
nohup sudo ./cassandra -R -Dcassandra.consistent.rangemovement=false >> /dev/null &


echo "sleeping for 60s (120s recommended in ciscos blog post but with -Dcassandra.consistent.rangemovement=true) to ensure the finished rebalancing of the cassandra cluster...."
sleep 60