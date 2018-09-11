#!/bin/bash

# TODO: check if couchbase server is already running
sleep 30

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)



if [ "$NETWORK_TYPE" = "PUBLIC" ]
	then 
        echo "NETWORK_TYPE is PUBLIC"
		#Version 5.x (should also worjk for V4.x)
        /opt/couchbase/bin/couchbase-cli cluster-init -c $PUBLIC_ADDRESS:8091 --cluster-username=carlos --cluster-password=criminal --cluster-ramsize=$DATAMEMORY --cluster-index-ramsize=$INDEXMEMORY
	else 
		echo "NETWORK_TYPE not set or not set to PUBLIC, using PRIVATE network"
        #Version 5.x (should also worjk for V4.x)
        /opt/couchbase/bin/couchbase-cli cluster-init -c $LOCAL_ADDRESS:8091 --cluster-username=carlos --cluster-password=criminal --cluster-ramsize=$DATAMEMORY --cluster-index-ramsize=$INDEXMEMORY
fi  