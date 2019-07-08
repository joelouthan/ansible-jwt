#!/bin/bash

E=$1

date
cd /var/www/${E}-ecci-ap.marines.com/
mv client/package-lock.json client/package-lock.json.old
git pull
/usr/local/jwt/bin/make_rev.sh
read -p "Please verify hash and press enter to continue"
cd /var/www/${E}-ecci-ap.marines.com/client
npm install
npm run build
cd build
/bin/ln -s ../../revision.txt revision.txt

cd /var/www/${E}-ecci-ap.marines.com/server
(ls -la /var/www/${E}-ecci-ap.marines.com/server/config) >> cont-${E}-ecci-default_json.log 2>&1
sleep 5s
npm install
npm run build
(ls -la /var/www/${E}-ecci-ap.marines.com/server/config) >> cont-${E}-ecci-default_json.log 2>&1
sleep 5s
/usr/bin/pm2 restart ${E}-ecci-ms

