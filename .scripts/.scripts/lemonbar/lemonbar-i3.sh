#!/bin/bash

# global variables for colours
RED=#dc322f
GREEN=#859900
WHITE=#839496
DG=#073642
clock() {
    date '+%b %d, %Y / %H:%M'
}

battery() {
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status

    test "`cat $BATS`" = "Charging" && echo -n ' ' || echo -n ' '

    sed -n p $BATC
}

volume() {
    state="$(amixer get Master | awk -F "[][]" 'NR==5')"
    mute="$(echo "$state" | awk -F "[][]" '{print $6}')"
    vol="$(echo "$state" | awk -F "[][]" '{print $2}')"
    if [ "$mute" == "off" ]; then echo "%{F$RED}: $vol%{F$WHITE}"; else echo ": $vol"; fi
}

cpuload() {
    LINE=`ps -eo pcpu | awk 'BEGIN {sum=0.0f} {sum+=$1} END {print sum}'`
    bc <<< $LINE
}

memused() {
    used=`free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }'`
    echo "$used"
}

network() {
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
    if iwconfig $int1 >/dev/null 2>&1; then
        wifi=$int1
        eth0=$int2
    else
        wifi=$int2
        eth0=$int1
    fi
    ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi

    ping -c 1 8.8.8.8 >/dev/null 2>&1 &&
        echo "$int connected" || echo "$int diconnected"
}

groups() {
    i3data=$(i3-msg -t get_workspaces | i3js)
    act=$(echo "$i3data" | awk 'NR==1')
    declare -a unf=($(echo "$i3data" | awk 'NR==2'))
    declare -a urg=($(echo "$i3data" | awk 'NR==3'))

    lines=("%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}") 

    lines[$act]="%{F$GREEN}"

    for i in "${unf[@]}"; do lines[$i]="%{F$WHITE}"; done
    for i in "${urg[@]}"; do lines[$i]="%{F$RED}"; done
    echo "${lines[@]}"
}

nowplaying() {
    cur=`mpc current`
    PARSER='cat' 
    test -n "$cur" && $PARSER <<< $cur || echo "%{F$RED}- stopped -%{F$WHITE}"
}

# This loop will finish a buffer with the info fetched in the functions above and output to stdout.
while :; do
    buf="%{S0} "
    buf="${buf} \uf001: $(nowplaying)"
    buf="${buf} %{c} $(groups)"
    buf="${buf} %{F$WHITE}"
    buf="${buf} %{r} $(volume) /"
    buf="${buf} $(battery)% /"
    buf="${buf} $(clock)"
    buf="${buf} %{r} "
    #buf="${buf} NET: $(network) -"
    #buf="${buf} CPU: $(cpuload)% -"
    #buf="${buf} RAM: $(memused)% -"
    #buf="${buf} VOL: $(volume)"
    #buf="${buf} MPD: $(nowplaying)"
    
    echo -e $buf
    # use `nowplaying scroll` to get a scrolling output!
    sleep 0.1 # The HUD will be updated every second
done
