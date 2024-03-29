#!/usr/bin/env bash
# Non-Operating System Specific Aliases

#ls sugar
if type exa &> /dev/null; then
  alias ls="exa -F"
  alias ll="exa -lhF"
  alias lt="exa -tlAhF"
  alias lal="exa -lAhF"
  alias dir="exa -lAhF"
else
  alias ls="ls -F"
  alias ll="ls -lhF"
  alias lt="ls -tlAh"
  alias lal="ls -lAh"
  alias dir="ls -lAh"
fi

alias k9="kill -9"
alias ssn="sudo shutdown -h now"
alias ps="ps -af"

# shell
alias ..="cd .."
alias ...="cd ../.."

alias mkdir="mkdir -p"
alias md="mkdir -p"

alias du="du -h"
alias df="df -h"

alias cls="clear"
alias more="less"
alias del="rm"

alias ng="npm list -g --depth=0 2>/dev/null"
alias nl="npm list --depth=0 2>/dev/null"
