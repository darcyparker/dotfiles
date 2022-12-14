#!/usr/bin/env bash
pdftk "$1" cat 1-endeast output "$2" # rotating clockwise
# pdftk "$1" cat 1-endwest output "$2" # rotate anti-clockwise
