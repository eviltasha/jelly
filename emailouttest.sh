#!/bin/bash

# test outgoing/incoming email

echo "Who do you want to send to?"
read RECIPIENT

        while [ -z "$RECIPIENT" ]  # Check to make sure there was actually input
                do
                        echo "You didn't enter a recipient. Please enter one now."
                        read RECIPIENT
                done
                echo "You entered: $RECIPIENT"
echo "Pick a subject or type \"D\" to enter your own."
echo "[A] Test from DiscountASP.NET support"
echo "[B] Test from WinHost support"
echo
read SUBJ
        while [ -z "$SUBJ" ] # Check to make sure there was actually input
                do
                        echo "You didn't choose a subject. Please choose one from the list below:"
                        echo "[A] Test from DiscountASP.NET support"
                        echo "[B] Test from WinHost support"
                        echo
                        read SUBJ
                done

        until [[ "$SUBJ" == "A" ]] || [[ "$SUBJ" == "a" ]] || [[ "$SUBJ" == "B" ]] || [[ "$SUBJ" == "b" 
]] || [[$
                do
                        echo "You didn't choose a subject. Please choose one from the list below or type 
\"D\"/ $
                        echo "[A] Test from DiscountASP.NET support"
                        echo "[B] Test from WinHost support"
                        echo
                        read SUBJ
                done

        if [[ "$SUBJ" == "D" ]] || [[ "$SUBJ" == "d" ]]
                then
                        echo "Enter your subject. (That's what she said.)"
                        read SUBJECT

                while [ -z "$SUBJ" ] # Check to make sure there was actually input
                        do
                                echo "You didn't enter anything. Please enter your subject or press 
Ctrl+C to ex$
                                read SUBJECT
                        done
        fi

case "$SUBJ" in
        "A" | "a" ) SUBJECT="Test from DiscountASP.NET support" ;;
        "B" | "b" ) SUBJECT="Test from WinHost support" ;;
esac

echo "You entered: $SUBJECT"

echo "Do you have attachments? [y/n]"
read ATTACH
        while [ -z "$ATTACH" ] # Check to make sure there was actually input
                do
                        echo "You didn't specify whether or not you had attachments. Please enter y or 
n."
.                       echo "Do you have attachments? [y/n]"
                        echo
                        read ATTACH
                done

        until [[ "$ATTACH" == "y" ]] || [[ "$ATTACH" == "Y" ]] || [[ "$ATTACH" == "n" ]] || [[ "$ATTACH" 
== "N" $
                do
                        echo "You didn't specify whether or not you had attachments. Please enter y or 
n."
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
                                echo "You say you have attachments. Enter the attachment filename or 
press Ctrl+$
                                echo "Enter the filename of the attachment."
                        read ATTACHFILE
                        done
						ATTACHPATH="/home/tasha/Dropbox/$ATTACHFILE" # Set path 
for attachment. Attachments are stored in Dropbox.

                        echo "You entered: $ATTACHFILE"
        else
                echo "You have no attachments. Moving on."
        fi

BODYFILE="/home/tasha/text/work/testmail" # Set path for body file.

        if [[ "$ATTACH" == "y" ]] || [[ "$ATTACH" == "Y" ]]
                then
                        mailx -A test -s "$SUBJECT" -a $ATTACHPATH $RECIPIENT < $BODYFILE # Send mail 
with attac$
                        echo "Mail sent."
        else
                mailx -A test -s "$SUBJECT" $RECIPIENT < $BODYFILE # Send mail without attachments.
                echo "Mail sent."
        fi

exit 0
