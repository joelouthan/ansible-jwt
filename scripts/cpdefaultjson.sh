#!/bin/bash

ENV=$1

cp /var/www/${ENV}-ecci-ap.marines.com/server/config/default.json /var/www/${ENV}-ecci-ap.marines.com/server/config/default.json-`date +%Y%m%d.%H%M`
