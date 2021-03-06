#!/bin/bash

VERSION=1.7.0

mkdir telegraf
cd telegraf

wget https://dl.influxdata.com/telegraf/releases/telegraf_$VERSION-1_amd64.deb
sudo dpkg -i telegraf_$VERSION-1_amd64.deb

service telegraf stop

#moved to yaml file to enable custom monitoring scripts
#wget https://omi-gitlab.e-technik.uni-ulm.de/cloudiator/catalogue-scripts/raw/master/scripts/database/couchbase/telegraf.conf

nohup telegraf --config telegraf.conf > telegraf.out 2>&1 &

cd ..
