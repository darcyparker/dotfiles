#!/usr/bin/env bash
[ -d /usr/local/go/bin ] && [ "${PATH#*/usr/local/go/bin:}" == "$PATH" ] && export PATH="/usr/local/go/bin:$PATH"
[ -n "$GOPATH" ] && [ "${PATH#*$GOPATH/bin:}" == "$PATH" ] && export PATH="$GOPATH/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && [ "${PATH#*$HOME/.cargo/bin:}" == "$PATH" ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d /usr/local/bin ] && [ "${PATH#*/usr/local/bin:}" == "$PATH" ] && export PATH="/usr/local/bin:$PATH"
[ -d /usr/local/sbin ] && [ "${PATH#*/usr/local/sbin:}" == "$PATH" ] && export PATH="/usr/local/sbin:$PATH"
[ -d "$HOME/.local/bin" ] && [ "${PATH#*$HOME/.local/bin:}" == "$PATH" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && [ "${PATH#*$HOME/bin:}" == "$PATH" ] && export PATH="$HOME/bin:$PATH"
