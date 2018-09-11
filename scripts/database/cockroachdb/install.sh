#!/bin/bash


LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)

# add to env to use later with telegraf
echo "export PRIVATE_IP=$LOCAL_ADDRESS" >> /etc/environment
echo "export PUBLIC_IP=$PUBLIC_ADDRESS" >> /etc/environment

#Put the DBMS install commands here

#ulimit -n 65536

COCKROACHDB_VERSION=2.0.3

rm /etc/hosts
echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts

# install java
#sudo apt-get update -y
#apt-get install openjdk-8-jre-headless -y

# install python-minimal for cql cli
#apt-get install python-minimal -y


# download cassandra binary
mkdir cockroachDB
wget -qO- https://binaries.cockroachdb.com/cockroach-v$COCKROACHDB_VERSION.linux-amd64.tgz | tar  xvz -C cockroachDB --strip 1


