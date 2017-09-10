#!/bin/bash

# popup duration
duration=3

# define geometry
barw=120
barh=60
barx=30
bary=30

# colours
bar_bg='#1d1f21'
bar_fg='#c5c8c6'

# fonts
bar_font='"xos4 Terminess Powerline:size=9"'
bar_icon='FontAwesome:size=9'

# bar config variable
bar_options="-d -g ${barw}x${barh}+${barx}+${bary} -B${bar_bg} -F${bar_fg} -f ${bar_font} -f ${bar_icon}"
echo ${bar_options}
(echo " $@"; sleep ${duration}) | lemonbar ${bar_options}
