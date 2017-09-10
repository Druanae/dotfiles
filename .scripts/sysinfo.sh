#!/bin/sh
gitdir=https://github.com/druanae
myblog=http://loki.moe
uptime=$(~/.scripts/uptime.sh)
kernel=$(uname -r)
cpuspe="$(sed -n '/model\ name/s/^.*:\ //p' /proc/cpuinfo | uniq) (x$(nproc)"
system=$(sed 's/\s*[\(\\]\+.*$/' /etc/issue)

if [ -n "$DISPLAY"]; then
    wmname=$(xprop -root _NET_WM_NAME | cut -d\" -f2)
else
    wmname="none"
fi
