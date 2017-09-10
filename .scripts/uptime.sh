#!/bin/bash
seconds="$(< /proc/uptime)"
seconds="${seconds/.*}"
days="$((seconds / 60 / 60 / 24)) days"
hours="$((seconds / 60 / 60 % 24)) hours"
mins="$((seconds / 60 % 60)) mins"

strip_date() {
    case "$1" in
        "0 "*) unset "${1/* }" ;;
        "1 "*) printf "%s" "${1/s}" ;;
        *)     printf "%s" "$1" ;;
    esac
}

days="$(strip_date "$days")"
hours="$(strip_date "$hours")"
mins="$(strip_date "$mins")"

uptime="${days:+$days, }${hours:+$hours, }${mins}"
uptime="${uptime%', '}"
uptime="${uptime:-${seconds} seconds}"
echo $uptime
