

for LIST in qa-auth qa-ems stg-auth stg-ems 
do
  forever start -m 4 --sourceDir /var/www/${LIST}.marines.com/ --workingDir /var/www/${LIST}.marines.com/ --minUptime 1000 --spinSleepTime 1000 --uid ${LIST} -p /var/www/${LIST}.marines.com/app/logs/ -l console.log -t -a app.js
done
