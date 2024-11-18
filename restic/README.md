# Restic
- https://restic.net/

# Quick Start
1. [Create CloudFormation stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html) using `restic_cloudformation.json`.
1. [Create access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) for `BackupUser` created by CloudFormation Stack.
1. Configure `restic_conf.sh`:
   1. `AWS_ACCESS_KEY_ID` & `AWS_SECRET_ACCESS_KEY`: Insert from IAM.
   1. `RESTIC_REPOSITORY`: Insert bucket name.
   1. `RESTIC_PASSWORD`: Should be sufficiently complex.
   1. `BACKUP_REPOS`: Repositories to backup to.
   1. `BACKUP_DIRS`: Local directories to back up from.
1. Install [restic](https://restic.readthedocs.io/en/stable/020_installation.html).
1. [Initialize](https://restic.readthedocs.io/en/stable/010_introduction.html#quickstart-guide) repository: `$ restic init`
1. Run first backup: `$ sudo ./restic-backup.sh`
1. Create CRON job that executes `restic-backup.sh` as `root`.
