#!/bin/sh

i3status --config ~/.i3status.conf | while :
do
    read line
    LG=$(setxkbmap -print | grep xkb_symbols | awk -F"+" '{print $2}')
    if [ $LG == "ch(fr)" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo $(echo $line | sed -r "s/\[/$dat/") || exit 1
done
