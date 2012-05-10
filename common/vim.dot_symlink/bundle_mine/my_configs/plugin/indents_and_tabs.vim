"Default indent settings
set tabstop=2     " Render a tab as n spaces
set shiftwidth=2  " number of spaces to (auto)indent, used with cident, <<, >>, etc
set softtabstop=2 " instead of inserting a real tab, inserts spaces

set expandtab     " tab key is expanded into spaces. Use Ctrl-V before tab to insert a real tab
set copyindent    " copy the previous indentation on autoindenting
set shiftround    " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  " shiftwidth, not tabstop

set showtabline=2 " Always display tabs

" set cindent "autoindent, smartindent, or cindent
set autoindent    " auto-indent (Could also use smartindent or cindent)
set nosmartindent " Smart code auto-indent turned off since autoindent is on

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

"let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
