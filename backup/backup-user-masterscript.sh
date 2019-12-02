#!/bin/sh
#
## Calomel.org  BACKUP_MasterScript.sh
#
cd /tools/BACKUP_Config/
#
# backup data listed in BACKUP_user
#   (add --dry-run for testing)
rsync -Ravx --timeout=30 --delete-excluded --exclude-from=BACKUP_filter `cat BACKUP_user` /BACKUP/`hostname -s` | mail -s "Backup DONE for `hostname -s`" root
#
# time stamp when the backup scripts completes
logger "BACKUP_Master Completed for `hostname`"

