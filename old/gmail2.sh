#!/bin/bash

# Shell script to send email via Gmail account with optional attachments
#
BODYFILE=""
Yes='Y'
yes='y'
No='N'
no='n'
RECIPIENT=""

echo "Who do you want to send email to?"
echo "Choose one of the following email addresses, or type \"D\" to enter a different email address."
echo "[T] Tasha Shermer - tashajanaya@gmail.com"
echo "[C] Carol Sneed - asap91101@earthlink.net"
echo "[W] Tasha at work - tashas@hostcollective.com"
echo
read ADDRESS
	while [ -z "$ADDRESS" ] # Check to make sure there was actually input
		do
			echo  "You didn't choose a recipient. Choose one from the list or type \"D\" to enter a 
different email address."
			echo "Who do you want to send email to?"
			echo "[T] Tasha Shermer - tashajanaya@gmail.com"
			echo "[C] Carol Sneed - asap91101@earthlink.net"
			echo "[W] Tasha at work - tashas@hostcollective.com"
			echo
			read ADDRESS
		done 
case "$ADDRESS" in
	"T" | "t" ) RECIPIENT="tashajanaya@gmail.com"	;;
	"C" | "c" ) RECIPIENT="asap91101@earthlink.net" ;;
	"W" | "w" ) RECIPIENT="tashas@hostcollective.com" ;;

esac

	 if [[ "$ADDRESS" = "D" ]] || [[ "$ADDRESS" = "d" ]]; # Did they enter an email address that wasn't listed?
		then
			echo "What email address do you want to send to?"
			read RECIPIENT
	fi
		while [ -z "$RECIPIENT" ] # Check to make sure there was actually input
			do
				echo "You need to choose a recipient!"
				echo "What email address do you want to send to?"
				read RECIPIENT
			done
		 echo "You entered: $RECIPIENT" 
echo "Subject:"
read SUBJECT
echo "You entered: $SUBJECT"
BODYFILE="/home/tasha/text/$SUBJECT.mail" # Set path for body file.
echo "Do you have any attachments?  [y/n]"
read ATTACHMENTS
	until [ "$ATTACHMENTS" == "$Yes" ] || [ "$ATTACHMENTS" == "$yes" ] || 
[ "$ATTACHMENTS" == "$No" ] || [ "$ATTACHMENTS" == "$no" ] # Don't let them proceed without entering Y/y or N/n
	do  
		echo "Please enter y or n."
		echo "Do you have any attachments? [y/n]"
		read  ATTACHMENTS
		done
		if [[ "$ATTACHMENTS" == "$yes"]]  || [["$ATTACHMENTS" == "$Yes" ]];
		 then
			echo "Attachment path:"
			read ATTACHPATH
		 while [ -z "$ATTACHPATH" ] # Check to make sure there was actually input.
			do
			echo "You said you had attachments. Enter the path or type \"X\" to exit."
			echo "Attachment path:"
			read ATTACHPATH
			done
		while [ ! -f  "$ATTACHPATH" ] # Check to make sure attachment file actually exists.
			do
				 if [[ "$ATTACHPATH" == "X" ]] || [[ "$ATTACHPATH" == "x" ]]; # Did they make a mistake?
				then
					echo "I guess you don\'\t have attachments after all. Moving on."
				break
				fi	
				echo "File does not exist! Please enter a valid attachment path:" 
				read ATTACHPATH
		         done
			#if [[ "$ATTACHPATH" == "$X" ]];
			#then
			#elif [[ "$ATTACHPATH" != "$X" ]];
			#then
				echo "You entered: $ATTACHPATH"
			else
				echo "You have no attachments? Moving on, then."
		 fi

read -p "Body: " BODY
echo $BODY > $BODYFILE # Insert body text into previously created body file.

 	if [[ "$ATTACHMENTS" == "$yes" ]] || [[ "$ATTACHMENTS" == "$Yes" ]]; # Check for attachments.
 		then
		mailx -s "$SUBJECT" -a $ATTACHPATH $RECIPIENT < $BODYFILE # Send mail with attachments.
		echo "Mail sent."
	else
		mailx -s "$SUBJECT" $RECIPIENT < $BODYFILE # Send mail without attachments.
		echo "Mail sent."
fi

mv $BODYFILE /home/tasha/trash/ # Move body file to trash, we don't need it anymore.

exit 0
