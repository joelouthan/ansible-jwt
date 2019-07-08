#!/bin/bash

for LIST in `cat /home/websync/bin/pm2.list` 
do 
  echo $LIST
  cd /var/www/${LIST}.marines.com
  pm2 start process.json
  sleep 5
done
