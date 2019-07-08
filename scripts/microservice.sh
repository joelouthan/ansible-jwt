#!/bin/bash

MS=$1
MS_DIR=/var/www/${MS}.marines.com/

date
pm2 stop ${MS}
cd ${MS_DIR}
#if [ -f package-lock.json ]
#then
#  rm -f package-lock.json
#fi
git pull
/usr/local/jwt/bin/make_rev.sh
sleep 5s
pm2 start ${MS}
