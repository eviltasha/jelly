#!/bin/bash

now=$(date +"%m-%d-%Y")
backupdest=/backupdest/tasha/$now
zipsource=/zipsource
homedir=/home/tasha
echo $backupdest
echo $zipsource
echo $homedir

if [ -f $backupdest ]
	then
		rm -rvf $backupdest
		mkdir -p $backupdest
	else
		mkdir -p $backupdest
fi
#cd $zipsource
#tar -cvZf $now.backup.tar $homedir
#tar -xvZf $now.backup.tar
#rm -rvf home/tasha/Dropbox
#rm -rvf $now.backup.tar
#tar -cvZf $now.backup.tar home/
#mv -vf $now.backup.tar $backupdest
#rm -rvf back/
#2>&1 | tee -a $backupdest/$now.
exit 0
