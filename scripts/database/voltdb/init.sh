#!/bin/bash

#Put the DBMS initialising commands here: db creation
#sleep 30

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')


#TODO: integrate replication factor, default is 3
#$REPLICATIONFACTOR

mkdir voltdb_data

./voltDB/bin/voltdb init --dir=voltdb_data