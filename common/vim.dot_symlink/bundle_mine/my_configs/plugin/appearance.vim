" Syntax highlighting when supported by terminal or gui running
if &t_Co > 2 || has("gui_running")
  syntax on
endif

if &t_Co == 256 || has("gui_running")
  let &background="dark" "set background so highlighting is appropriate
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  colorscheme solarized
elseif &t_Co == 16
  "set background=dark "set background so highlighting is appropriate
  "let g:solarized_termcolors=16
  colorscheme slate
endif

"Add a colorcolumn @100 and 101
"Instead of testing `if version >= 703`, test if option is available
if exists("&colorcolumn")
  set colorcolumn=100,101
  "set colorcolumn=
  highlight ColorColumn ctermbg=lightgrey guibg=#5C5558
endif

"Set font
if has("gui_running")
  if has("gui_win32")
    "set guifont=Lucida\ Console:h10
    "set guifont=Consolas:h11 "Note: Consolas displays listchars properly, Lucidia Console does not
    "https://github.com/eugeneching/consolas-powerline-vim
    set guifont=Consolas\ for\ Powerline\ FixedD:h11
  elseif has("gui_macvim") || has("gui_mac")
    "set guifont=Monaco:h12
    "set guifont=Menlo:h12
    set guifont=Menlo\ Regular\ for\ Powerline:h12
  endif
endif

"Change cursor in insert mode on osx
if has("mac") && !has("gui_mac")
  "0: Block
  "1: Vertical bar
  "2: Underline
  if strlen($TMUX)
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=2\x7"
  endif
endif

if strlen($TMUX)
  "ttyfast is recommended when in tmux
  set ttyfast
endif

set number           " Show line numbers

"Set relative number if exists
"Instead of testing `if version >= 704`, test if option is available
if exists("&relativenumber")
  set relativenumber
endif

set ruler            " show the cursor position all the time
"set virtualedit=all  "allow the cursor to go to 'invalid' places
set cursorline       " marks the cursor's line with a line
set laststatus=2     " Always show the status line
set showcmd          " Display the command as it is typed
"set showmode        " Note, elsewhere I set noshowmode for powerline and
                     "showmode otherwise
set title            " Display filename in window title
set tabpagemax=50    " max tab pages to open
set showtabline=2    "tab labels will always be shown

set nowrap           "Don't wrap lines
set sidescroll=4     "When nowrap and long lines, scroll by 4 chars at a time
"map to toggle wrapping of lines
nnoremap <silent> <leader>w :set wrap!<CR>

set showmatch        "show matching bracket briefly
set matchtime=2      "time to show matching bracket 0.2 seconds
set matchpairs+=<:>  "add these for html/xml (not a substitute for matchit.vim, but useful)

" Show invisible characters
set list

"map to toggle display of invisible chars
noremap <leader>l :set list!<CR>

"reset screen
"See http://stackoverflow.com/questions/19236090/bash-shell-turns-to-symbols-when-using-vim-ack-plugin
"noremap <silent> <leader>r :!echo -e '\ec\e(K\e[J'<CR><CR>
set nolazyredraw
noremap <silent> <leader>r :redraw!<CR>

"See http://vim.wikia.com/wiki/Highlight_unwanted_spaces
"highlight ExtraWhitespace ctermbg=red guibg=red
"augroup WhitespaceMatch
  "" Remove ALL autocommands for the WhitespaceMatch group.
  "autocmd!
  "autocmd BufWinEnter * let w:whitespace_match_number = matchadd('ExtraWhitespace', '\s\+$')
  "autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  "autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
"augroup END
"function! s:ToggleWhitespaceMatch(mode)
  "let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  "if exists('w:whitespace_match_number')
    "call matchdelete(w:whitespace_match_number)
    "call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  "else
    "" Something went wrong, try to be graceful.
    "let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  "endif
"endfunction

" GUI appearance
if has("gui_running")
  if has("gui_macvim")
    set transp=0 " Transparency of the window background as a percent
    " Maximize Vim when entering fullscreen
    set fullscreen
    set fuoptions=maxvert,maxhorz
    "noremap <D-w> :bwipe<CR>
    "noremap <D-w> :bdelete<CR>
    "nmap <D-w> <Plug>Kwbd
    "noremap <D-t> :CommandT<CR>
  else
    set lines=80 columns=200
  endif
  " GUI Options. (Add/remove with += and -= respectively)
  " ------------------------------------------------------------

  " Do not use modal alert dialogs! (Prefer Vim style prompt.)
  " http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
  set guioptions+=c

  " l: Left-hand scrollbar is always present.
  set guioptions-=l

  " L: Left-hand scrollbar is present when there is a vertically split window
  set guioptions-=L

  " r: Right-hand scrollbar is always present.
  set guioptions+=r

  " R: Right-hand scrollbar is present when there is a vertically split window
  set guioptions+=R

  " b: Bottom (horizontal) scrollbar is present.
  set guioptions+=b

  " T: Toolbar
  set guioptions-=T

endif
