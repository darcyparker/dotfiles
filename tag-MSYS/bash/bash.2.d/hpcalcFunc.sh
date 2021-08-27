#!/usr/bin/env bash
#Start HP48GX emulator
if ! declare -f hpcalc &>/dev/null ; then
  #Note: cygwin does not define equivalent of %PROGRAMFILES(x86)%,
  #You can't have () in environment var name like `$PROGRAMFILES\(x86\)`
  #Workaround is to refer to $PROGRAMFILES followed by (x86) which assumes it
  #is in same drive (ie c:\) as $PROGRAMFILES
  if [ -e "$(cygpath -a -u "$PROGRAMFILES (x86)/HP-Emulators/Emu48/Emu48.vbs")" ] && [ -e "$(cygpath -a -u "$USERPROFILE/Documents/Hp48gx-darcy.E48")" ]; then
    function hpcalc {
      $(command -v cscript) "$(cygpath -a -w "$PROGRAMFILES (x86)/HP-Emulators/Emu48/Emu48.vbs")" "$(cygpath -a -w "$USERPROFILE/Documents/Hp48gx-darcy.E48")" > /dev/null
    }
    export -f hpcalc
  fi
fi
