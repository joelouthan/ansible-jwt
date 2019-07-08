#!/bin/bash

HOST=$1
PORT=$2
HASH=$3

RETURN=`/usr/bin/curl -s http://localhost:${PORT}/heartbeat`
RETURNHASH=`echo $RETURN | /usr/bin/md5sum | cut -c1-32`

MESSAGE="`date` $HOSTNAME $HOST $PORT $RETURN $RETURNHASH $HASH"
echo $MESSAGE

if [ "$RETURNHASH" != "$HASH" ]
then
  cd /var/www/${HOST}.marines.com
#  forever stop ${HOST}
#  forever start ${HOST}.json
  echo $MESSAGE | mail -s "nodejs restart $HOSTNAME" mark.hanna@mirumagency.com
fi
