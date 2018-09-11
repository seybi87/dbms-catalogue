#!/bin/bash
ulimit -n 65536
riak start

while  ! riak ping | grep -q pong
do
        echo "riak not yet running"
        sleep 10
done

#extract only IP from connection
IFS=':' read -r -a array <<< "$CONTAINER_PROTOBUF_CONNECTION"
SEED_IP=${array[0]}

echo "RIAK SEED_IP is:"$SEED_IP

#riak-admin cluster join riak@$SEED_IP

while  riak-admin cluster join riak@$SEED_IP | grep -q "Join failed"
do
        echo "Riak join not yet possible, trying again in 10s"
        sleep 10
done

riak-admin cluster plan

riak-admin cluster commit