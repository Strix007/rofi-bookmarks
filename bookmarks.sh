#!/bin/bash

DIR="$HOME/.config/rofi/bookmarks/"
THEME="bookmarks"
BOOKMARKS_FILE="$HOME/.config/rofi/bookmarks/.bookmarks"

# Check if there is a bookmarks file and if not, make one

if [[ ! -a "${BOOKMARKS_FILE}" ]]; then
    touch "${BOOKMARKS_FILE}"
fi

INPUT=$(echo -e $(cat $BOOKMARKS_FILE) | rofi -dmenu -theme ${DIR}/${THEME}.rasi -p "")

if   [[ $INPUT == "+"* ]]; then
    INPUT=$(echo $INPUT | sed 's/+//') 
    if [[ $INPUT == *"."* ]]; then
        echo "\n$INPUT" >> $BOOKMARKS_FILE
    else 
        INPUT="${INPUT}.com" && echo "\n$INPUT" >> $BOOKMARKS_FILE
    fi
elif [[ $INPUT == "_"* ]]; then
    INPUT=$(echo $INPUT | sed 's/_//') && sed -i "/$INPUT/d" $BOOKMARKS_FILE
elif [[ $INPUT == *"."* ]]; then
    firefox $INPUT
elif [[ -z $INPUT  ]]; then
    exit 0
else
    firefox --search $INPUT
fi
