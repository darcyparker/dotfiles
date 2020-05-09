#!/usr/bin/env bash
# Script to add files from my_dotfiles repo to my $HOME (or target) directory
# This script adds files as links or copies based on the content type.
#
# Files are organized into directories:
# * Based on the platform (cygwin, darwin, linux, msys, wsl, ...), and
# * A common directory for files that are common to all platforms
#
# The copying/linking method is identified by a naming convention appended
# to each file/directory's name:
#
# dot_symlink         : Target will be a symbolic link prefixed with `.` and 
#                     : `.dot_symlink` will be stripped from name.
#
# symlink_content     : A directory will be created with `.symlink_content` stripped from name
#                     : and symbolic links of its content will created in this directory.
#
# dot_symlink_content : Similar to symlink_content, but the created directory will be prefixed
#                     : with `.` .

#_abspath(): evaluate the absolute path to a dir or
_abspath() {
  #if some pushd/popd fails, consume error message(s) and return exit status
  if [[ -d "$1" ]]; then
    pushd "$1" >/dev/null || return $?
    pwd
    popd > /dev/null || return $?
  elif [[ -e $1 ]]; then
    pushd "$(dirname "$1")" >/dev/null || return $?
    echo "$(pwd)/$(basename "$1")"
    popd > /dev/null || return $?
  else
    echo "$1" does not exist! >&2
    return 127
  fi
}

# _ln(SOURCE,TARGET)
# * A wrapper around `ln` and `mklink` for creating symbolic links
_ln() {
  local SOURCE=$1 ; local TARGET=$2
  local _sourcePointsTo

  if [ -n "$_isWindows" ] ; then
    _sourcePointsTo=$(readlink -f "$SOURCE")
    if [ -d "$_sourcePointsTo" ]; then
      #if a directory, then create a directory soft link
      echo "INFO: Adding symlink to dir \"$SOURCE\""
      if [ -x "$(command -v cygstart)" ]; then
        # Note: mklink is a built in to cmd.exe, so this doesn't work from bash:
        cygstart --action=runas cmd /c mklink /d "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
      else
        #Could try: But need: ability to create links:
        #https://github.com/git-for-windows/git/wiki/Symbolic-Links#allowing-non-administrators-to-create-symbolic-links
        # mklink /d "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
        echo runas /user:Administrator cmd /c mklink /d "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
        echo "Must have cygstart to run mklink as admin"
        exit 1;
      fi
    else
      #If not a directory, then make a regular link
      echo "INFO: Adding symlink to file \"$SOURCE\""
      if [ -x "$(command -v cygstart)" ]; then
        # Note: mklink is a built in to cmd.exe, so this doesn't work from bash:
        cygstart --action=runas cmd /c mklink "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
      else
        #Could try: But need: ability to create links:
        #https://github.com/git-for-windows/git/wiki/Symbolic-Links#allowing-non-administrators-to-create-symbolic-links
        echo runas /user:Administrator cmd /c mklink "$(cygpath -a -w "$TARGET")" "$(cygpath -a -w "$SOURCE")"
        echo "Must have cygstart to run mklink as admin"
        exit 1;
      fi
    fi
  else
    echo "INFO: Adding symlink to \"$SOURCE\""
    ln -s "$SOURCE" "$TARGET"
  fi
  #Useful test when debugging
  #But don't use for cygwin because cygstart launches async work that may not be done yet
  # if [ ! -L "$TARGET" ]; then
  #   echo "Error creating sym link \"$TARGET\""
  #   exit 1
  # fi
}

