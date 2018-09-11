#!/bin/bash

#Put the DBMS initialising commands here: db creation
sleep 30

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

#/opt/couchbase/bin/couchbase-cli cluster-init -c $LOCAL_ADDRESS:8091 --cluster-username=carlos --cluster-password=criminal --cluster-ramsize=$DATAMEMORY --cluster-index-ramsize=$INDEXMEMORY

# cluster name
sed -i "s/cluster_name: 'Test Cluster'/cluster_name: 'DB-Evaluator'/g" cassandra/conf/cassandra.yaml
# internal cluster communication 
sed -i "s/listen_address: localhost/listen_address: $LOCAL_ADDRESS/g" cassandra/conf/cassandra.yaml
# remote client connections
sed -i "s/rpc_address: localhost/rpc_address: $LOCAL_ADDRESS/g" cassandra/conf/cassandra.yaml

#Write CQL file to configure 
touch cassandra/ycsb.cql 

echo "create keyspace ycsb WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor': $REPLICATIONFACTOR };" >> cassandra/ycsb.cql 
echo "USE ycsb;" >> cassandra/ycsb.cql 
echo "create table usertable (y_id varchar primary key, field0 varchar, field1 varchar, field2 varchar, field3 varchar, field4 varchar, field5 varchar, field6 varchar, field7 varchar, field8 varchar, field9 varchar);" >> cassandra/ycsb.cql 


## optional configuration variables for performance tuning
# concurrent_write threads, default=32, recommended 8 x number of cores
if [ -z "$CONCURRENT_WRITES" ]; 
	then
		echo "CONCURRENT_WRITES not set, using default value in Cassandra yaml!"
	else
		echo "Setting custom CONCURRENT_WRITES to $CONCURRENT_WRITES!"
        sed -i "s/concurrent_writes: 32/concurrent_writes: $CONCURRENT_WRITES/g" cassandra/conf/cassandra.yaml
fi  


#This sets the amount of memtable flush writer threads.  These will
# be blocked by disk io, and each one will hold a memtable in memory
# while blocked. If you have a large heap and many data directories,
# you can increase this value for better flush performance.
# By default this will be set to the amount of data directories defined.
# max value is 8
if [ -z "$MEMTABLE_FLUSH_WRITERS" ]; 
	then
		echo "MEMTABLE_FLUSH_WRITERS not set, using default value in Cassandra yaml!"
	else
		echo "Setting custom MEMTABLE_FLUSH_WRITERS to $MEMTABLE_FLUSH_WRITERS!"
        sed -i "s/#memtable_flush_writers: 1/memtable_flush_writers: $MEMTABLE_FLUSH_WRITERS/g" cassandra/conf/cassandra.yaml
fi  


# Total memory to use for SSTable-reading buffers.
# file_cache_size_in_mb
if [ -z "$FILE_CACHE_SIZE_IN_MB" ]; 
	then
		echo "FILE_CACHE_SIZE_IN_MB not set, using default value in Cassandra yaml!"
	else
		echo "Setting custom FILE_CACHE_SIZE_IN_MB to $FILE_CACHE_SIZE_IN_MB!"
        sed -i "s/# file_cache_size_in_mb: 512/file_cache_size_in_mb: $FILE_CACHE_SIZE_IN_MB/g" cassandra/conf/cassandra.yaml
fi  


# Total memory to use JVM.
#MAX_HEAP_SIZE="4G"
if [ -z "$MAX_HEAP_SIZE" ]; 
	then
		echo "MAX_HEAP_SIZE not set, using default value in Cassandra yaml!"
	else
		echo "Setting custom MAX_HEAP_SIZE to $MAX_HEAP_SIZE!"
        sed -i "s/#MAX_HEAP_SIZE=\"4G\"/MAX_HEAP_SIZE=\"$MAX_HEAP_SIZE\"/g" cassandra/conf/cassandra-env.sh
fi  


# Total memory to use JVM for young generation, default is 100 X number of cores
#HEAP_NEWSIZE="800M"
if [ -z "$MAX_NEW_HEAP_SIZE" ]; 
	then
		echo "MAX_NEW_HEAP_SIZE not set, using default value in Cassandra yaml!"
	else
		echo "Setting custom MAX_NEW_HEAP_SIZE to $MAX_NEW_HEAP_SIZE!"
        sed -i "s/#HEAP_NEWSIZE=\"800M\"/HEAP_NEWSIZE=\"$MAX_NEW_HEAP_SIZE\"/g" cassandra/conf/cassandra-env.sh
fi  