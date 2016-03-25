#!/usr/bin/env python
#----------------------------------------------------------
import subprocess
#----------------------------------------------------------
username="root"
sshkey="/home/username/.ssh/id-rsa"
hostname="IP-ADDRESS"
repo="https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml"
PerformUpgrade=False
#=Main=====================================================
if __name__ == "__main__":
    #Enable firewall rule
    subprocess.call(["ssh","-i",sshkey,"-l",username,hostname,"esxcli network firewall ruleset set -e true -r httpClient"])
