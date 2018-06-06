#!/usr/bin/env bash
alias ls="ls --color -F"

_cygpathUserProfile="$(cygpath "$USERPROFILE")"
alias desktop=cd "${_cygpathUserProfile}/Desktop"
alias downloads=cd "${_cygpathUserProfile}/Downloads"
alias mydocs=cd "${_cygpathUserProfile}/Documents"
alias work="cd /cygdrive/d/work"

alias open=cygstart

alias backupto="BackupTo.cmd"

#javascript aliases (Rhino)
alias js='java -cp '\''d:\jars\js.jar'\'' org.mozilla.javascript.tools.shell.Main -opt 0'
alias jsd='cygstart `which javaw` -cp '\''d:\jars\js.jar'\'' org.mozilla.javascript.tools.debugger.Main'

alias saxon='java -jar '\''d:\jars\saxon9.jar'\'

alias nginx='/usr/local/nginx/sbin/nginx.exe'

alias gvim='cyg-wrapper.sh '\''/cygdrive/c/Program Files/vim/vim-7.4.193-python-2.7-python-3.3-ruby-2.0.0-lua-5.2-windows-x64/gvim'\'' --binary-opt=-c,--cmd,-T,-t,--servername,--remote-send,--remote-expr'

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

alias ie="cygstart /cygdrive/c/Program\ Files/Internet\ Explorer/iexplore.exe"
alias chrome="cygstart /cygdrive/d/Users/dparker/AppData/Local/Google/Chrome/Application/chrome.exe"
alias firefox="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe"

alias explore='cyg-wrapper.sh "explorer" --slashed-opt'

#Alternate (may be better...)
#alias explorer="cygstart -x ."
alias remotedesktop=cygstart "$(which mstsc.exe)"

alias outlook="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Outlook\ 2013.lnk"
alias excel="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Excel\ 2013.lnk"
alias word="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Word\ 2013.lnk"
alias ppt="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/PowerPoint\ 2013.lnk"
alias onenote="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/OneNote\ 2013.lnk"
alias msaccess="cygstart /cygdrive/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Microsoft\ Office\ 2013/Access\ 2013.lnk"
alias msproject="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/winproj.exe"
alias visio="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Office/Office14/visio.exe"

alias mindmap="cygstart /cygdrive/c/Program\ Files\ \(x86\)/Mindjet/MindManager\ 10/MindManager.exe"
alias vmware="cygstart /cygdrive/c/Program\ Files\ \(x86\)/VMware/VMware\ Workstation/vmware.exe"
