#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
PUBLIC_DNS=$(dig +short -x $PUBLIC_ADDRESS)

# version 3.x, 4.x
#/opt/couchbase/bin/couchbase-cli bucket-create -c $LOCAL_ADDRESS:8091 -u carlos -p criminal --bucket=ycsb --bucket-password=criminal  --enable-flush=1 --bucket-type=couchbase --bucket-ramsize=$DATAMEMEORY --bucket-priority=high --bucket-replica=$REPLICATIONFACTOR --wait;

# version 5.X, not yet officially supported by YCSB, needs a workaround by naming the bucket similar to the user

#Version 5.x (should also worjk for V4.x)
/opt/couchbase/bin/couchbase-cli bucket-create -c $LOCAL_ADDRESS:8091 -u carlos -p criminal --bucket=ycsb  --enable-flush=1 --bucket-type=couchbase --bucket-ramsize=$DATAMEMORY --bucket-priority=high --bucket-replica=$REPLICATIONFACTOR --wait;
/opt/couchbase/bin/couchbase-cli user-manage -c $LOCAL_ADDRESS --username carlos --password criminal --set --rbac-username ycsb --rbac-password criminal --rbac-name "Ycsb" --roles bucket_full_access[ycsb] --auth-domain local

	



#minimum autofailover timeout is 30s
if [ -z "$FAILOVER" ]; 
	then
		echo "Failover not activated! To enable failover set the FAILOVER en variable to true!"
	else
		echo "Enabling failover!"
        /opt/couchbase/bin/couchbase-cli setting-autofailover -c $LOCAL_ADDRESS:8091 -u carlos -p criminal --enable-auto-failover=1 --auto-failover-timeout=30
fi  


