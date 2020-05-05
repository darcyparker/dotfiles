#!/usr/bin/env bash
#Note: This is not a symbolic link like linux, darwin and wsl
#because Windows' links (mklink) cannot follow the links
[[ "$(uname -s)" == *MSYS* ]] || [[ "$(uname -s)" == *MINGW* ]]
