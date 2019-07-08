#!/bin/bash

ENV=$1

cd /var/www/${ENV}-eventmgmt.marines.com
git pull
/usr/local/jwt/bin/make_rev.sh
mutt -s stgweb1-ep mark.hanna@mirumagency.com joseph.louthan@mirumagency.com < revision.txt
