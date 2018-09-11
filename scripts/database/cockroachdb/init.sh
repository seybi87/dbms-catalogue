#!/bin/bash

#Put the DBMS initialising commands here: db creation
#sleep 30

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

#/opt/couchbase/bin/couchbase-cli cluster-init -c $LOCAL_ADDRESS:8091 --cluster-username=carlos --cluster-password=criminal --cluster-ramsize=$DATAMEMORY --cluster-index-ramsize=$INDEXMEMORY


#TODO: integrate replication factor, default is 3
#$REPLICATIONFACTOR