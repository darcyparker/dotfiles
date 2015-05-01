#!/usr/bin/env bash

# $LANG must be set correctly before starting tmux
# en_US.UTF-8 or another UTF-8 locale is best
# In Debian `apt-get install locales debconf; dpkg-reconfigure locales`
# Check locales available with `locale -a`
[ -z "$LANG" ] \
  && locale -a | grep -q --color=never "en_US.utf8" \
  && export LANG=en_US.UTF-8
