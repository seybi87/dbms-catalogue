

#Mesos Master installation

#based on: https://www.digitalocean.com/community/tutorials/how-to-configure-a-production-ready-mesosphere-cluster-on-ubuntu-14-04

#TODO: set hostname to 0.0.0.0

##init

rm /etc/hosts

sudo echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list

sudo apt-get -y update

sudo apt-get install mesosphere -y

##zookeeper

#modify zk config
sudo nano /etc/mesos/zk

# create unique zk id
nano /etc/zookeeper/conf/myid

#update zookeeper config
nano /etc/zookeeper/conf/zoo.cfg

#optional: modify quorum
nano /etc/mesos-master/quorum


##mesos master

#set ip addresses
LOCAL_ADDRESS=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
echo ${LOCAL_ADDRESS} | sudo tee /etc/mesos-master/ip
sudo cp /etc/mesos-master/ip /etc/mesos-master/hostname

##marathon

sudo mkdir -p /etc/marathon/conf
sudo cp /etc/mesos-master/hostname /etc/marathon/conf

sudo cp /etc/mesos/zk /etc/marathon/conf/master

sudo cp /etc/marathon/conf/master /etc/marathon/conf/zk

# configure zk for marathon

echo "zk://"${LOCAL_ADDRESS}":2181/marathon" > /etc/marathon/conf/zk

#optional, ensure that no slave process is running
sudo stop mesos-slave
echo manual | sudo tee /etc/init/mesos-slave.override