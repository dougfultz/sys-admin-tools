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
function indexLog() {
    if $showIndexLog
    then
        tail -n2 /var/spool/apt-mirror/var/index-log.* | grep -A 1 "<==" | grep -v "\-\-"
    fi
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
function archiveLog() {
    if $showArchiveLog
    then
        tail -n2 /var/spool/apt-mirror/var/archive-log.* | grep -A 1 "<==" | grep -v "\-\-"
    fi
}
#----------------------------------------------------------
function usage() {
    echo "`basename $0` - Usage:"
    echo "index:    Show index log."
    echo "archive:  Show archive log."
}
#=Main=====================================================

while [ -n "$*" ]; do
    parm=$1
    case $parm in
        "index")
            showIndexLog=true
            ;;
        "archive")
            showArchiveLog=true
            ;;
        *)
            echo "Invalid parameter: $parm"
            usage
            exit 1
            ;;
    esac
    shift
done

indexStatus
indexLog
archiveStatus
archiveLog
