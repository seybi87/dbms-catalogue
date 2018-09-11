#Mesos Slave installation

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

#stop zookeeper
sudo stop zookeeper
echo manual | sudo tee /etc/init/zookeeper.override

# stop mesos master (shouldn't be running anyway)
echo manual | sudo tee /etc/init/mesos-master.override
sudo stop mesos-master

# configure ZK to resolve mesos master
echo zk://192.168.0.226:2181/mesos | sudo tee /etc/mesos/zk


#optional: enable docker containers
wget https://raw.githubusercontent.com/cloudiator/lance/master/install/docker_retry_fix_version.sh
chmod +x docker...

./dock...

echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '10mins' > /etc/mesos-slave/executor_registration_timeout