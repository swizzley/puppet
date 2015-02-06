#!/bin/bash
HOSTNAME=$1
grep -A9 -F "# $HOSTNAME" /opt/omd/sites/prod/etc/nagios/conf.d/check_mk_objects.cfg |tail -1|cut -c 16-|awk -F "," '{print $1}'
