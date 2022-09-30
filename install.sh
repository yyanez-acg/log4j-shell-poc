#!/bin/bash

apt update
apt install cron -y
service cron start

/bin/bash -c 'echo "*/1 * * * * root /root/custom.sh" >> /etc/crontab'
