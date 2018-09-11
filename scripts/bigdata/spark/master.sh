#!/bin/bash

#This is a simple install script to install Apache Spark on an ubuntu 14.04 Image on Openstack
#It is not tested on any other Image

#TODO: enable env var setting via REST API
SPARK_VERSION="2.1.0"
HADOOP_VERSION="2.7"

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')

./spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/sbin/start-master.sh --webui-port 9090 -h ${LOCAL_ADDRESS}
