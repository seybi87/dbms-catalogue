#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

sed -i -- "s/listener.protobuf.internal = 127.0.0.1:8087/listener.protobuf.internal = $LOCAL_ADDRESS:8087/g"  /etc/riak/riak.conf

sed -i -- "s/nodename = riak@127.0.0.1/nodename = riak@$LOCAL_ADDRESS/g"  /etc/riak/riak.conf


#WEB UI configuration
sed -i -- "s/riak_control = off/riak_control = on/g"  /etc/riak/riak.conf

sed -i  --  "s/listener.http.internal = 127.0.0.1:8098/listener.http.internal = $LOCAL_ADDRESS:8098/g"  /etc/riak/riak.conf 

#add fixed port range for inter-node communication
echo "erlang.distribution.port_range.minimum = 6000" >> /etc/riak/riak.conf 
echo "erlang.distribution.port_range.maximum = 7999" >> /etc/riak/riak.conf 