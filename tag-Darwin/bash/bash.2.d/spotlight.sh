#!/usr/bin/env bash
alias fix-spotlight="find . -path '*node_modules/*' -prune -o -type d -name 'node_modules' -exec touch '{}/.metadata_never_index' \;"
alias fix-spotlight-globally="find ~ -type d -path './.*' -prune -o -path './Pictures*' -prune -o -path './Library*' -prune -o -path '*node_modules/*' -prune -o -type d -name 'node_modules' -exec touch '{}/.metadata_never_index' \; -print"
# May need to reindex spotlight: `sudo mdutil -i on /`
