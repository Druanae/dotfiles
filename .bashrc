# Source Global Definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias fullupdate='yaourt -Syu --aur'
alias :q='exit'
alias nano='vim'
alias autoremove='sudo pacman -Qdtq | sudo pacman -Rs -'
alias sudo='sudo '
alias grep='grep --color --line-number'
alias rebash="source ~/.bashrc"
alias copy="xclip -selection clipboard"
alias fetch="fdm fetch" # Fetches mail from server.
alias mail="mailx -N" # opens mailx interactive session without showing mail headers
alias mailx="mailx -N" # opens mailx interactive session without showing mail headers
alias clock="tty-clock -cnb"

# shortened commands
alias v='vim'
alias g='grep --color --line-number'
alias csv='column -t -s\;'
alias vol="alsamixer"

# Music Control
alias pa='mpc pause'
alias pl='mpc play'
alias st='mpc stop'
alias ne='mpc next'
alias pre='mpc prev'

# Some handy navigation aliases
#alias .='cd ..'
#alias ..='cd ../..'
#alias ...='cd ../../..'
#alias ....='cd ../../../..'

# Exports
export EDITOR=vim
export MAIL=$HOME/.var/mail/INBOX
export VISUAL=vim
export PS1='\[\033[0;31m\]\u \[\033[1;36m\]\w $(parse_git_branch)\n\[\033[1;32m\]> \[\033[00m\]'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export LANG=en_GB.UTF-8
export PATH="./local/bash:$PATH"
export PAGER=less

# History Options
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history.
shopt -s cmdhist
# Ignore duplicates, ls without options, and builtin commands.
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

# Set path for scripts
PATH="$HOME/.local/bin:${PATH}"
export PATH

# allow tab-completion on beets
eval "$(beet completion)"

# Scripts

# Function to parse current git branch to location.
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set tty colours
sh ~/.scripts/ttycols.sh

# Cowsay + Fortune on login:
# bash ~/.scripts/cowsay-fortune.sh

# Information to display on terminal start
clear
sh ~/.scripts/startup.sh
echo
