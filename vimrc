" -------------------------------------------------------------------------------------------------
" @file         .vimrc
" @description  Vim configuration file
" @author       Darcy Parker
" -------------------------------------------------------------------------------------------------
"  This file should be linked to $HOME/.vimrc (or %HOME%/_vimrc on windows)
"  On windows, be sure to define %HOME%
"   - vim searches for this file in %HOME%
"   - When cygwin is not used, I set %HOME%=%USERPROFILE%
"   - When cygwin is used, I set %HOME%=PATH_TO_CYGWIN_USER_HOME

set nocompatible "be iMproved

" Define the leader key early
let mapleader = ","
let g:mapleader = ","

"g:my_vim_dir is used elsewhere in my vim configurations
let g:my_vim_dir=expand("$HOME/.vim")

if has("win32") || has("win64") || has("win16")
  "Remove the $HOME/vimfiles folders from the &rtp and replace with $HOME/.vim
  "This way I can use the same $HOME/.vim when using cygwin or windows
  "Note, matches $HOME/vimfiles//* including $HOME/vimfiles/after
  let &runtimepath=substitute(&runtimepath,
                              \escape($HOME,'\').'[\\/]vimfiles',
                              \escape($HOME,'\').'\\.vim',
                              \'g'
                              \)

  "Not necessary, but I like see my paths on windows with \ instead of /
  "let &runtimepath=substitute(&runtimepath,"[/]","\\","g")

  "On windows, if called from cygwin or msys, the shell needs to be changed to cmd.exe
  if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
endif

if &loadplugins
  if !has('packages')
    " Load pathogen
    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('pack/bundle/opt/{}')
    if has('python') || has('python3')
      call pathogen#infect('pack/bundle_python_github/opt/{}')
    endif
    if has('ruby')
      if has('nvim')
        let g:ruby_host_prog = 'ruby'
      endif
      call pathogen#infect('pack/bundle_ruby_github/opt/{}')
    endif
    call pathogen#infect('bundle_mine/{}')
    call pathogen#helptags() "only needs to be run after adding new docs... but it's quick
  endif
endif

syntax on
filetype plugin indent on

"All of my personalized configurations are organized under bundle_mine in a
"modular fashion. No additional configurations are stored here.
