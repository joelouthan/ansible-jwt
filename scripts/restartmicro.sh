#!/bin/bash

MS=$1
MS_DIR=/var/www/${MS}.marines.com/

date
pm2 stop ${MS}
sleep 5s
pm2 start ${MS}
