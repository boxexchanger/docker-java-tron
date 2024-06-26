#!/bin/bash

envsubst < /src/tron-eventquery/config.conf.tmpl > /src/tron-eventquery/config.conf

total=`cat /proc/meminfo  |grep MemTotal |awk -F ' ' '{print $2}'`
xmx=`echo "$total/1024/1024*0.6" | bc |awk -F. '{print $1"g"}'`
logtime=`date +%Y-%m-%d_%H-%M-%S`

echo "total memory: $total"
echo "xmx: $xmx"
echo "logtime: $logtime"
echo "Sleeping 10s to wait for mongo to start up"
sleep 10

java -Xms1g -Xmx5g -XX:+UseG1GC -XX:+PrintGCDetails -Xloggc:./gc.log \
-XX:+PrintGCDateStamps -XX:ReservedCodeCacheSize=1g \
-XX:MaxMetaspaceSize=1g -jar target/troneventquery-1.0.0-SNAPSHOT.jar
