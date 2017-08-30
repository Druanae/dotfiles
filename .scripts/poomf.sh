#!/bin/bash

#DEST_URL='https://nya.is/upload?token=2671c01e3aca131f6b7bb049c002a69f71519565d54777cd2d850efa9a90faa4' # could be http://pomf.se/upload.php
DEST_URL='https://biyori.moe/api/user/upload?authkey=9oKqes0dB06VCqncDyp2FXRzNmnHL33mkS2D90VD'

trim() {
    local orig="$1"
    local trmd=""
    while true;
    do
        trmd="${orig#[[:space:]]}"
        trmd="${trmd%[[:space:]]}"
        test "$trmd" = "$orig" && break
        orig="$trmd"
    done
    printf -- '%s\n' "$trmd"
}

# Poomf for Ubuntu/linux
# Owner : Max Gurela
# May 2015
#
# Dependencies:
# - gnome-screenshot
# - curl
# - zenity
# - xclip
# - notify-send
# - jq
#
# Instructions:
# - Place this file wherever you want (/usr/local/bin)
# - Set up keyboard shortcuts within linux (in Ubuntu it's system settings > keyboard > keyboard shortcuts > custom shortcuts)
#
# 		command			description		(recommended keyboard shortcut)
#		---------------------------------------------------------------
#		poomf -c		upload window		(Ctrl + Shift + 2/@)
#		poomf -a		upload desktop	(Ctrl + Shift + 3/#)
#		poomf -b		upload clipping	(Ctrl + Shift + 4/$)
#		poomf -d		upload file			(Ctrl + Shift + U)
#
#
# Notes:
# - Link(s) will be copied into clipboard and appear in notifications
# - curl upload code borrowed from online sources

# Usage: poomfFile [fileName]
function poomfFile ()
{
	if [ -z "$1" ]; then
		echo "No file specified"
		exit 1
	elif [ ! -f "$1" ]; then
		echo "poomf cancelled"
		exit 1
	fi

	file=$1
	printf "Uploading ${file}..."
	my_output=$(curl -F files[]="@${file}" "${DEST_URL}")
    printf "\n${my_output}"
	n=0  # Multipe tries
	while [[ $n -le 3 ]]; do
		printf "try #${n}..."
                status="$(echo "$my_output" | jq -r .success)"
		if [[ $status =~ 'true' ]]; then
			return_file="$(echo "$my_output" | jq -r .files[0].url)"
                        return_file="$(trim "$return_file")"
			printf 'done.\n'
			break
		else
			printf 'failed.\n'
			((n = n +1))
		fi
	done
	if [[ -n ${return_file} ]]; then
		fileURL="${return_file}"
                echo "Upload complete! $fileURL"
		#Copy link to clipboard, show notification
		if hash xclip 2>/dev/null; then
			printf $fileURL | xclip -selection "clipboard"
		fi
		if hash notify-send 2>/dev/null; then
			notify-send -i "$( cd "$( dirname "$0" )" && pwd )/icon.png" -t 2000 "poomf complete!" "$fileURL"
		fi
	else
		echo "Upload failed."
		if hash notify-send 2>/dev/null; then
			notify-send -i "$( cd "$( dirname "$0" )" && pwd )/icon.png" -t 2000 "poomf failed!"
		fi
	fi
}

function helpText ()
{
  printf "_____________ poomf for linux _____________\n"
  printf "Usage:\n"
  printf "  poomf [OPTIONS] [PATH]\n"
  printf "\n"
  printf "OPTIONS:\n"
  printf "  -d                 poomf entire desktop\n"
  printf "  -a                 poomf selected area\n"
  printf "  -w                 poomf current window\n"
  printf "  -c                 poomf clipboard content\n"
  printf "  -f                 poomf specific file (opens file dialog)\n"
  printf "\n"
  printf "  --help,-h          show this page\n"
  printf "\n"
  printf "PATH:\n"
  printf "  PATH               optional: path of file to poomf\n"
}

function generateFileName () { echo "/tmp/poomf-linux ($(date +"%Y-%m-%d at %I.%M.%S")).png"; }

function generateTextName () { echo "/tmp/poomf-linux ($(date +"%Y-%m-%d at %I.%M.%S")).txt"; }


if [ -z "$1" ]; then
	echo "No file entered."
	helpText
  exit 1

fi

#Get file to poomf and poomf it
case "$1" in
	-d)
		echo "Whole Desktop"
			fileName=$(generateFileName)
			gnome-screenshot -f "$fileName"
			poomfFile "$fileName"
		;;

	-a)
		echo "Area"
			fileName=$(generateFileName)
			gnome-screenshot -a -f "$fileName"
			poomfFile "$fileName"
		;;

	-w)
		echo "Window"
			fileName=$(generateFileName)
			gnome-screenshot -w -f "$fileName"
			poomfFile "$fileName"
		;;

	-c)
		echo "Clipboard upload"
			content=`xclip -out -selection c`
			if [ -f "$content" ]; then
				poomfFile "$content"
			else
				fileName=$(generateTextName)
				echo "$content" > "$fileName"
				poomfFile "$fileName"
			fi
		;;

	-f)
		echo "File Upload"
			fileName=`zenity --file-selection`
			poomfFile "$fileName"
		;;

	-h|--help)
		helpText
		exit 0
		;;

	*)
		echo "Upload $1"
			poomfFile "$1"
		;;

esac


