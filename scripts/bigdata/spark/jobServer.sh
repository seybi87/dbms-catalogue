#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

SPARK_DIR="$(pwd)/spark-2.1.0-bin-hadoop2.7"

wget http://download.knime.org/store/3.5/spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp.tar.gz

tar xzf spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp.tar.gz

mkdir  - p /var/log/spark-job-server
 
sed -i -- "s/local\[4\]/spark:\/\/$LOCAL_ADDRESS:7077/g" spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp/environment.conf
 
sed -i --  's/spark.sql.warehouse.dir/# spark.sql.warehouse.dir/g'  spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp/environment.conf
 
 
sed -i --  's/spark.sql.catalogImplementation = \"hive\"/spark.sql.catalogImplementation = \"in-memory\"/g' spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp/environment.conf

sed -i -- "s#SPARK_HOME=\/usr\/hdp\/current\/spark2-client#SPARK_HOME=$SPARK_DIR#g" spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp/settings.sh
 
 #job server needs to be started from source directory!
 cd spark-job-server-0.7.0.3-KNIME_spark-2.1_hdp
 ./server_start.sh
 cd ..