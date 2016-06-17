#!/usr/bin/env bash
# this is used as vim grepprg in conjunctions with ag.vim
# See http://artemave.github.io/2014/06/02/vim-git-grep/
# darcyparker@gmail Added support to grep git submodules

__formatOut(){
      local _basePath=$1; shift
      local _searchString=$1; shift
      local _gitGrep=$*
      local file_and_line=$(echo "$_gitGrep" | cut -d: -f1,2)
      local match=$(echo "$_gitGrep" | sed 's/[^:]*:[^:]*:\(.*\)/\1/')
      local column=$(echo "$match" | awk "{print index(\$0, \"$_searchString\")}")
      echo "$file_and_line:$column:$match"
}

__doGitGrep(){
  local _basePath=$1; shift
  local _searchString=$1;
  git --no-pager grep -n "$@" | while read _gitGrep; do __formatOut "$_basePath" "$_searchString" "$_gitGrep"; done
}

export -f __formatOut
export -f __doGitGrep

main(){
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 3>&1; then
  _searchString="$@"
  #   git grep -n "$@" | while read git_grep; do

  #     file_and_line=$(echo "$git_grep" | cut -d: -f1,2)
  #     match=$(echo "$git_grep" | sed 's/[^:]*:[^:]*:\(.*\)/\1/')
  #     column=$(echo "$match" | awk "{print index(\$0, \"$1\")}")

  #     echo "$file_and_line:$column:$match"
  #   done

    __doGitGrep "" "$@"
    # Next grep submodules
    # Note: Must create a bash subshell so exported functions are visible to the git foreach
    git --no-pager submodule --quiet foreach "echo \$path"
    # git --no-pager submodule --quiet foreach "bash -c \"__doGitGrep '$_searchString' \"; true"
  else
    ag --column "$@"
  fi
}
main "$@"
