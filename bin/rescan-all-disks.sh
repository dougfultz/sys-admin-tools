#!/bin/bash
#----------------------------------------------------------
# Debug stuff
# Print line before executing
#set -x
# Error out on unbound variables
#set -u
#----------------------------------------------------------
# Global Variables
#----------------------------------------------------------
function scanScsi() {
    for i in `ls /sys/class/scsi_host/host*/scan`
    do
        echo "- - -" > $i
    done
}
#----------------------------------------------------------
function scanBlock() {
    for i in `ls /sys/block/*/device/rescan`
    do
        echo 1 > $i
    done
}
#----------------------------------------------------------
function debShowDisks() {
    lshw -short | grep "dev"
}
#=Main=====================================================

if [ ! "`whoami`" = "root" ]
then
    echo "You must be root"
    exit 1
fi

echo "Scanning SCSI controller..."
scanScsi

echo "Scanning block devices..."
scanBlock

echo "Showing disks:"
debShowDisks
