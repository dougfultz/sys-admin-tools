#!/bin/bash

if [ ! "`whoami`" = "root" ]
then
    echo "You must be root"
    exit 1
fi

echo "Scanning for new disks..."
for i in `ls /sys/class/scsi_host/host*/scan`
do
    echo "- - -" > $i
done

echo "Scanning for larger disks..."
for i in `ls /sys/block/*/device/rescan`
do
    echo 1 > $i
done

echo "Showing disks:"
lshw -short | grep "dev"

