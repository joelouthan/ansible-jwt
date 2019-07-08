#!/bin/bash

E=$1

tail -f /var/www/${E}-ecci-ap.marines.com/server/logs/console.log /var/www/${E}-ecci-ap.marines.com/server/logs/error.log /var/www/${E}-ecci-ap.marines.com/server/logs/debug.log
