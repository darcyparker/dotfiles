#!/usr/bin/env bash
# this is used as vim grepprg in conjunctions with ag.vim
# See http://artemave.github.io/2014/06/02/vim-git-grep/
# Minor changes by me...
echo here

if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
  git grep -n "$@" | while read git_grep; do

    file_and_line=$(echo "$git_grep" | cut -d: -f1,2)
    match=$(echo "$git_grep" | sed 's/[^:]*:[^:]*:\(.*\)/\1/')
    column=$(echo "$match" | awk "{print index(\$0, \"$1\")}")

    echo "$file_and_line:$column:$match"
  done
else
  ag --column "$@"
fi
