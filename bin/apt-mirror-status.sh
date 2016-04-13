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
#=Main=====================================================
echo "Index status:"

for i in `ls /var/spool/apt-mirror/var/index-urls.* | cut -d. -f2`
do
    TOTAL=`wc -l /var/spool/apt-mirror/var/index-urls.$i | awk '{print $1}'`
    CURRENT=`grep -E "saved|not retrieving|404 Not Found" /var/spool/apt-mirror/var/index-log.$i | wc -l`
    echo "    $i - $CURRENT/$TOTAL"
done

echo "Archive status:"

for i in `ls /var/spool/apt-mirror/var/archive-urls.* | cut -d. -f2`
do
    TOTAL=`wc -l /var/spool/apt-mirror/var/archive-urls.$i | awk '{print $1}'`
    CURRENT=`grep saved /var/spool/apt-mirror/var/archive-log.$i | wc -l`
    echo "    $i - $CURRENT/$TOTAL"
done
