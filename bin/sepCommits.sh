#!/usr/bin/env bash
main(){
  git status --porcelain | while read -r _line; do
    local _filePath
    local _fileName
    # local _fileExtension
    # local _baseFileName
    _filePath=$(echo "$_line" | cut -d' ' -f2)
    _fileName=$(basename -- "$_filePath")
    # _fileExtension="${_filename##*.}"
    # _baseFileName="${_filename%.*}"
    git add "$_filePath"
    git commit -m "$_fileName ($_filePath) updates"
  done
}
main
