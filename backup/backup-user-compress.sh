#!/bin/sh
#
## Calomel.org  BACKUP_Compress.sh 
#
# delete old archives after 180 days
find /BACKUP/archive_* -type f -mtime +180 -exec rm  {} \;
#
# compress latest backup to archive
cd /tools/BACKUP/;tar jcf archive_`hostname -s`_`date +%Y.%m.%d`.tar.bz2 `hostname -s`/; chown root:root archive_*
#
# time stamp when the backup scripts completes
logger "BACKUP_Compress Completed for `hostname`"
