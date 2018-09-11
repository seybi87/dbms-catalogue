#!/bin/bash

VERSION=1.7.0

mkdir telegraf
cd telegraf

wget https://dl.influxdata.com/telegraf/releases/telegraf_$VERSION-1_amd64.deb
sudo dpkg -i telegraf_$VERSION-1_amd64.deb

service telegraf stop

wget https://raw.githubusercontent.com/seybi87/dbms-catalogue/master/scripts/database/cassandra/telegraf.conf

nohup telegraf --config telegraf.conf > telegraf.out 2>&1 &

cd ..
