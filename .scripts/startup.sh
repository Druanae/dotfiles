#!/bin/sh

# Variable Definitions
new_mail=$(fcount $HOME/.var/mail/INBOX/new)

# Colour definitions
c00=$'\e[0;30m'
c01=$'\e[0;31m'
c02=$'\e[0;32m'
c03=$'\e[0;33m'
c04=$'\e[0;34m'
c05=$'\e[0;35m'
c06=$'\e[0;36m'
c07=$'\e[0;37m'
c08=$'\e[1;30m'
c09=$'\e[1;31m'
c10=$'\e[1;32m'
c11=$'\e[1;33m'
c12=$'\e[1;34m'
c13=$'\e[1;35m'
c14=$'\e[1;36m'
c15=$'\e[1;37m'

f00=$'\e[1;30m'
f01=$'\e[1;37m'
f02=$'\e[0;37m'

# Output
echo ""
cat << EOF
${c10}                            ██          ██
██                          ██
  ██              ██████    ██    ██  ████        ████████      ██████      ██████
    ██          ██      ██  ██  ██      ██        ██  ██  ██  ██      ██  ██      ██
      ██        ██  ██  ██  ████        ██        ██  ██  ██  ██  ██  ██  ██████████
    ██          ██  ██  ██  ████        ██        ██  ██  ██  ██  ██  ██  ██
  ██            ██      ██  ██  ██      ██        ██  ██  ██  ██      ██  ██      ██
██    ████████    ██████    ██    ██  ██████  ██  ██  ██  ██    ██████      ██████
${f01}
EOF
echo  
echo $(~/.scripts/marsweather.sh) 
echo "You have $new_mail new emails."