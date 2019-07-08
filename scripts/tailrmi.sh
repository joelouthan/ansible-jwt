#!/bin/bash

E=$1

tail -f /var/www/${E}-rmi.marines.com/logs/console.log /var/www/${E}-rmi.marines.com/logs/error.log /var/www/${E}-rmi.marines.com/logs/debug.log
