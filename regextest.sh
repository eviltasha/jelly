#!/bin/bash

# regular expression test for email validation

echo "What email address do you want to validate?"
read EMAIL

i="$EMAIL"
IFS="@"
set -- $i
if [ "${#@}" -ne 2 ]; then
echo "Invalid email"
fi
domain="$2"
dig $domain | grep "ANSWER: 1" 1>/dev/null && echo "domain ok"

exit 0
