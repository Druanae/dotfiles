#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Merge xrdb with .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources &
# MPDAS start
[[ -z $(pgrep -xU $UID mpdas) ]] && mpdas &
# Set xcursor
xsetroot -cursor_name Breeze_Default &
export LANG=en_GB.UTF-8 &
exec i3
