#!/bin/sh
# File: /usr/local/bin/backup-compress.sh
NUM_FILES_TO_KEEP=2
HOST=`hostname -s`
FILENAME=/backup/archive_$HOST\_`date +%Y.%m.%d`.tar.gz 

if [[ $EUID -ne 0 ]]; then
  echo "Must be run as root"; exit 1
fi

cd /backup

# Delete old backups
rm -f `ls -t archive_*.tar.gz | awk "NR>$NUM_FILES_TO_KEEP"`

logger -s "Starting backup compression"
tar czf $FILENAME $HOST
logger -s "Finished backup compression"

/usr/local/bin/backup-export.sh $FILENAME
