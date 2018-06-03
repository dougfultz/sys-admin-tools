#!/bin/sh

DIR="`dirname $0`"
SCRIPT="`basename $0`"
PID="$$"

WEMO_IP="192.168.1.2"
CHECK_DNS="www.google.com

PATH=$PATH:/usr/local/bin

# Check Dependencies
set -e
which logger > /dev/null
which bash > /dev/null
which wemo > /dev/null
which sleep > /dev/null
which pgrep > /dev/null
which grep > /dev/null
which ping > /dev/null
which git > /dev/null
set +e

LOGGER="logger -t wemo-cron-$PID"
$LOGGER "Starting $SCRIPT"

WEMO="`which bash` `which wemo` --host $WEMO_IP"

STATUS=`$WEMO --action getstate 2>&1`
$LOGGER "modem state: $STATUS"

$LOGGER "Existing processes: `pgrep -f $SCRIPT | grep -cv $PID`"

if ! pgrep -f $SCRIPT | grep -v $PID && ! ping -c 5 $CHECK_DNS
then
    STATUS=`$WEMO --action off 2>&1`
    $LOGGER "power off modem: $STATUS"

    sleep 30

    STATUS=`$WEMO --action on 2>&1`
    $LOGGER "power on modem: $STATUS"

    sleep 600
fi

$LOGGER "Ending $SCRIPT"
