#!/bin/bash

if [ -e revision.txt ]
then cp -Ra revision.txt revision.old
fi

date > revision.txt

echo -e "Remote URL:\n" >> revision.txt
git remote -v >> revision.txt

echo -e "\nLocal Branch: \n" >> revision.txt
git branch -v --no-color 2> /dev/null | sed -e '/^[^*]/d' >> revision.txt

echo -e "\nBranch Tags: \n" >> revision.txt
git describe --exact-match --tags >> revision.txt

echo -e "\nConfiguration:\n" >> revision.txt
cat .git/config >> revision.txt
git log --format="%h %an: %s" --name-status -n 2 >> revision.txt


# Now for the revision.json used by Eufony
if [ -e revision.json ]
then cp -Ra revision.json revision.json.old
fi

RDATE=`git log -1 --pretty=%cd`
RUSER=`git log -1 --pretty=%an`
RREVISION=`git log -1 --pretty=%H`
RBRANCH=`git branch --no-color | sed '/^[^*]/d' | sed 's/\* //'`
RURL=`git config --get remote.origin.url`
RMESSAGE=`git log -1 --pretty=%s`

# Escape double quotes for JSON
RMESSAGE=`echo $RMESSAGE | sed 's/"/\\"/g'`

echo '{' > revision.json
echo "\"vcs\":\"git\"" >> revision.json
echo ",\"date\":\"$RDATE\"" >> revision.json
echo ",\"user\":\"$RUSER\"" >> revision.json
echo ",\"revision\":\"$RREVISION\"" >> revision.json
echo ",\"branch\":\"$RBRANCH\"" >> revision.json
echo ",\"url\":\"$RURL\"" >> revision.json
echo ",\"message\":\"$RMESSAGE\"" >> revision.json
echo '}' >> revision.json
