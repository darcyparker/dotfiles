"New powerline... (having trouble with it on win32 gvim and cygwin)
"execute 'source $HOME'.'/my_dotfiles/common/vim.dot_symlink/bundle_github/powerline/powerline/ext/vim/source_plugin.vim'
"python from powerline.ext.vim import source_plugin; source_plugin()


if &t_Co == 256 || has("gui_running")
  "Powerline options
  let g:Powerline_symbols="fancy"

  " Fix names shownn for each mode. Character 183 works better than the default
  " unicode character
  let g:Powerline_mode_V="V·LINE"
  let g:Powerline_mode_cv="V·BLOCK"
  let g:Powerline_mode_S="S·LINE"
  let g:Powerline_mode_cs="S·BLOCK"
  let g:Powerline_colorscheme = 'solarized256'
  let g:Powerline_theme = 'default'
else
  "Powerline options
  let g:Powerline_symbols="compatible"
  let g:Powerline_colorscheme = 'solarized16'
  let g:Powerline_theme = 'default'
endif
