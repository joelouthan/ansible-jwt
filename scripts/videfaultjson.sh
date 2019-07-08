#!/bin/bash

ENV=$1

vim /var/www/${ENV}-ecci-ap.marines.com/server/config/default.json
cat /var/www/${ENV}-ecci-ap.marines.com/server/config/default.json
