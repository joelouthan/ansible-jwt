#!/bin/bash

E=$1

tail -f /var/www/${E}-auth.marines.com/app/logs/console.log /var/www/${E}-ems.marines.com/app/logs/console.log /var/www/${E}-auth.marines.com/app/logs/error.log /var/www/${E}-ems.marines.com/app/logs/error.log
