#!/bin/bash


RIAK_VERSION=2.2.3-1

rm /etc/hosts
echo 127.0.0.1 localhost.localdomain localhost `hostname` | sudo tee /etc/hosts


apt-get install riak=$RIAK_VERSION
