#!/bin/bash
title=$(xprop -root _NET_ACTIVE_WINDOW | cut -d '#' -f 2| tr -d ' ')
echo "ID: $title"
title=$(xprop -id ${title} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d '"' -f2)
echo "name: $title"
