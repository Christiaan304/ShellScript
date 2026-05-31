#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -lh --color=auto'
alias lsa='ls -lah --color=auto'
alias cd.='cd ..'
alias cd..='cd ../..'
alias upgrade='pacman -Syu'
alias install='pacman -S'
alias grep='grep --color=auto'
PS1=PS1="\w \\$  "
