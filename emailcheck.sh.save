#!/bin/bash

# regular expression to check email syntax and existence of domain.

echo "What email address do you want to send to?"
read EMAIL

IFS="@"
set -- $EMAIL
if [ "${#@}" -ne 2 ];then
    echo "invalid email"
fi
domain="$2"
dig $domain | grep "ANSWER: 1" 1>/dev/null && echo "domain ok"

exit 0
