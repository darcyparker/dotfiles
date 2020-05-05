#!/usr/bin/env bash
# Note: There is a duplicate of this test in
# my_dotfile/common/bash.dot_symlink/platforms/msys
# * this is because Windows' links (mklink) cannot follow the 
#   from ~/.bash/platforms/msys/isPlatform.sh to here
[[ "$(uname -s)" == *MSYS* ]] || [[ "$(uname -s)" == *MINGW* ]]
