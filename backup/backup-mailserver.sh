#!/bin/sh
#
## Calomel.org  BACKUP_MasterServer.sh
## (remember you can use --dry-run for testing)
#
# Mail Server backups on the machine mail_server
rsync -avx --timeout=30 --delete-excluded --exclude-from=BACKUP_filter --rsh="ssh -c arcfour -l root" mail_server:/BACKUP/ /Raid6/mail_server/current | mail -s "Backup DONE for mail-server (`hostname`)" root ; touch /Raid6/mail_server/current
#
# Bob's backups on the machine called Bob
rsync -avx --timeout=30 --delete-excluded --exclude-from=BACKUP_filter --rsh="ssh -c arcfour -l bob" bob:/BACKUP/ /Raid6/bob/current | mail -s "Backup DONE for bob (`hostname`)" -c backup_admin@internal.domain.lan bob@internal.domain.lan ; chown -R bob:bob /Raid6/bob/;touch /Raid6/bob/current
#
# time stamp when the Master backup scripts completes
logger "BACKUP_MasterServer Completed"
