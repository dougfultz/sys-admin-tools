#!/bin/bash
#----------------------------------------------------------
# Debug stuff
# Print line before executing
#set -x
# Error out on unbound variables
#set -u
#----------------------------------------------------------
# Global Variables
showIndexLog=false
showArchiveLog=false
#----------------------------------------------------------
function indexStatus() {
    echo "Index status:"

    for i in `ls /var/spool/apt-mirror/var/index-urls.* | cut -d. -f2`
    do
        TOTAL=`wc -l /var/spool/apt-mirror/var/index-urls.$i | awk '{print $1}'`
        CURRENT=`grep -E "saved|not retrieving|404 Not Found" /var/spool/apt-mirror/var/index-log.$i | wc -l`
        echo "    $i - $CURRENT/$TOTAL"
    done
}
#----------------------------------------------------------
function archiveStatus() {
    echo "Archive status:"

    for i in `ls /var/spool/apt-mirror/var/archive-urls.* | cut -d. -f2`
    do
        TOTAL=`wc -l /var/spool/apt-mirror/var/archive-urls.$i | awk '{print $1}'`
        CURRENT=`grep saved /var/spool/apt-mirror/var/archive-log.$i | wc -l`
        echo "    $i - $CURRENT/$TOTAL"
    done
}
#----------------------------------------------------------
function usage() {
    echo "$0 - Usage:"
    echo "index:    Show index log."
    echo "archive:  Show archive log."
}
#=Main=====================================================

while [ -n "$*" ]; do
    parm=$1
    case $parm in
        *)
            echo "Invalid parameter: $parm"
            usage
            exit 1
            ;;
    esac
    shift
done

indexStatus
archiveStatus
