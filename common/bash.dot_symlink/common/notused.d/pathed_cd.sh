#!/usr/bin/env bash
# Bash snippet to open new shells in most recently visited dir.
# Useful if you want to open a new terminal tab at the present
# tab's location.
# source: http://gist.github.com/132456
function pathed_cd () {
    if [ "$1" == "" ]; then
        cd || exit
    else
        cd "$1" || exit
    fi
    pwd > ~/.cdpath
}
alias cd="pathed_cd"

if [ -f ~/.cdpath ]; then
  cd "$(cat ~/.cdpath)"
fi
