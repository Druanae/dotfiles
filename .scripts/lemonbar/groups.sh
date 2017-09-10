groups() {
    declare -a open=($(xprop -root _NET_DESKTOP_NAMES | cut -d "=" -f 2 | tr -d ',"'))
    act=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
    act=${open[$act]}
    echo $act
    echo ${open[@]}


    lines=("%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}" "%{F$DG}"       "%{F$DG}" "%{F$DG}" "%{F$DG}")
    for i in "${open[@]}"; do lines[$i-1]="%{F$WHITE}"; done

    lines[$act-1]="%{F$BLUE}"


    echo "${lines[@]}"
}
