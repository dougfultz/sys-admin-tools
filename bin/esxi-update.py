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

    #Disable shell/ssh warnings
    #http://kb.vmware.com/kb/2003637
    subprocess.call(["ssh","-i",sshkey,"-l",username,hostname,"vim-cmd hostsvc/advopt/update UserVars.SuppressShellWarning long 1"])

    #check for updates
    updateList = subprocess.check_output(["ssh","-i",sshkey,"-l",username,hostname,"esxcli software sources vib list -d "+repo])
    if (type(updateList) != type(str())):
        updateList=updateList.decode()
    if "update" in updateList.lower():

        #Show available updates
        for i in updateList.splitlines():
            if "status" in i.lower() or "--" in i.lower() or "update" in i.lower():
                print(i)

        #Perform a dry run
        subprocess.call(["ssh","-i",sshkey,"-l",username,hostname,"esxcli software vib update --dry-run -d "+repo])

        if PerformUpgrade:
            subprocess.call(["ssh","-i",sshkey,"-l",username,hostname,"esxcli software vib update -d "+repo])

#Appendix
#Installing patches on an ESXi 5.x/6.x host from the command line
#http://kb.vmware.com/kb/2008939

#About the ESXi 5.x and 6.0 firewall
#http://kb.vmware.com/kb/2005284

#Show current image profile
# esxcli software profile get

#Show available image profiles from depot
# esxcli software sources profile list -d $REPO

#Update profile
# esxcli software profile update -p $PROFILE -d $REPO
