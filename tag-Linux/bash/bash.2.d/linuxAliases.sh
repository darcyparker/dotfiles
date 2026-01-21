#!/usr/bin/env bash
# Aliases specific to Linux
if type exa &>/dev/null; then
  alias ls="exa -F"
  alias ll="exa -lhF"
  alias lt="exa -tlAhF"
  alias lal="exa -lAhF"
  alias dir="exa -lAhF"
else
  alias ls="ls --color -F"
  alias ll="ls --color -lhF"
  alias lt="ls --color -tlAh"
  alias lal="ls --color -lAh"
  alias dir="ls --color -lAh"
fi
if command -v pacman >/dev/null 2>&1; then
  # optimize downloads of pacman (finds 5 fastest mirrors before doing update)
  fix-speed() {
    sudo pacman-mirrors --fasttrack 5 && sudo pacman -Syyu
  }
  export -f fix-speed
fi
