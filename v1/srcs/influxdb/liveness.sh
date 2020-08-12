#!/bin/sh

if [ $(ps -ef | grep "influxd" | wc -l) -ge 2 ] && [ $(ps -ef | grep "telegraf" | wc -l) -ge 2 ]; then
	echo "Everything is fine !"
else
	echo "Something is stopped..." && exit 1
fi