# _addSymLink(SOURCE,TARGET)
# * Creates TARGET as a link to SOURCE
# * If an existing link exists at TARGET:
#   * if it is a broken link, it deletes it
#   * otherwise, it renames it before creating the new link
_addSymLink() {
  local SOURCE=$1 ; local TARGET=$2
  TARGET=${TARGET/\/\//\/} #clean up double "/" in some target paths
  local _sourcePointsTo
  local _targetPointsTo

  #If $TARGET exits or it is a link (that may not exist), mv it
  if [ -e "$TARGET" ]; then
    _targetPointsTo=$(readlink -f "$TARGET")
    _sourcePointsTo=$(readlink -f "$SOURCE")
    if  [[ $_targetPointsTo != "$_sourcePointsTo" ]]; then
      local _currentSecond
      _currentSecond=$(date +%s)
      echo "*** Warning: \"$TARGET\" already exists"
      echo "    and does not point to \"$SOURCE\"."
      echo "    Moving to \"${TARGET}.${_currentSecond}.old\"."
      mv "$TARGET" "${TARGET}.${_currentSecond}.old"
      _ln "$SOURCE" "$TARGET" || exit
    else
      echo "\"$TARGET\" already exists and links to this my_dotfiles repo."
    fi
  else
    if [ -L "$TARGET" ]; then
      #$TARGET does not exit, but link does (so it is a bad link)
      #So remove the bad link
      rm "$TARGET"
    fi
    #The link does not exist, so create it.
    _ln "$SOURCE" "$TARGET" || exit
  fi
}

# _addIt(TYPE, SOURCE)
# * Adds $SOURCE from the dot files repo to the desired target folder (usually $HOME)
# * The way it adds $SOURCE depends on the $TYPE value
_addIt() {
  local TYPE=$1
  local SOURCE=$2
  local TO=$3
  local _BASENAME
  local _DIRNAME
  local TARGET
  _BASENAME="$(basename "$SOURCE")"

  case "$TYPE" in
    "mkdir_for_symlinks")
      TARGET=$TO/${_BASENAME%.symlink_content}
      mkdir -p "$TARGET"
      if [ ! -d "$TARGET" ]; then
        echo "Error creating dir \"$TARGET\""
        exit 1;
      fi
      ;;
    "mkdir_for_dot_symlinks")
      TARGET=$TO/.${_BASENAME%.dot_symlink_content}
      mkdir -p "$TARGET"
      if [ ! -d "$TARGET" ]; then
        echo "Error creating dir \"$TARGET\""
        exit 1;
      fi
      ;;
    "dot_symlink")
      TARGET=$TO/.${_BASENAME%.dot_symlink}
      _addSymLink "$SOURCE" "$TARGET" || exit
      ;;
    "symlink_content")
      _DIRNAME="$(dirname "$SOURCE")"
      _DIRNAME="$(basename "$_DIRNAME")"
      _DIRNAME="${_DIRNAME/.symlink_content/}"
      TARGET=$TO/$_DIRNAME/$_BASENAME
      _addSymLink "$SOURCE" "$TARGET" || exit
      ;;
    "dot_symlink_content")
      _DIRNAME="$(dirname "$SOURCE")"
      _DIRNAME="$(basename "$_DIRNAME")"
      _DIRNAME=".${_DIRNAME/.dot_symlink_content/}"
      TARGET=$TO/$_DIRNAME/$_BASENAME
      _addSymLink "$SOURCE" "$TARGET" || exit
      ;;
    # Cases Not Used Today
    # ====================
    # "symlink")
    #   TARGET=$TO/${_BASENAME%.symlink}
    #   _addSymLink "$SOURCE" "$TARGET" || exit
    #   ;;
    # "dot_template")
    #   TARGET=$TO/.${_BASENAME%.dot_template}
    #   cp -i "$SOURCE" "$TARGET"
    #   if [ ! -e "$TARGET" ]; then
    #     echo "Error copying \"$SOURCE\" to \"$TARGET\""
    #     exit 1
    #   fi
    #   ;;
    # "template")
    #   TARGET=$TO/${_BASENAME%.template}
    #   cp -i "$SOURCE" "$TARGET"
    #   if [ ! -e "$TARGET" ]; then
    #     echo "Error copying \"$SOURCE\" to \"$TARGET\""
    #     exit 1
    #   fi
    #   ;;
    # "font")
    #   TARGET=$TO/.fonts/${_BASENAME}
    #   _addSymLink "$SOURCE" "$TARGET" || exit
    #   ;;
    *)
      echo "*** Error: TYPE \"$TYPE\" is unknown. Cannot add \"$SOURCE\"."
      exit 1
      ;;
  esac
}

