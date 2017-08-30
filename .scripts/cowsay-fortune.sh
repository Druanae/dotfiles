#!/bin/bash
clear
dir='/usr/share/cows/'
file=`/bin/ls -1 "$dir" | sort --random-sort | head -1`
cow=$(echo "$file" | sed -e "s/\.cow//")
fortune -a | cowsay -f $cow
