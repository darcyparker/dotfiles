#!/usr/bin/env bash
# Script to add files from my_dotfiles repo to my $HOME (or target) folder
# This script adds files as links or copies based on the content type.
#
# Files are organized into folders based on the environment (cygwin, darwin, linux, etc.)
# A common folder is used to store files that are common to all environments.
# The method for adding the dotfiles to my $HOME (or target) folder is indicated in the
# extension add to the file or directory name.
#
# dot_symlink     : Target will be a symbolic link to source
#                 : Target name will be prefixed with "." and ".dot_symlink" will be stripped
#
# symlink         : Target will be a symbolic link to source
#                 : Target name will only have the ".symlink" stripped
#
# template        : Target will be a copy of source
#                 : Target name will only have the ".template" stripped
#
# dot_template    : Target will be a copy of source
#                 : Target name will be prefixed with "." and ".dot_template" will be stripped
#
# symlink_content : A folder will be created with the target name
#                 : and symbolic links of its content will be made in the folder
#                 : Target name will have the ".symlink_content" stripped
#                 : The symbolic links will not change the name.
#
# dot_symlink_content : A folder will be created with dot prefixed and
#                     : and symbolic links of its content will be made in the folder
#                     : Target name will have the ".symlink_content" stripped
#                     : The symbolic links will not change the name.
#                     : Note, this is essentially same as `symlink_content` with a dot
#                     : prefix added.
#To do:
# - call updatebundles.sh
# - check if dirs/links made correctly. On cygwin, mklink must be run as administrator


##########################################################################################
# Function: _ln(SOURCE,TARGET)
# - Creates symbolic link using command appropriate for OS
##########################################################################################
_ln() {
  local SOURCE=$1 ; local TARGET=$2
  if [[ "$ENV_NAME" == "mingw32" || "$ENV_NAME" == "cygwin" ]] ; then
    if [ -d "$SOURCE" ]; then
      #if a directory, then create a directory soft link
      echo "INFO: Adding symlink to dir \"$SOURCE\""
      cygstart --action=runas cmd /c mklink /d "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
    else
      #If not a directory, then make a regular link
      echo "INFO: Adding symlink to file \"$SOURCE\""
      cygstart --action=runas cmd /c mklink "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
    fi
  else
    echo "INFO: Adding symlink to \"$SOURCE\""
    ln -s "$SOURCE" "$TARGET"
  fi
}

