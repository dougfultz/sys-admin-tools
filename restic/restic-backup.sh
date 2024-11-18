#!/bin/bash

if [ "$(whoami)" != "root" ] || [ "$HOME" != "/root" ]
then
    echo "Must be root!" 
    echo "sudo -i $0"
    exit 1
fi

logger "Starting remote backup"

if [ -h $0 ]
then
    dir_path=$(readlink $0)
else
    dir_path=$0
fi

source $(dirname $dir_path)/restic_conf.sh

trap "exit 1" SIGINT

for repo in ${BACKUP_REPOS[@]}
do
    for dir in ${BACKUP_DIRS[@]}
    do
        set -x
        restic --cleanup-cache -r $repo backup $dir
        set +x
    done
    echo "Repo snapshots: $repo"
    restic -r $repo snapshots --latest 1
done