# _addEachFrom(FROM, TO)
# * Processes adding files from the FROM folder to the TO target
_addEachFrom() {
  local FROM="$1"
  local TO="$2"
  if [ -d "$FROM" ] && [ -d "$TO" ]; then

    local i

    echo "*** Create necessary folder structure if not present"
    find "$FROM" -maxdepth 1 -type d -regex ".*[.]symlink_content$" | \
      while read -r i; do
        _addIt "mkdir_for_symlinks" "$i" "$TO" || exit
      done
    echo
    find "$FROM" -maxdepth 1 -type d -regex ".*[.]dot_symlink_content$" | \
      while read -r i; do
        _addIt "mkdir_for_dot_symlinks" "$i" "$TO" || exit
      done
    echo

    echo "*** Create symbolic links to content found in *.symlink_content folders"
    find "$FROM" -maxdepth 2 -regex ".*[.]symlink_content/[^/]*" | \
      while read -r i; do
        _addIt "symlink_content" "$i" "$TO" || exit
      done
    echo

    echo "*** Create symbolic links to content found in *.dot_symlink_content folders"
    find "$FROM" -maxdepth 2 -regex ".*[.]dot_symlink_content/[^/]*" | \
      while read -r i; do
        _addIt "dot_symlink_content" "$i" "$TO" || exit
      done
    echo

    echo "*** Create symbolic links to *.dot_symlink files"
    find "$FROM" -maxdepth 1 -name "*.dot_symlink" | \
      while read -r i; do
        _addIt "dot_symlink" "$i" "$TO" || exit
      done
    echo

    # Cases Not Used Today
    # ====================
    # echo "*** Create symbolic links to *.symlink files"
    # find "$FROM" -maxdepth 1 -name "*.symlink" | \
    #   while read -r i; do
    #     _addIt "symlink" "$i" "$TO" || exit
    #   done
    # echo

    # echo "*** Creating files from dot_templates"
    # find "$FROM" -maxdepth 1 -name "*.dot_template" -type f | \
    #   while read -r i; do
    #     _addIt "dot_template" "$i" "$TO" || exit
    #   done
    # echo

    # echo "*** Creating files from templates"
    # find "$FROM" -maxdepth 1 -name "*.template" -type f | \
    #   while read -r i; do
    #     _addIt "template" "$i" "$TO" || exit
    #   done
    # echo
  fi
}

# _updateVimBundles(TO)
# * calls `$1/.vim/updateBundles.sh`
_updateVimBundles() {
  pushd . > /dev/null || exit 1
  cd "$1/.vim" || exit 1
  ./updateBundles.sh
  popd > /dev/null || exit 1
}

# main(TO?)
# * Sets up the required files in `TO` (defaults to `$HOME`)
#   * Iterates over files to setup in `common` and `platforms`
# * If the environment is Windows, also adds a symbolic link to
#   `_vimrc`.
# * Finally calls `_updateVimBundles`
main() {
  local TO
  local FROM

  # Identify target folder to setup
  if [ -d "$1" ]; then
    TO="$(_abspath "$1")"
  else
    TO="$HOME"
  fi

  #If needed create $TO/.config
  mkdir -p "${XDG_CONFIG_HOME:=$TO/.config}"

  # Identify folder to setup from
  FROM="$(_abspath "$(dirname "$(command -v "$0")")")"

  #Note: _isWindows is used by _ln() and unset when done
  _isWindows="$("$FROM/platforms/cygwin/isPlatform.sh" || "$FROM/platforms/msys/isPlatform.sh" && echo 'true')"

  #_addEachFrom common
  _addEachFrom "$FROM/common" "$TO" || exit

  #For each applicable platform, _addEachFrom
  for i in "$FROM/platforms"/*; do
    if [ -d "$i" ] && [ -x "$i/isPlatform.sh" ] && "$i/isPlatform.sh"; then
      _addEachFrom "$i" "$TO" || exit
    fi
  done

  if [ -n "$_isWindows" ] ; then
    echo "Linking \"$FROM/common/vimrc.dot_symlink\" to \"$TO/_vimrc\""
    _addSymLink "$FROM/common/vimrc.dot_symlink" "$TO/_vimrc" || exit
  fi

  _updateVimBundles "$TO" || exit
}

main "$1"

unset _isWindows
unset -f main
unset -f _addEachFrom
unset -f _updateVimBundles
unset -f _abspath
unset -f _ln
unset -f _addSymLink
unset -f _addIt

echo
echo "Done setup of dotfiles!"
