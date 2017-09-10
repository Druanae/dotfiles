#!/bin/bash
count=0
while :; do
    curl http://inspirobot.me/api?generate=true | xclip -selection clipboard
    xdotool key Shift+Insert
    xdotool key Return
    sleep 10m
    clear
    echo -e "$count \n"
    let "count++"
done
