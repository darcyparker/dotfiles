#!/usr/bin/env bash
#Start HP48GX emulator
#For mingw64 and mingw32
if ! declare -f hpcalc &>/dev/null ; then
  if [ -e /c/Program\ Files\ \(x86\)/HP-Emulators/Emu48/Emu48.vbs ] && [ -e /d/users/dparker/Documents/Hp48gx-darcy.E48 ]; then
    function hpcalc {
      $(which cscript) 'c:\Program Files (x86)\HP-Emulators\Emu48\Emu48.vbs' 'd:\users\dparker\Documents\Hp48gx-darcy.E48' > /dev/null
    }
    export -f hpcalc
  fi
fi
