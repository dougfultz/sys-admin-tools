#!/bin/bash

UPDATE_URL="https://atom.io/download/deb"
INSTALLED_VERSION=$(atom --version | grep Atom | awk '{print $3}')
REMOTE_VERSION=$(curl -s $UPDATE_URL | cut -d/ -f4 | cut -dv -f2)
DOWNLOAD_DESTINATION="/tmp/atom-$REMOTE_VERSION.deb"

if [ "$INSTALLED_VERSION" != "$REMOTE_VERSION" ]
then
    echo "Installed: $INSTALLED_VERSION"
    echo "Available: $REMOTE_VERSION"
    echo "An update is available!"
    if wget $UPDATE_URL -O $DOWNLOAD_DESTINATION
    then
        sudo dpkg -i $DOWNLOAD_DESTINATION
    fi
fi
