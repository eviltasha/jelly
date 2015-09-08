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
echo "Pick a subject."
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
	until [[ "$SUBJ" == "A" ]] || [[ "$SUBJ" == "a" ]] || [[ "$SUBJ" == "B" ]] || [[ "$SUBJ" == "b" ]]
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

BODYFILE="/home/tasha/text/work/testmail" # Set path for body file.

mailx -A test -s "$SUBJECT" $RECIPIENT < $BODYFILE
echo "Mail sent."

exit 0
