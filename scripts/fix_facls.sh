#!/bin/bash

setfacl -dR -m u:apache:rwx cache logs
setfacl -R -m u:apache:rwx cache logs
setfacl -dR -m u:websync:rwx cache logs
setfacl -R -m u:websync:rwx cache logs

