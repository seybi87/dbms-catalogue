#!/bin/bash

#This is a simple install script to install Apache Spark on an ubuntu 14.04 Image on Openstack


#TODO: enable env var setting via REST API
SPARK_VERSION="2.1.0"
HADOOP_VERSION="2.7"


#fix etc/hosts
rm /etc/hosts
echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts

#upate packages
apt-get update

#install Java 8
sudo apt-add-repository ppa:webupd8team/java -y
sudo apt-get update -y
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install oracle-java8-installer -y


#set JAVA Home
#echo 'JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk-amd64"' >> /etc/environment
echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle/bin/"' >> /etc/environment

#install maven to build apps on the node
#apt-get install -y maven

#download spark with hadoop binaries (binareis are also necessary for standalone mode)
wget https://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#extract
tar -xvzf  spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#download a sample file for the wordcount example job
# 10KB sample file
# wget -O /home/ubuntu/words.txt https://raw.githubusercontent.com/melphi/spark-examples/master/first-example/src/test/resources/loremipsum.txt
# 6MB sample
# wget -O /home/ubuntu/words.txt http://norvig.com/big.txt
# 100MB sample
wget -O /home/ubuntu/words.txt https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/jquery-speedtest/100MB.txt