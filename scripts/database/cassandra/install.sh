#!/bin/bash


LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

# add to env to use later with telegraf
echo "export PRIVATE_IP=$LOCAL_ADDRESS" >> /etc/environment
echo "export PUBLIC_IP=$PUBLIC_ADDRESS" >> /etc/environment

#Put the DBMS install commands here

#ulimit -n 65536

CASSANDRA_VERSION=3.11.2

rm /etc/hosts
echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts

# install java
sudo apt-get update -y
apt-get install openjdk-8-jre-headless -y

# install python-minimal for cql cli
apt-get install python-minimal -y


# download cassandra binary
wget http://mirror.23media.de/apache/cassandra/3.11.2/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz

mkdir cassandra

tar -xzf apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz -C cassandra --strip 1


# monitoring agent to enable metric collection via telegraf

#add jolokia agent to cassandra lib folder
wget http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.5.0/jolokia-jvm-1.5.0-agent.jar -O cassandra/lib/jolokia-jvm-1.5.0-agent.jar 

#add agent to jvm options config 
echo "-javaagent:$PWD/cassandra/lib/jolokia-jvm-1.5.0-agent.jar" >> cassandra/conf/jvm.options