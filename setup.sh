#!/bin/sh
# Script to automatically create dotfile symlinks
# Inspired by: https://github.com/Lokaltog/sync/blob/master/dotfiles/setup.sh

#Convention dot.* will be linked with the dot. prefix removed

#Save original/starting directory
SAVEDIR="$PWD"

# Identify env with uname, make it lower case, only take first part before _
# ENV_NAME is used to call appropriate bash options for the environment. (ie darwin, cygwin, etc...)
ENV_NAME=$(uname -s | tr 'A-Z' 'a-z' | awk 'BEGIN {FS="_"};{print $1}')

get_abs_path() { save="$PWD"; cd $1; echo $PWD; cd $save; }

# Function: link_if(from,to)
# Creates link only if $2 file does not already exist
link_if() {
  if [ -e "$2" ]; then
    echo "    Warning: $2 already exists. No link will be created."
  else
    echo "    Linking: $1 to $2"
    ln -s "$1" "$2"
  fi
  }

# Function: cp_if(from,to)
# Copies only if $2 file does not already exist
cp_if() {
  if [ -e "$2" ]; then
    echo "    Warning: $2 already exists and won't be copied over"
  else
    echo "    Copying: $1 to $2"
    cp "$1" "$2"
  fi
  }

if [ -d "$1" ]; then
  TO="$(get_abs_path $1)"
else
  TO="$HOME"
fi

# Detect From directory
FROM="$(get_abs_path `dirname \`which $0\``)"

#source helper functions such as relpath()
source $FROM/home_bin/myutils.sh

#Link dot.* to home directory
echo "*** Linking $FROM/dot.* to $TO"
echo
cd $FROM
for FILE in dot.*; do
  link_if "$(relpath $TO $FROM)/$FILE" "$TO/${FILE:3}"  #strip first 3 char "dot" prefix when linking
done
echo

#copy template.* to home directory
echo "*** Copying $FROM/template.* to $TO"
echo
cd $FROM
for FILE in template.*; do
  cp_if "$FILE" "$TO/${FILE:8}"  #strip first 8 char "template" prefix when copying
done
if [ "$ENV_NAME" == "cygwin" ] ; then
  cp_if template.vimrc "$TO/_vimrc" #Also copy template.vimrc to _vimrc so it works with gvim win32
fi
echo

#Link OS specific dot.* to home directory
echo "*** Linking files from $FROM/OS_home/$ENV_NAME to $TO"
echo
cd "$FROM/OS_home/$ENV_NAME"
for FILE in dot.*; do
  link_if "$(relpath $TO $PWD)/$FILE" "$TO/${FILE:3}" #strip first 3 char "dot" prefix when linking
done
echo

#Link home_bin files to ~/bin
echo "*** Linking files from $FROM/home_bin to $TO/bin"
echo
[ ! -e "$TO/bin" ] && mkdir "$TO/bin"
cd "$FROM/home_bin"
for FILE in *; do
  #Don't link $FILE if it is a directory
  [ ! -d "$FILE" ] && link_if "$(relpath $TO/bin $PWD)/$FILE" "$TO/bin/$FILE"
done
echo

#Link OS specific home_bin files to ~/bin
echo "*** Linking files from $FROM/home_bin/$ENV_NAME to $TO/bin"
echo
cd "$FROM/home_bin/$ENV_NAME"
for FILE in *; do
   link_if "$(relpath $TO/bin $PWD)/$FILE" "$TO/bin/$FILE"
done


#Note: some of these programs don't play well inside cygwin
#Seems to be an issue with stdin and stdout streams...
#It might be better to have a cygwin version of node and the 
#corresponding npm packages
#if [[ $ENV_NAME=="cygwin" ]]; then
  #ln -s `which node.exe` "$TO/bin/node"
  #ln -s `which npm.cmd` "$TO/bin/npm"
  #ln -s `which coffee.cmd` "$TO/bin/coffee"
  #ln -s `which uglifyjs.cmd` "$TO/bin/uglifyjs"
  #ln -s `which jake.cmd` "$TO/bin/jake"
  #ln -s `which jslint.cmd` "$TO/bin/jslint"
  #ln -s `which jsonlint.cmd` "$TO/bin/jsonlint"
  #ln -s `which jshint.cmd` "$TO/bin/jshint"
  #ln -s `which jsctags.cmd` "$TO/bin/jsctags"
#fi

cd $SAVEDIR #Need to go back to $SAVEDIR because $FROM is relative path to $SAVEDIR
