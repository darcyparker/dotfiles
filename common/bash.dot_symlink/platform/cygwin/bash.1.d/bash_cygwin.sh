#!/usr/bin/env bash

# Remember to setup cygwin prompt here
# chere -i -t mintty -s bash -e "Open cygwin prompt here"

#See http://www.cygwin.com/cygwin-ug-net/using-cygwinenv.html
# Note: Not using obsolete options
export CYGWIN="nodosfilewarning"
unset PYTHONHOME

# Aliases specific to Cygwin (on Windows)

# which will look for aliases, functions and binaries
if [[ ! `declare -F which` ]]; then
  which () { (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
  export -f which
fi

alias ls="ls --color -F"
eval `dircolors ~/.dircolors/dircolors.ansi-universal`

alias desktop="cd `cygpath $USERPROFILE`/Desktop"
alias downloads="cd `cygpath $USERPROFILE`/Downloads"
alias mydocs="cd `cygpath $USERPROFILE`/Documents"
alias work="cd /cygdrive/d/work"
alias dropbox="cd `cygpath $USERPROFILE`/Dropbox"

alias open=cygstart

alias backupto="BackupTo.cmd"

#javascript aliases (Rhino)
alias js='java -cp '\''d:\jars\js.jar'\'' org.mozilla.javascript.tools.shell.Main -opt 0'
alias jsd='cygstart `which javaw` -cp '\''d:\jars\js.jar'\'' org.mozilla.javascript.tools.debugger.Main'

alias saxon='java -jar '\''d:\jars\saxon9.jar'\'

alias nginx='/usr/local/nginx/sbin/nginx.exe'

alias gvim='cyg-wrapper.sh '\''/cygdrive/c/Program Files/vim/vim-7.4a.044-python-2.7-python-3.3-windows-x64/gvim.exe'\'' --binary-opt=-c,--cmd,-T,-t,--servername,--remote-send,--remote-expr'

#Start HP48GX emulator
#Does not work unless CWD is in program files
hpcalc(){
  pushd . > /dev/null
  cd /cygdrive/c/Program\ Files\ \(x86\)/HP-Emulators/Emu48
  cyg-wrapper.sh `which cscript` --cyg-verbose=2 /cygdrive/c/Program\ Files\ \(x86\)/HP-Emulators/Emu48/Emu48.vbs /cygdrive/d/users/dparker/Documents/Hp48gx-darcy.E48 > /dev/null
  popd > /dev/null
}

alias yed="cygstart /cygdrive/c/Program\ Files\ \(x86\)/yWorks/yEd/yed.exe"
alias inkscape="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Inkscape/inkscape.exe"
alias notepad++="cygstart /cygdrive/c/Program\ Files\ \(x86\)/notepad++/notepad++.exe"
alias gimp="cygstart /cygdrive/c/Program\ Files/GIMP\ 2/bin/gimp-2.6.exe"
alias filezilla="cygstart /cygdrive/c/Program\ Files\ \(x86\)/FileZilla\ FTP\ Client/filezilla.exe"
alias acrobat="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Adobe/Reader\ 10.0/Reader/AcroRd32.exe"
alias handbrake="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Handbrake/Handbrake.exe"
alias 7zip="cygstart /cygdrive/c/Program\ Files/7-Zip/7zFM.exe"
alias freemind="cygstart /cygdrive/c/Program\ Files\ \(x86\)/FreeMind/Freemind.exe"
alias windirstat="cygstart /cygdrive/c/Program\ Files\ \(x86\)/WinDirStat/windirstat.exe"
alias vnc="cygstart /cygdrive/c/Program\ Files\ \(x86\)/TightVNC/vncviewer.exe"
alias skype="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Skype/Phone/Skype.exe"
alias yammer="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Yammer/Yammer.exe"

alias ie="cygstart /cygdrive/c/Program\ Files/Internet\ Explorer/iexplore.exe"
alias chrome="cygstart /cygdrive/d/Users/dparker/AppData/Local/Google/Chrome/Application/chrome.exe"
alias firefox="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe"

alias explore='cyg-wrapper.sh "explorer" --slashed-opt'

#Alternate (may be better...)
#alias explorer="cygstart -x ."
alias remotedesktop="cygstart `which mstsc.exe`"

alias outlook="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Outlook\ 2013.lnk"
alias excel="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Excel\ 2013.lnk"
alias word="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Word\ 2013.lnk"
alias ppt="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/PowerPoint\ 2013.lnk"
alias onenote="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/OneNote\ 2013.lnk"
alias msaccess="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Access\ 2013.lnk"
alias msproject="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/winproj.exe"
alias visio="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/visio.exe"
alias lync="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Lync\ 2013.lnk"

alias hipchat="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Atlassian/HipChat/HipChat.exe"
alias quassel="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Quassel/bin/quassel.exe"

alias mindmap="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mindjet/MindManager\ 10/MindManager.exe"
alias vmware="cygstart /cygdrive/c/Program\ Files\ \(x86\)/VMware/VMware\ Workstation/vmware.exe"
alias beyondcompare="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Beyond\ Compare\ 2/BC2.exe"

alias wf4="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Wildfire_4.0-Workingdir /cygdrive/d/ptc/proeWildfire4.0_M220/bin/proe.exe"
alias wf5="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Wildfire_5.0-Workingdir /cygdrive/d/ptc/Creo\ Elements/Pro5.0_M140/bin/proe.exe"
alias creo1p="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_1.0-Workingdir /cygdrive/d/ptc/Creo\ 1.0_m040/Parametric/bin/parametric.exe"
alias creo1d="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_1.0_Direct_WorkingDir /cygdrive/d/ptc/Creo\ 1.0_m040/Direct/bin/direct.exe"
alias creo2p="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_2.0-Workingdir /cygdrive/d/ptc/Creo\ 2.0/Parametric/bin/parametric.exe"
alias creo2d="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_2.0_Direct_WorkingDir /cygdrive/d/ptc/Creo\ 2.0/Direct/bin/direct.exe"
alias creop="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_2.0-Workingdir /cygdrive/d/ptc/Creo\ 2.0/Parametric/bin/parametric.exe"
alias creod="cygstart -d /cygdrive/d/ptc/pro_workingdirs/Creo_2.0_Direct_WorkingDir /cygdrive/d/ptc/Creo\ 2.0/Direct/bin/direct.exe"
alias mathcad15="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mathcad/Mathcad\ 15/mathcad.exe"
alias mathcadprime="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mathcad/Mathcad\ Prime\ 1.0/mathcadprime.exe"
alias arbortext="cygstart /cygdrive/c/Program\ Files\ \(x86\)/PTC/Arbortext\ Editor/bin/editor.exe"
