#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

if [ "$NETWORK_TYPE" = "PUBLIC" ]
	then 
        echo "NETWORK_TYPE is PUBLIC"
		#Version 5.x (should also worjk for V4.x)
        /opt/couchbase/bin/couchbase-cli server-add --cluster=$PUBLIC_WEB_ADMIN_CONNECTION  --user carlos --password criminal --server-add=$LOCAL_ADDRESS:8091  --server-add-username=carlos --server-add-password=criminal
        /opt/couchbase/bin/couchbase-cli rebalance -c $PUBLIC_WEB_ADMIN_CONNECTION --user carlos --password criminal
	else 
		echo "NETWORK_TYPE not set or not set to PUBLIC, using PRIVATE network"
        #Version 5.x (should also worjk for V4.x)
        /opt/couchbase/bin/couchbase-cli server-add --cluster=$CONTAINER_WEB_ADMIN_CONNECTION  --user carlos --password criminal --server-add=$LOCAL_ADDRESS:8091  --server-add-username=carlos --server-add-password=criminal
        /opt/couchbase/bin/couchbase-cli rebalance -c $CONTAINER_WEB_ADMIN_CONNECTION --user carlos --password criminal
fi  

#Version 5.x (should also worjk for V4.x)
#/opt/couchbase/bin/couchbase-cli server-add --cluster=$CONTAINER_WEB_ADMIN_CONNECTION  --user carlos --password criminal --server-add=$LOCAL_ADDRESS:8091  --server-add-username=carlos --server-add-password=criminal
#/opt/couchbase/bin/couchbase-cli rebalance -c $CONTAINER_WEB_ADMIN_CONNECTION --user carlos --password criminal

#Version 4.x
#/opt/couchbase/bin/couchbase-cli rebalance  --cluster=$CONTAINER_WEB_ADMIN_CONNECTION  --user carlos --password criminal --server-add=$LOCAL_ADDRESS:8091  --server-add-username=carlos --server-add-password=criminal