##########################################################################################
# Function: add_symlink(SOURCE,TARGET)
# - Creates TARGET as a link to SOURCE
##########################################################################################
add_symlink() {
  local SOURCE=$1 ; local TARGET=$2
  TARGET=${TARGET/\/\//\/} #clean up double "/" in some target paths

  #If $TARGET exits or it is a link (that may not exist), mv it
  # if [ -e "$TARGET" -o -L "$TARGET" ]; then
  if [ -e "$TARGET" ]; then
    local _itPointsTo=$(readlink "$TARGET")
    #If $TARGET == $SOURCE, do nothing...
    if  [[ $_itPointsTo != $SOURCE ]]; then
      local _currentSecond=$(date +%s)
      echo "*** Warning: \"$TARGET\" already exists"
      echo "    and does not point to \"$SOURCE\"."
      echo "    Moving to \"${TARGET}.${_currentSecond}.old\"."
      mv "$TARGET" "${TARGET}.${_currentSecond}.old"
      _ln "$SOURCE" "$TARGET"
    else
      echo "\"$TARGET\" already exists and links to this my_dotfiles repo."
    fi
  else
    if [ -L "$TARGET" ]; then
      #TARGET is a link that does not exist (It is broken)
      local _currentSecond=$(date +%s)
      echo "*** Warning: \"$TARGET\" is a broken link"
      echo "    Moving to \"${TARGET}.${_currentSecond}.brokenLink\"."
      mv "$TARGET" "${TARGET}.${_currentSecond}.brokenLink"
      _ln "$SOURCE" "$TARGET"
    else
      #The link does not exist and is not a broken link
      #So create it.
      _ln "$SOURCE" "$TARGET"
    fi
  fi
}

##########################################################################################
# Function: add_it(type,source)
# - Adds $SOURCE from the dot files repo to the desired target folder (usually $HOME)
# - The way it adds $SOURCE depends on the $TYPE value
#
#   "mkdir_for_symlinks"  : makes a directory
#   "dot_symlink"         : adds a symbolic link with name transformed to ".name"
#   "symlink"             : adds a symbolic link (does not transform name)
#   "symlink_content"     : adds a symbolic link (does not transform name)
#                           (however it does strip the ".symlink_content" from its parent folder)
#   "dot_symlink_content" : adds a symbolic link (does not transform name)
#                           (however it does strip the ".dot_symlink_content" from its parent folder)
#   "dot_template"        : Copies the template to the target with name transformed to ".name"
#   "template"            : Copies the template to the target with no transform of the name
##########################################################################################
add_it() {
  local SOURCE=$2 ; local TYPE=$1
  local NAME=${SOURCE##*/} #extract filename or dirname from $SOURCE
  local FROM_RELATIVE=${SOURCE#$FROM/} #strip $FROM from front of $SOURCE path
  local TO_RELATIVE=${FROM_RELATIVE#*/} # strip first folder (such as common or platform)
  local TO_RELATIVE=${TO_RELATIVE#$ENV_NAME/} # strip $ENV_NAME
  local TO_RELATIVE=${TO_RELATIVE%$NAME} #strip $NAME from end

  case "$TYPE" in
    "mkdir_for_symlinks")
      TARGET=$TO/$TO_RELATIVE/${NAME%.symlink_content}
      mkdir -p "$TARGET"
      ;;
    "mkdir_for_dot_symlinks")
      TARGET=$TO/$TO_RELATIVE/.${NAME%.dot_symlink_content}
      mkdir -p "$TARGET"
      ;;
    "dot_symlink")
      TARGET=$TO/$TO_RELATIVE/.${NAME%.dot_symlink}
      add_symlink "$SOURCE" "$TARGET"
      ;;
    "symlink")
      TARGET=$TO/$TO_RELATIVE/${NAME%.symlink}
      add_symlink "$SOURCE" "$TARGET"
      ;;
    "symlink_content")
      TARGET=$TO/${TO_RELATIVE/.symlink_content/}/$NAME
      add_symlink "$SOURCE" "$TARGET"
      ;;
    "dot_symlink_content")
      TARGET=$TO/.${TO_RELATIVE/.dot_symlink_content/}/$NAME
      add_symlink "$SOURCE" "$TARGET"
      ;;
    "dot_template")
      TARGET=$TO/$TO_RELATIVE/.${NAME%.dot_template}
      echo "Creating \"$TARGET\" from template"
      #To do: Why does prompt get skipped over?
      cp -i "$SOURCE" "$TARGET"
      ;;
    "template")
      TARGET=$TO/$TO_RELATIVE/${NAME%.template}
      echo "Creating \"$TARGET\" from template"
      #To do: Why does prompt get skipped over?
      cp -i "$SOURCE" "$TARGET"
      ;;
    "font")
      TARGET=$TO/.fonts/${NAME}
      #echo Adding font \"$SOURCE\" \"$TARGET\"
      add_symlink "$SOURCE" "$TARGET"
      ;;
    *)
      echo "*** Error: TYPE \"$TYPE\" is unknown. Cannot add."
      ;;
  esac
}

##################
# Body of script #
##################

# Identify environment (eg. cygwin, darwin, mingw32, linux)
ENV_NAME=$(uname -s | tr '[:upper:]' '[:lower:]' | sed -e 's/_.*//')

# Identify target folder to setup
if [ -d "$1" ]; then
  TO="$(cd "$1"; echo "$PWD")"
else
  TO="$HOME"
fi

# Identify folder to setup from
thisFile=$(which "$0")
FROM="$(cd "$(dirname "$thisFile")"; echo "$PWD")"

echo "*** Create necessary folder structure if not present"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -type d -regex ".*[.]symlink_content$" | \
  while read i; do
    add_it "mkdir_for_symlinks" "$i"
  done
echo
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -type d -regex ".*[.]dot_symlink_content$" | \
  while read i; do
    add_it "mkdir_for_dot_symlinks" "$i"
  done
echo

echo "*** Create symbolic links to content found in *.symlink_content folders"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -regex ".*[.]symlink_content/[^/]*" | \
  while read i; do
    add_it "symlink_content" "$i"
  done
echo

echo "*** Create symbolic links to content found in *.dot_symlink_content folders"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -regex ".*[.]dot_symlink_content/[^/]*" | \
  while read i; do
    add_it "dot_symlink_content" "$i"
  done
echo

echo "*** Create symbolic links to *.dot_symlink files"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -name "*.dot_symlink" | \
  while read i; do
    add_it "dot_symlink" "$i"
  done
echo

echo "*** Create symbolic links to *.symlink files"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -name "*.symlink" | \
  while read i; do
    add_it "symlink" "$i"
  done
echo

echo "*** Creating files from dot_templates"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -name "*.dot_template" -type f | \
  while read i; do
    add_it "dot_template" "$i"
  done
echo

echo "*** Creating files from templates"
find "$FROM/common" "$FROM/platforms/$ENV_NAME" -name "*.template" -type f | \
  while read i; do
    add_it "template" "$i"
  done
echo

pushd .
cd ~/.vim
./updateBundles.sh
popd

echo
echo "Done setup of dotfiles!"
