#!/bin/bash
#
## Calomel.org  /tools/rsync-wrapper.sh
#
# This script is executed when the user from a remote
# machine successfully authenticates with a public key.
# The privileges of that user on this server is limited
# to the functionality of this script.  This wrapper
# will verify the client is sending the rsync command.
# If it is, the original, unaltered command is run,
# if not, an error is returned.

RSYNC_HOME=/usr/bin
log="$HOME/rsync.log"
                    
command="$SSH_ORIGINAL_COMMAND"; export command
                                              
if [ "N$command" = "N" ] ;  then
  $log
  exit 127
fi
 
cmdbase=`echo $command | awk '{print$1}'`
if [ "$cmdbase" != "rsync" ] ; then
  echo "ERROR: Invalid command"
  exit 127
fi
 
ok="false"
for arg in $command
do
  if [ "N$arg" = "N--server" ] ; then
     ok="true"
  fi
done
   
if [ "$ok" = "true" ] ; then
  $RSYNC_HOME/$command
else
  echo "ERROR: Invalid rsync request"
  exit 127
fi
