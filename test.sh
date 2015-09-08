#!/bin/bash

LOGFILE=output.log

export NOW="$(date -u)" >> $LOGFILE
echo "$NOW"

export WHO="$(who)" >> $LOGFILE
echo "$WHO"

export UP="$(uptime)" >> $LOGFILE
echo "$UP"

echo
echo "Results of test in file $LOGFILE"
exit 0
