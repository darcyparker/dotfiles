#!/usr/bin/env bash
pushd . > /dev/null

function main {
  local ENV_NAME
  ENV_NAME=$(uname -s)
  if [ "$ENV_NAME" == "linux" ]; then
    sudo apt-get update
    sudo apt-get install -y build-essential cmake
    sudo apt-get install -y python-dev python3-dev
  fi

  cd ~/.vim/bundle_python_github/youCompleteMe
  #./install.py --ts-completer
  ./install.py --ts-completer --clang-completer
}

main

#See https://github.com/Valloric/YouCompleteMe
# if [ ! -d "$HOME/src/ycm_build" ]; then
#   mkdir -p "$HOME/src/ycm_build"
# fi
# cd "$HOME/src/ycm_build"
# _clangDirName=$(find /usr/local -maxdepth 1 -type d -name "clang*" | sed -n -e "1p")
# echo "$_clangDirName"
# #Create generator files
# cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT="$_clangDirName" . "$HOME/.vim/bundle_python_github/youCompleteMe/third_party/ycmd/cpp"
# #compile libraries
# cmake --build . --target ycm_core --config Release

# # Add go support
# cd "$HOME/.vim/bundle_python_github/youCompleteMe/third_party/ycmd/third_party/gocode"
# go build

# #Add javascript support
# cd "$HOME/.vim/bundle_python_github/youCompleteMe/third_party/ycmd/third_party/tern_runtime"
# npm install --production

# #Add rustc and cargo support
# cd "$HOME/.vim/bundle_python_github/youCompleteMe/third_party/ycmd/third_party/racerd"
# cargo build --release

popd > /dev/null
