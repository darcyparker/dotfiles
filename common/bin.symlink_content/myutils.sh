#!/usr/bin/env bash

# Function:    get_abs_path(relative_path)
# Description: echos absolute path of relative_path
get_abs_path() { save="$PWD"; cd "$1" || exit; echo "$PWD"; cd "$save" || exit; }

# usage: relpath from to
#http://stackoverflow.com/questions/2564634/bash-convert-absolute-path-into-relative-path-given-a-current-directory
relpath() {
  if [[ "$1" == "$2" ]]
  then
      echo "."
      exit
  fi

  IFS="/"

  current=($1)
  absolute=($2)

  abssize=${#absolute[@]}
  cursize=${#current[@]}

  while [[ "${absolute[level]}" == "${current[level]}" ]]
  do
      (( level++ ))
      if (( level > abssize || level > cursize ))
      then
          break
      fi
  done

  for ((i = level; i < cursize; i++))
  do
      if ((i > level))
      then
          newpath=$newpath"/"
      fi
      newpath=$newpath".."
  done

  for ((i = level; i < abssize; i++))
  do
      if [[ -n $newpath ]]
      then
          newpath=$newpath"/"
      fi
      newpath=$newpath${absolute[i]}
  done

  echo "$newpath"
}

#Uncomment DEBUG variable to enable debugging
#DEBUG=1
debug(){ [ "$DEBUG" ] && echo "DEBUG>>> $*"; }

function_exists(){
  declare -f -F $1 > /dev/null
  return $?
}
# Example: function_exists function_name && echo Exists || echo No such function
