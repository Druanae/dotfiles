#!/bin/bash
while [ "$select" != "No" -a "$select" != "Yes" ]; do
    select=$(echo -e 'No\nYes' | dmenu -nb '#1d1f21' -nf '#c5c8c6' -sb '#a7e22e' -sf '#1d1f21' -fn '-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*' -i -p "Are you sure you want to logout?")
    [ -z "$select" ] && exit 0
done
[ "$select" = "No" ] && exit 0
i3-msg exit
