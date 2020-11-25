#!/usr/bin/env bash

# https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
[ -z "$XDG_CONFIG_HOME" ] \
  && export XDG_CONFIG_HOME="$HOME/.config"
