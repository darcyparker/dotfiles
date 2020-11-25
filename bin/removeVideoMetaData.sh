#!/usr/bin/env bash
_main(){
  # $1 is fullfile path
  local _filename
  local _extension
  local _baseFileName
  local _tempName
  _filename=$(basename -- "$1")
  _extension="${_filename##*.}"
  _baseFileName="${_filename%.*}"
  _tempName="$_baseFileName.temp.$_extension"
  echo "Meta Data Before:"
  exiftool -all "$1"
  ffmpeg -i "$1" -map_metadata -1 -metadata title="$_filename" -c:v copy -c:a copy "$_tempName"
  rm "$1"
  mv "$_tempName" "$1"
  echo "Meta Data After:"
  exiftool -all "$1"
}
_main "$@"
