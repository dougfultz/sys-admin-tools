#!/usr/bin/python
#----------------------------------------------------------
import glob
import subprocess
#----------------------------------------------------------
def scanScsi():
    fileList = glob.glob("/sys/class/scsi_host/host*/scan")

    for i in fileList:
        with open(i,'a') as f:
            f.write("- - -")
#----------------------------------------------------------
def scanBlock():
    fileList = glob.glob("/sys/block/*/device/rescan")

    for i in fileList:
        with open(i,'a') as f:
            f.write("1")
#----------------------------------------------------------
def debShowDisks():
    devices = subprocess.Popen("lshw -short | grep \"dev\"",shell=True,stdout=subprocess.PIPE,stdin=subprocess.PIPE)
    print(devices.stdout)
#=Main=====================================================
if __name__ == "__main__":

    username = subprocess.check_output("whoami").strip()
    if (username != "root"):
        print("You must be root")
        exit(1)

    print("Scanning SCSI controller...")
    scanScsi()

    print("Scanning block devices...")
    scanBlock

    print("Showing disks:")
    debShowDisks
