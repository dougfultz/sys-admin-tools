#!/usr/bin/python
#----------------------------------------------------------
import subprocess
#=Main=====================================================
if __name__ == "__main__":

    username = subprocess.check_output("whoami").strip()
    if (username != "root"):
        print("You must be root")
        exit(1)

