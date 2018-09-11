#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')


nohup sudo ./cockroachDB/cockroach start --insecure --host=$LOCAL_ADDRESS >seed.out 2>&1 &


echo "sleeping for 90s until CockroachDB is up and running...."
sleep 90

# create YCSB table
./cockroachDB/cockroach sql --insecure --host=$LOCAL_ADDRESS -e "CREATE DATABASE ycsb;"
./cockroachDB/cockroach sql --insecure --host=$LOCAL_ADDRESS -e "CREATE TABLE ycsb.usertable (YCSB_KEY VARCHAR(255) PRIMARY KEY, FIELD0 TEXT, FIELD1 TEXT, FIELD2 TEXT, FIELD3 TEXT, FIELD4 TEXT, FIELD5 TEXT, FIELD6 TEXT, FIELD7 TEXT, FIELD8 TEXT, FIELD9 TEXT);"

