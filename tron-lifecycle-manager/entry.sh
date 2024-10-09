#!/bin/bash

echo "Starting Tron Lifecycle Manager"

printenv | grep "MONGO" >> /etc/environment

echo "6 * * * * /usr/local/bin/python /app/cleanup.py > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/cron.d/crontab

/usr/bin/crontab /etc/cron.d/crontab
cron -f
