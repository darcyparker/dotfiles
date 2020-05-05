#!/usr/bin/env bash
# Note: There is a duplicate of this test in
# my_dotfile/common/bash.dot_symlink/platforms/cygwin
# * this is because Windows' links (mklink) cannot follow the 
#   from ~/.bash/platforms/cygwin/isPlatform.sh to here
[[ "$(uname -s)" == *CYGWIN* ]]
