#!/bin/bash

ulimit -n 65536
riak start

#wait 60s time to ensure riak startup
sleep 60

#create DB and set  REPLICATIONFACTOR
riak-admin bucket-type create ycsb '{"props":{"n_val":$REPLICATIONFACTOR}}'

riak-admin bucket-type activate ycsb
