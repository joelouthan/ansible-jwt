#!/bin/bash

date
pm2 stop qa-mailer
sleep 5s
pm2 start qa-mailer
