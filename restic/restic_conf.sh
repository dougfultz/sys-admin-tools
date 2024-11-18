#!/bin/bash

export AWS_ACCESS_KEY_ID="CHANGE_ME"
export AWS_SECRET_ACCESS_KEY="CHANGE_ME"
export RESTIC_REPOSITORY="s3:https://s3.amazonaws.com/BUCKET_NAME/restic"
export RESTIC_PASSWORD="CHANGE_ME"


# Config for restic-backup.sh
export BACKUP_REPOS=(
    $RESTIC_REPOSITORY  # Default sourced from restic_conf.sh
    # /mnt/backup  # Backup to local disk
)
export BACKUP_DIRS=(
    /mnt/dir1/
    /mnt/dir2/
)
