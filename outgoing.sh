#!/bin/bash

# test customer's SMTP service

# get date for body file
#now=$(date + "%m-%d-%Y")

# back up current mail configuration file
mv $HOME/.mailrc $HOME/.mailrc.bak

# get SMTP settings
echo "What is the from address?"
read FROM
 	while [ -z "$FROM" ] # Check to make sure there was actually input
		do
			echo "You didn't enter a from address. Please enter one now."
			read FROM
		done
echo "You entered: $FROM"
echo "What is the SMTP server?"
read SERVER
		while [ -z "$SERVER" ] # Check to make sure there was actually input.
			do
				echo "You didn't enter an SMTP server. Please enter one now."
			done
echo "You entered: $SERVER"

# Get password for SMTP authentication

echo "What is the user's password?"
read PASSWORD 
		while [ -z "$PASSWORD" ] # Check to make sure there was actually input.
			do
				echo "You didn't enter a password. Please enter one now."
			done
echo "You entered: $PASSWORD"

# Is it a DASP or WinHost customer?

echo "Pick a subject."
echo "[A] Test from DiscountASP.NET support"
echo "[B] Test from WinHost support"
echo
read SUBJ
		while [ -z "$SUBJ" ] # Check to make sure there was actually input.
			do 
				echo "You didn't choose a subject. Please choose one from the list below:"
				echo "[A] Test from DiscountASP.NET support"
				echo "[B] Test from WinHost support"
				echo
				read SUBJ
			done
		until [[ "$SUBJ" == "A" ]] || [[ "$SUBJ" == "a" ]] || [[ "$SUBJ" == "B" ]] || [[ "$SUBJ" == "b" ]];
			do
				echo "You didn't choose a subject. Please choose one from the list below:"
				echo "[A] Test from DiscountASP.NET support"
                                echo "[B] Test from WinHost support"
				echo
                                read SUBJ
			done
case "$SUBJ" in
	"A" | "a" ) SUBJECT="Test from DiscountASP.NET support" ;;
	"B" | "b" ) SUBJECT="Test from WinHost support" ;;
esac

echo "You entered: $SUBJECT"

echo "Who should the recipient be? Choose one from the list or type \"D\" to enter your own."
echo "[G] Gmail test account - onlyatest007@gmail.com"
echo "[Y] Yahoo test account - onlyatest007@yahoo.com"
echo
read RCPT
		while [ -z "$RCPT" ] # Check to make sure there was actually input.
			do
				echo "You didn't choose a recipient. Choose one from the list or type \"D\" to enter your own."
				echo "[G] Gmail test account - onlyatest007@gmail.com"
				echo "[Y] Yahoo test account - onlyatest007@yahoo.com"
				echo
				read RCPT
			done

			until [[ "$RCPT" == "G" ]] || [[ "$RCPT" == "g" ]] || [[ "$RCPT" == "Y" ]] || [[ "$RCPT" == "y" ]] || [[ "$RCPT" == "D" ]] || [[ "$RCPT" == "d" ]];
			do
				echo "You didn't choose a recipient. Choose one from the list or type \"D\" to enter your own."
                                echo "[G] Gmail test account - onlyatest007@gmail.com"
                                echo "[Y] Yahoo test account - onlyatest007@yahoo.com"
                                echo
                                read RCPT
			done
case "$RCPT" in
	"G" | "g" ) RECIPIENT="onlyatest007@gmail.com" ;;
	"Y" | "y" ) RECIPIENT="onlyatest007@yahoo.com" ;;
esac

		if [[ "$RCPT" == "D" ]] || [[ "$RCPT" == "d" ]];
			then
				echo "What email address do you want to send to?"
				read RECIPIENT
			fi
				while [ -z "$RECIPIENT" ] # Check to make sure there was actually input.
					do
						echo "You need to specify a recipient. Please enter an email address."
						read RECIPIENT
					done
			#	i="$RECIPIENT"
			#	IFS="@"
			#	if ["${#@}" -ne 2]; then
			#	echo "You entered an invalid email address. Please enter a valid email address."
				echo "You entered: $RECIPIENT"

# Attach file if needed.

echo "Do you have attachments? [y/n]"
read ATTACH

        while [ -z "$ATTACH" ] # Check to make sure there was actually input
                do
                        echo "You didn't specify whether or not you had attachments. Please enter y or n."
.                       echo "Do you have attachments? [y/n]"
                        echo
                        read ATTACH
                done

        until [[ "$ATTACH" == "y" ]] || [[ "$ATTACH" == "Y" ]] || [[ "$ATTACH" == "n" ]] || [[ "$ATTACH" == "N" ]]
                do
                        echo "You didn't specify whether or not you had attachments. Please enter y or n."
                        echo "Do you have attachments? [y/n]"
                        echo
                        read ATTACH
                done

        if [[ "$ATTACH" == "y" ]] || [[ "$ATTACH" == "Y" ]]
                then
                        echo "Enter the filename of the attachment."
                        read ATTACHFILE

                        while [ -z "$ATTACHFILE" ] # Check to make sure there was input
                        do
                                echo "You say you have attachments. Enter the attachment filename or press Ctrl+C to cancel."
                                echo "Enter the filename of the attachment."
                        read ATTACHFILE
                        done

                        while [ ! -f "$HOME/Dropbox/$ATTACHFILE" ] # Check to make sure attachment path is correct.
                        do
                                echo "File does not exist! Please enter a valid filename.."
                                echo "Enter the filename of the attachment:"
                                read ATTACHFILE
                        done

ATTACHPATH="$HOME/Dropbox/$ATTACHFILE" # Set path for attachment. Attachments are stored in the Dropbox folder by default.

                        echo "You entered: $ATTACHFILE"
        else
                echo "You have no attachments. Moving on."
        fi

# Set body text for body file.
echo "What should the body text be?"
read BODY
echo "$BODY" > $HOME/email/$FROM

BODYFILE="$HOME/email/$FROM" # Set path for body file.

# Start modifying .mailrc file.
cp $HOME/.mailrc.cust $HOME/.mailrc # Copy customer .mailrc template to actual .mailrc file.
sed -i "s/<>/<$FROM>/" $HOME/.mailrc # Add customer from address to .mailrc file.
sed -i "s/smtpserver/$SERVER/" $HOME/.mailrc # Add customer SMTP server name to .mailrc file.
sed -i "s/customeremail/$FROM/" $HOME/.mailrc # Add customer email address to SMTP auth user line.
sed -i "s/password/$PASSWORD/2" $HOME/.mailrc # Add customer email password to SMTP auth password line.

        if [[ "$ATTACH" == "y" ]] || [[ "$ATTACH" == "Y" ]]
                then
                        mailx -A customer -s "$SUBJECT" -a $ATTACHPATH $RECIPIENT < $BODYFILE # Send mail with attachments.
                        echo "Mail sent."
        else
                mailx -A customer -s "$SUBJECT" $RECIPIENT < $BODYFILE # Send mail without attachments.
                echo "Mail sent."
        fi

mv $BODYFILE $HOME/trash # Move body file to trash, we don't need it anymore.
mv $HOME/.mailrc $HOME/.mailrc.cust.bak # Back up modified customer .mailrc file for reference.
mv $HOME/.mailrc.bak $HOME/.mailrc # Restore old .mailrc file.

exit 0
