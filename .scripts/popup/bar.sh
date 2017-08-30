#!/bin/sh

# how long should the popup remain?
duration=3

# define geometry
barw=120
barh=60
barx=30
bary=30

# colors
bar_bg='#1d1f21'
bar_fg='#c5c8c6' # white is default

# font used
bar_font='-*-terminesspowerline-*-*-*-*-12-*-*-*-*-*-*-*'
bar_icon='-*-fontawesome-*-*-*-*-*-120-*-*-*-*-*-*'

# compute all this
baropt="-d -g ${barw}x${barh}+${barx}+${bary} -B${bar_bg} -f ${bar_font} -f ${bar_icon}"

(echo " $@"; sleep ${duration}) | lemonbar ${baropt}
