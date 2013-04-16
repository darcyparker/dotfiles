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
#To do:
# - call updatebundles.sh
# - check if dirs/links made correctly. On cygwin, mklink must be run as administrator

###########################################################################
# Function: get_abspath(path)
# - simple function to get the absolute path of $1 which typically would be
#   a relative path
###########################################################################
get_abs_path() { save="$PWD"; cd $1; echo $PWD; cd $save; }

##########################################################################################
# Function: add_symlink(SOURCE,TARGET)
# - Creates TARGET as a link to SOURCE
# - Before creating the link, tests whether or not the target already exists.
#   - On windows, it just gives a warning if the target exists
#   - On other unix systems, it uses the -i (interactive) link option and prompts
#     to see if you want to overwrite it or not.
# - On windows, mklink is used so that links work in everywhere (windows, cygwin, mingw32)
##########################################################################################
add_symlink() {
  SOURCE=$1 ; TARGET=$2
  if [[ "$ENV_NAME" == "mingw32" || "$ENV_NAME" == "cygwin" ]] ; then
    if [ -e "$TARGET" ]; then
      echo "*** Warning: $TARGET already exists. No link will be created."
    else
      if [ -d $SOURCE ]; then
        #if a directory, then create a directory soft link
        cmd /c mklink /d `cygpath -a -w $TARGET` `cygpath -a -w $SOURCE`
      else
        #If not a directory, then make a regular link
        cmd /c mklink `cygpath -a -w $TARGET` `cygpath -a -w $SOURCE`
      fi
    fi
  else
    #On unix systems, use the regular link command (-i: interactive mode)
    #To do: Why does prompt get skipped over?
    ln -s -i $SOURCE $TARGET
  fi
}

##########################################################################################
# Function: add_it(type,source)
# - Adds $SOURCE from the dot files repo to the desired target folder (usually $HOME)
# - The way it adds $SOURCE depends on the $TYPE value
#
#   "mkdir_for_symlinks" : makes a directory
#   "dot_symlink"        : adds a symbolic link with name transformed to ".name"
#   "symlink"            : adds a symbolic link (does not transform name)
#   "symlink_content"    : adds a symbolic link (does not transform name)
#                          (however it does strip the ".symlink_content" from its parent folder)
#   "dot_template"       : Copies the template to the target with name transformed to ".name"
#   "template"           : Copies the template to the target with no transform of the name
##########################################################################################
add_it() {
  SOURCE=$2 ; TYPE=$1
  NAME=${SOURCE##*/} #extract filename or dirname from $SOURCE
  FROM_RELATIVE=${SOURCE#$FROM/} #strip $FROM from front of $SOURCE path
  TO_RELATIVE=${FROM_RELATIVE#*/} # strip first folder (such as common or $ENV_NAME)
  TO_RELATIVE=${TO_RELATIVE%$NAME} #strip $NAME from end

  case "$TYPE" in
    "mkdir_for_symlinks")
      TARGET=$TO/$TO_RELATIVE/${NAME%.symlink_content}
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
    "dot_template")
      TARGET=$TO/$TO_RELATIVE/.${NAME%.dot_template}
      echo "Creating $TARGET from template"
      #To do: Why does prompt get skipped over?
      cp -i "$SOURCE" "$TARGET"
      ;;
    "template")
      TARGET=$TO/$TO_RELATIVE/${NAME%.template}
      echo "Creating $TARGET from template"
      #To do: Why does prompt get skipped over?
      cp -i "$SOURCE" "$TARGET"
      ;;
    *)
      echo "*** Error: TYPE "$TYPE" is unknown. Cannot add."
      ;;
  esac
}

##################
# Body of script #
##################

# Identify environment (eg. cygwin, darwin, mingw32, linux)
ENV_NAME=$(uname -s | tr 'A-Z' 'a-z' | sed -e 's/_.*//')
#ENV_NAME=$(uname -s | tr 'A-Z' 'a-z' | awk 'BEGIN {FS="_"};{print $1}')

# Identify target folder to setup
if [ -d "$1" ]; then
  TO="$(get_abs_path $1)"
else
  TO="$HOME"
fi

# Identify folder to setup from
FROM="$(get_abs_path `dirname \`which $0\``)"

echo "*** Create necessary folder structure if not present"
find "$FROM/common" "$FROM/$ENV_NAME" -type d -regex ".*[.]symlink_content$" | \
  while read i; do
    add_it "mkdir_for_symlinks" "$i"
  done
echo

echo "*** Create symbolic links to content found in *.symlink_content folders"
find "$FROM/common" "$FROM/$ENV_NAME" -regex ".*[.]symlink_content/[^/]*" | \
  while read i; do
    add_it "symlink_content" "$i"
  done
echo

echo "*** Create symbolic links to *.dot_symlink files"
find "$FROM/common" "$FROM/$ENV_NAME" -name "*.dot_symlink" | \
  while read i; do
    add_it "dot_symlink" "$i"
  done
echo

echo "*** Create symbolic links to *.symlink files"
find "$FROM/common" "$FROM/$ENV_NAME" -name "*.symlink" | \
  while read i; do
    add_it "symlink" "$i"
  done
echo

echo "*** Creating files from dot_templates"
find "$FROM/common" "$FROM/$ENV_NAME" -name "*.dot_template" -type f | \
  while read i; do
    add_it "dot_template" "$i"
  done
echo

echo "*** Creating files from templates"
find "$FROM/common" "$FROM/$ENV_NAME" -name "*.template" -type f | \
  while read i; do
    add_it "template" "$i"
  done
echo
echo "Done!"
