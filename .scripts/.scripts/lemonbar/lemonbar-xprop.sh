#!/bin/bash

# global variables for colours
RED=#dc1566
BLUE=#268bd2
MAGENTA=#d33682
CYAN=#2aa198
BLACK=#002b36
WHITE=#839496
DG=#2D453C

# symbols
sep_left=""                        # Powerline separator left
sep_right=""                       # Powerline separator right
sep_l_left=""                      # Powerline light separator left
sep_l_right=""                     # Powerline light sepatator right


clock() {
    date=$(date '+%b %d, %Y')
    clock=$(date '+%H:%M')
    echo "$date ${sep_l_left} $clock"
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
    declare -a open=($(xprop -root _NET_DESKTOP_NAMES | cut -d "=" -f 2 | tr -d ',"'))
    act=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
    act=${open[$act]}


    lines=("%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}") 
    for i in "${open[@]}"; do lines[$i-1]="%{F$WHITE}"; done

    lines[$act-1]="%{F$CYAN}"

    echo "${lines[@]}"
}

nowplaying() {
    cur=`mpc current`
    PARSER='cat' 
    test -n "$cur" && $PARSER <<< $cur || echo "%{F$RED}- stopped -%{F$WHITE}"
}

windowtitle() {
    title=$(xprop -root _NET_ACTIVE_WINDOW | cut -d '#' -f 2| tr -d ' ')
    title=$(xprop -id ${title} | awk '/WM_NAME/{$1=$2="";print}' | awk NR==1 | cut -d '"' -f2)
    echo $title
}


# This loop will finish a buffer with the info fetched in the functions above and output to stdout.
while :; do
    buf="%{S0} "
    buf="${buf} $(groups)"
    buf="${buf} %{F$WHITE}$sep_l_right"
    buf="${buf} \uf001: $(nowplaying) $sep_l_right"
    buf="${buf} %{c} $(windowtitle)"
    buf="${buf} %{r} $sep_l_left $(volume) $sep_l_left"
    buf="${buf} $(battery)% $sep_l_left"
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
