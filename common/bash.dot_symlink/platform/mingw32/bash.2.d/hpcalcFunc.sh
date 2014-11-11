#!/usr/bin/env bash
#Start HP48GX emulator
#Does not work unless CWD is in program files
if [ -e /cygdrive/c/Program\ Files\ \(x86\)/HP-Emulators/Emu48/Emu48.vbs -a -e /cygdrive/d/users/dparker/Documents/Hp48gx-darcy.E48 ]; then
  function hpcalc {
    pushd . > /dev/null
    cd /cygdrive/c/Program\ Files\ \(x86\)/HP-Emulators/Emu48
    cyg-wrapper.sh `which cscript` --cyg-verbose=2 /cygdrive/c/Program\ Files\ \(x86\)/HP-Emulators/Emu48/Emu48.vbs /cygdrive/d/users/dparker/Documents/Hp48gx-darcy.E48 > /dev/null
    popd > /dev/null
  }
fi
