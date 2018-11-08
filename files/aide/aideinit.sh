#!/bin/bash
file=$0
dir="`dirname $file`"
if [ "$dir" == "/" ]
then
   dir=
fi
if [ $# -lt 2 ]
then
   echo "Expected $file hr min [install|nocron|update]"
   exit 99
fi
hr=$1
mins=$2
action="install"
if [ $# -gt 2 ]
then
   action=$3
fi
crontab_exists=0
if [ `crontab -l|grep "aide --"|wc -l` -gt 0 ]
then
   echo "Looks like aide is already installed in crontab."
   crontab -l
   crontab_exists=1
   if [ `echo $action|grep -i "^i"|wc -l` -gt 0 ]
   then
      echo "Please investigate."
      /bin/bash
      exit 9999
   fi
fi
cd /etc
if [ `echo $action|grep -i "^i"|wc -l` -gt 0 ]
then
   mv aide.conf aide.conf.orig
fi
nodb=1
noweb=1
nolog=1
noapp=1
filename=aidetype.txt
exclude_string="nosuchstringyet"
if [ `grep -i webhost $dir/$filename|wc -l` -lt 1 ]
then
   exclude_string="$exclude_string|define WEBHOST 1"
fi
if [ `grep -i apphost $dir/$filename|wc -l` -lt 1 ]
then
   exclude_string="$exclude_string|define APPHOST 1"
fi
if [ `grep -i loghost $dir/$filename|wc -l` -lt 1 ]
then
   exclude_string="$exclude_string|define LOGHOST 1"
fi
if [ `grep -i dbhost $dir/$filename|wc -l` -lt 1 ]
then
   exclude_string="$exclude_string|define DBHOST 1"
fi
for file in `ls -1t /etc/aide.conf*`
do
   if [ `echo $file|grep "aide.conf.[0-9]"|wc -l` -gt 0 ]
   then
      suf=`echo $file|perl -e 'while (<>) {\$buff=\$_;chomp(\$buff);@arr=split(/\.+/,\$buff);print "\$arr[\$#arr]\n";}'`
      if [ `echo $suf|grep '^[0-9][0-9]*\$'|wc -l` -lt 1 ]
      then
         suf=11
      fi
      if [ $suf -lt 10 ]
      then
         mv /etc/aide.$suf /etc/aide.`expr $suf + 1`
      fi
   fi
done
mv /etc/aide.conf /etc/aide.conf.1
egrep -v "$exclude_string" $dir/aide.conf >/etc/aide.conf
chown root:root /etc/aide.conf
chmod 600 /etc/aide.conf
vi /etc/aide.conf
if [ $crontab_exists -lt 1 ]
then
   TIME=`date +%Y%m%d%H%M%S`
   crontab -l >~/crontab.$TIME
   cp ~/crontab.$TIME ~/crontab.$TIME.orig
   echo "$mins $hr * * * nice -19 /usr/sbin/aide --check --config=/etc/aide.conf 2>&1|mail -s \"AIDE Results from \`hostname\` on \`date\`\" carl.kemp@jwt.com mark.hanna@jwt.com" >>~/crontab.$TIME
   echo "==========================================    BEFORE    =========================================="
   crontab -l
   crontab ~/crontab.$TIME
   echo "==========================================    AFTER     =========================================="
   crontab -l
   read -p "Does this look OK?[Yn]" answer
   case "$answer" in
      [Yy]) :;;
      [Xx]) /bin/bash;;
      [Qq]) exit 99;;
      [Nn])    crontab -e;;
      *)    :;;
   esac
   rm  ~/crontab.$TIME  ~/crontab.$TIME.orig
else
   if [ `echo $action|grep -i "^no"|wc -l ` -lt 1 ]
   then
      crontab -e
   fi
fi
if [ "`date +%a`" != "Thu" ]
then
curr=`date +%H%M`
if [ $curr -ge 2000 -o $curr -le 0400 ]
then
at now + 2 minutes <<eod
time nice -19 /usr/sbin/aide --init --config=/etc/aide.conf
cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
time nice -19 /usr/sbin/aide --update --config=/etc/aide.conf
eod
else
at 20:00 <<eod
time nice -19 /usr/sbin/aide --init --config=/etc/aide.conf
cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
time nice -19 /usr/sbin/aide --update --config=/etc/aide.conf
eod
fi
else
   echo "Today is Thursday; update already scheduled"
fi
