#!/bin/sh
time nice -19 /usr/sbin/aide --init --config=/etc/aide.conf
cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
time nice -19 /usr/sbin/aide --update --config=/etc/aide.conf
