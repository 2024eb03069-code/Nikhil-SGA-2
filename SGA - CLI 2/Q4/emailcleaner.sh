#!/bin/bash

#check if  emails.txt exists
if [ ! -f emails.txt ]; then
   echo "ERROR: emails.txt not found !"
exit 1
fi

#extract valid emails

grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt | sort  | uniq > valid.txt

# extract invalid emails

grep -v -E  '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > invalid.txt

echo "email cleaning done . check valid .txt and invalid.txt"
