# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# echo ~/.profile

# Check that we haven't already been sourced.
[ -z "$PROFILE_LOADED" ] || return

PROFILE_LOADED=1
