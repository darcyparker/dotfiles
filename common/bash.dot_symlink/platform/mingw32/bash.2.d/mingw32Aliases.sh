#!/usr/bin/env bash

# Aliases specific to mingw32
alias ls="ls --color -F"
#which on mingw32 doesn't support many of the switches normally available
#This which() will not be overwritten by which() in bash_common
function which { (alias; declare -f) | /usr/bin/which "$@"; }
export -f which

alias desktop="cd ~/Desktop"
alias downloads="cd ~/Downloads"
alias mydocs="cd ~/Documents"
alias dropbox="cd ~/Dropbox"
