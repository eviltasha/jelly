#!/bin/bash

now=$(date +"%m-%d-%Y")
backup=/home/tasha/backup/$now/
backupdir=/home/tasha/backup/
homedir=/home/tasha/
{
echo
if [[ -f $backup ]]
	then
		rm -rf $backup
 else
	mkdir -p $backup
fi

cp -r $homedir $backup
rm -rf $backup/Dropbox/
tar -cZf $now.bak.tar $backup
mv $now.bak.tar.gz $backupdir
rm -rf $backup
} > /var/log/backup.log 2>&1 | mailx -s "backup successful" tashajanaya@gmail.com
exit 0
