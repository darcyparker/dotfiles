" This is a wrapper .vimrc that finds and sources my vimrc from my git
" repository.
"
" Notes:
" - By convention, on unix-like environments, I symbolicly link my vim configuration
"   files in my git repository to ~/.vim
"   - I have a script called setup.sh in the root of my git repository that
"     creates the symbolic links for my .vim files and other dot files.
" - But this convention is not feasible for the win32 versions of (g)vim because 
"   windows does not recognize cygwin's symbolic links.
" - Therefore I set a global variable g:my_dot_vim_folder to the appropriate
"   folder for the environment I am running vim
if has("win32")
  "On win32 systems, by convention I keep my .vim files in $HOME/my_dotfiles/dot.vim
  let g:my_vim_files=expand("$HOME/my_dotfiles/dot.vim")
  "Add  g:my_vim_files to the runtimepath (rtp)
  execute "set rtp+=".g:my_vim_files
 else
  "On unix like systems, by convention I keep my .vim files in ~/.vim which is
  "a symbolic link to my dot.vim files in my git repository
  let g:my_vim_files =expand("$HOME/.vim")
endif

"Source my vimrc and if running a gui version of vim, source my gvimrc
if filereadable(g:my_vim_files  . "/vimrc")
  execute "source ".g:my_vim_files."/vimrc"
  if has("gui_running") && filereadable(g:my_vim_files . "/gvimrc")
  execute "source ".g:my_vim_files."/gvimrc"
  endif
endif
