#!/bin/bash

#Heavily borrowed from:
#http://www.virtuallyghetto.com/2012/09/a-pretty-cool-method-of-upgrading-to.html

#Output command prior to executing command
#set -x

USERNAME=root
SSHKEY=/home/username/.ssh/id-rsa
HOSTNAME=IP-ADDRESS
REPO=https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml
#REPO=http://vibsdepot.v-front.de
PerformUpgrade=false

#Enable firewall rule
ssh -i $SSHKEY $USERNAME@$HOSTNAME esxcli network firewall ruleset set -e true -r httpClient

#Disable shell/ssh warnings
#http://kb.vmware.com/kb/2003637
ssh -i $SSHKEY $USERNAME@$HOSTNAME vim-cmd hostsvc/advopt/update UserVars.SuppressShellWarning long 1

#check for updates
if ssh -i $SSHKEY $USERNAME@$HOSTNAME esxcli software sources vib list -d $REPO | grep -i update >/dev/null
then
    #output available updates
    ssh -i $SSHKEY $USERNAME@$HOSTNAME esxcli software sources vib list -d $REPO | grep -iE "status|--|update"
    ssh -i $SSHKEY $USERNAME@$HOSTNAME esxcli software vib update --dry-run -d $REPO

    #Check if upgrade should be completed
    if $PerformUpgrade
    then
        #Perform upgrade
        ssh -i $SSHKEY $USERNAME@$HOSTNAME esxcli software vib update -d $REPO
    fi
fi

#Appendix
#Installing patches on an ESXi 5.x/6.x host from the command line
#http://kb.vmware.com/kb/2008939

#About the ESXi 5.x and 6.0 firewall
#http://kb.vmware.com/kb/2005284
