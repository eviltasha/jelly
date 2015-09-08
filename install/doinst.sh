( cd usr/share/man/man1 ; rm -rf sendmail.1.gz )
( cd usr/share/man/man1 ; ln -sf msmtp.1.gz sendmail.1.gz )
( cd usr/sbin ; rm -rf sendmail )
( cd usr/sbin ; ln -sf ../bin/msmtp sendmail )
