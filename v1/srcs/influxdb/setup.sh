#!/bin/sh

/telegraf/telegraf &

openrc default
rc-update add influxdb default
rc-service influxdb start
sleep 5
influx -execute "CREATE DATABASE telegraf"
# influx -execute "CREATE USER $USER WITH PASSWORD 'pw'"
# influx -execute "GRANT ALL ON telegraf TO $USER"
# influx -execute "CREATE RETENTION POLICY one_week ON telegraf DURATION 168h REPLICATION 1 DEFAULT"
# influx -execute "SHOW DATABASES"
rc-service influxdb stop

influxd
