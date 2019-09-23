#!/usr/bin/env bash
# https://unix.stackexchange.com/a/120201
xev | grep -A2 --line-buffered '^KeyRelease' \
    | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'
