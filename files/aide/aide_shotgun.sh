#!/bin/bash
action="install"
if [ $# -gt 0 ]
then
   action="$1"
   shift
fi
if [ $# -gt 0 ]
then
   hostlist="$*"
else
   hostlist="`cat aidelist`"
fi
TIMING="01 30 02 00 02 30 03 30 04 00 04 30 05 00 05 30 01 15 01 45 02 15 02 45 03 15 03 45 04 15 04 45 05 15 05 45"
set $TIMING
for host in $hostlist
do
    if [ $# -lt 2 ]
    then
       set $TIMING
    fi
    hr=$1
    min=$2
    shift
    shift
    scp aideinit.sh aide.conf $host:/home/ckemp
    echo "ssh -tx $host \"hostname;sudo /home/ckemp/aideinit.sh $hr $min $action\""
    ssh -tx $host "hostname;sudo /home/ckemp/aideinit.sh $hr $min $action"
done
