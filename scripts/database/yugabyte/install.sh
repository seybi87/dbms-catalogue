#!/bin/bash

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
LOCAL_DNS=$(dig +short -x $LOCAL_ADDRESS)

PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
PUBLIC_DNS=$(dig +short -x $PUBLIC_ADDRESS)

#Put the DBMS install commands here

#ulimit -n 65536

YUGABYTE_VERSION=1.0.3.0

rm /etc/hosts
echo 127.0.0.1 `hostname` $LOCAL_DNS $PUBLIC_DNS | sudo tee /etc/hosts

# install java
sudo apt-get update -y
apt-get install openjdk-8-jre-headless -y

# install python-minimal for cql cli
apt-get install python-minimal -y


# download cassandra binary
wget https://downloads.yugabyte.com/yugabyte-ce-$YUGABYTE_VERSION-linux.tar.gz

mkdir yugabyte
mkdir yb-disk


tar -pxvzf yugabyte-ce-$YUGABYTE_VERSION-linux.tar.gz -C yugabyte --strip 1

./yugabyte/bin/post_install.sh


