#!/usr/bin/env bash
#Note: Surround $_frontPath in rare case there are spaces in it
if [ -z "$_frontPath" ]; then
  function setFrontPath {
    local _frontPathLocal
    # Move (or Add) /usr/local/bin to the front of the path
    [ -d /usr/local/bin ] && _frontPathLocal=/usr/local/bin

    [ -d /usr/local/go/bin ] && _frontPathLocal=/usr/local/go/bin:${_frontPathLocal}

    [ ! -z "$GOPATH" ] && _frontPathLocal=${_frontPathLocal}:${GOPATH}/bin

    [ -d "$HOME/.cargo/bin" ] && _frontPathLocal=${HOME}/.cargo/bin:${_frontPathLocal}

    # Move (or Add) /usr/local/bin to the front of the path
    [ -d "$HOME/.local/bin" ] && _frontPathLocal=${HOME}/.local/bin:${_frontPathLocal}

    # if there is a bin folder in home, add it to front of  PATH
    [ -d "$HOME/bin" ] && _frontPathLocal=${HOME}/bin:${_frontPathLocal}

    export _frontPath="$_frontPathLocal"
  }
  setFrontPath
  unset -f setFrontPath

  #For speed reasons, sed is called once at end
fi
function updatePath {
  local _removeExpression="s;\(:\?/usr/local/bin\)|\(:\?$_NPMPREFIXBIN\)|\(:\?$HOME/\.cargo/bin\)|\(:\?$HOME/\.local/bin\)|\(:\?$HOME/bin\)|\(:\?$GOPATH/bin\);;"
  local _tailPath
  _tailPath="$(echo "$PATH" | sed -e "${_removeExpression}")"
  export PATH=${_frontPath}:${_tailPath}
}
updatePath
