#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')


# remote seed node address for bootstrapping 
if [ "$NETWORK_TYPE" = "PUBLIC" ]
	then 
        echo "NETWORK_TYPE is PUBLIC"
		#extract only IP from connection
        IFS=':' read -r -a array <<< "$PUBLIC_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
	else 
		echo "NETWORK_TYPE not set or not set to PUBLIC, using PRIVATE network"
        #extract only IP from connection
        IFS=':' read -r -a array <<< "$CONTAINER_CLUSTER_CONNECTION"
        SEED_IP=${array[0]}
        
fi  

#nohup sudo ./cockroachDB/cockroach start --insecure --host=$LOCAL_ADDRESS --join=$SEED_IP:26257 >data.out 2>&1 &

sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/enabled"
sudo bash -c "echo never > /sys/kernel/mm/transparent_hugepage/defrag"
./voltDB/bin/voltdb start --dir=voltdb_data --count=2 --host=$SEED_IP


echo "sleeping for 30s...."
sleep 30