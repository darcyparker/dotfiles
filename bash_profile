# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# echo ~/.bash_profile

# Check that we haven't already been sourced.
[ -z "$BASHPROFILE_LOADED" ] || return

# shellcheck disable=1090
[ -z "$PROFILE_LOADED" ] && . ~/.profile

# shellcheck disable=1090
[ -z "$BASHRC_LOADED" ] && . ~/.bashrc

BASHPROFILE_LOADED=1
