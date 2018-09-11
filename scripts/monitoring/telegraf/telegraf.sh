#!/bin/bash

mkdir telegraf
cd telegraf

wget https://dl.influxdata.com/telegraf/releases/telegraf_1.5.2-1_amd64.deb
sudo dpkg -i telegraf_1.5.2-1_amd64.deb

service telegraf stop

wget https://omi-gitlab.e-technik.uni-ulm.de/cloudiator/catalogue-scripts/raw/master/scripts/monitoring/telegraf/telegraf.conf

nohup telegraf --config telegraf.conf > telegraf.out 2>&1 &

cd ..
