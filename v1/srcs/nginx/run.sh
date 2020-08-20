#!/bin/bash

chown -R www:www /www && chmod 775 -R /www
/usr/sbin/sshd
/usr/bin/telegraf &
nginx -g "daemon off;"