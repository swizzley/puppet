#!/bin/bash

HOSTNAME=$1
CHECKMKHOST="changeme.example.com"
ssh root@$CHECKMKHOST "/root/bin/hostgroup.sh $HOSTNAME"
