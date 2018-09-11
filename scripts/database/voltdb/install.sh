#!/bin/bash


#Put the DBMS install commands here

#ulimit -n 65536

VOLTDB_VERSION=latest

rm /etc/hosts
echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts



# install java
sudo apt-get update -y
apt-get install openjdk-8-jre-headless -y

# install python
apt-get install python -y

# install ntp
sudo apt-get install ntp -y

# download cassandra binary
mkdir voltDB

#Binary form VoltDB
wget https://downloads.voltdb.com/technologies/server/voltdb-latest.tar.gz -O voltdb-latest.tar.gz
tar  -xzf voltdb-latest.tar.gz -C voltDB --strip 1



#GitHub
#https://github.com/VoltDB/voltdb/archive/voltdb-8.1.2.tar.gz


