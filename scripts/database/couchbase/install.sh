#!/bin/bash

#ulimit -n 65536

LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
LOCAL_DNS=$(dig +short -x $LOCAL_ADDRESS)

PUBLIC_ADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
PUBLIC_DNS=$(dig +short -x $PUBLIC_ADDRESS)

# add to env to use later with telegraf
echo "export PRIVATE_IP=$LOCAL_ADDRESS" >> /etc/environment
echo "export PUBLIC_IP=$PUBLIC_ADDRESS" >> /etc/environment



######### hostname issue with Ubuntu 14.04 and using public IPs on BwCloud
#rm /etc/hostname
#echo  $PUBLIC_DNS  >> /etc/hostname
#fix hostname
rm /etc/hosts
echo 127.0.0.1 localhost `hostname` $LOCAL_DNS $PUBLIC_DNS  >> /etc/hosts
#echo 127.0.0.1  $PUBLIC_DNS  >> /etc/hosts
#echo $LOCAL_ADDRESS $LOCAL_DNS $PUBLIC_DNS >> /etc/hosts
#echo $PUBLIC_ADDRESS $PUBLIC_DNS >> /etc/hosts


# install python-minimal for  cli
apt-get install python-minimal python-httplib2 -y

#COUCBASE_VERSION=4.5.1
#COUCHBASE_BINARY=couchbase-server-community_4.5.1-ubuntu14.04_amd64.deb

#Not yet supported by YCSB
#Enterpsie version: https://packages.couchbase.com/releases/5.1.0/couchbase-server-enterprise_5.1.0-ubuntu16.04_amd64.deb
COUCHBASE_VERSION=5.0.1
COUCHBASE_BINARY=couchbase-server-community_5.0.1-ubuntu16.04_amd64.deb

wget https://packages.couchbase.com/releases/$COUCHBASE_VERSION/$COUCHBASE_BINARY

dpkg -i $COUCHBASE_BINARY
