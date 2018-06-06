#!/usr/bin/env bash
main(){
  git status --porcelain | while read -r _line; do
    local _filePath
    _filePath=$(echo "$_line" | cut -d' ' -f2)
    git add "$_filePath"
    git commit -m "Syntax updates/fixes for $_filePath"
  done
}
main
