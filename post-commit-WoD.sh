#!/bin/sh
REPOS="$1"
REV="$2"

export LANG=
export LC_TYPE=

cd /var/repositories/dbm4/hooks


svn export svn://dev.deadlybossmods.com/dbm4/branches/WoD/ --username Tandanu --password asa123asa --non-interactive --ignore-externals
lua /home/svn/asdf.lua $REV WoD
cd WoD
rm DBM-Core/@Translators\ \ README!!!.txt
#../luadoc.sh
rm DBM-Core/*.luadoc
rm "DBM-Core/!Important announcement for all SVN users.txt"
rm DBM-GUI/*.luadoc
zip -r WoD .
chmod 777 WoD.zip
mv -f ./WoD.zip /var/www/deadlybossmods.com/DBM-WoD-svn.zip
cd ..
rm ./WoD -f -r
chmod 777 /var/www/deadlybossmods.com/DBM-WoD-svn.zip


/home/svn/dbm-build/upload-to-curse-wod.sh $REV $REPOS

