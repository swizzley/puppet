#!/bin/bash

HOSTNAME=$1
SPACEWALK="spacewalk.example.com"
ssh root@$SPACEWALK 'spacewalk-report system-groups-systems'|grep $HOSTNAME |grep Environment|awk -F "," '{print $2}'|awk -F "-" '{print $2}'|cut -c 2-

