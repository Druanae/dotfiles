#!/bin/bash
DATE=$(date +%d-%m-%Y-%T)
export i=~/Pictures/Screenshots/Screenshot-$DATE.png
scrot $i
limf -l -c 7 $i| awk -F \" '{print $1}' | xclip -selection clipboard
