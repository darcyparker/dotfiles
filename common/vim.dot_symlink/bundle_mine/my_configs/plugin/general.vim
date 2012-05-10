set showmatch           " Show matching parentheses

set novisualbell t_vb= " No visual bell
set noerrorbells       " Don't beep when there is an error

set noautoread " Do not reload the file if it changes

set noeol

set mls=10 " Check for modelines in the first and last 10 lines

set switchbuf=usetab "switch to first window/tab found for buffer when switching buffers

set hidden " Allows hiding buffers even though they contain modifications which
           " have not yet been written back to the associated file

set backspace=indent,eol,start "see :help 'backpace'
                               "Allows backspacing over everything
                               "while in insert mode

" switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

"Make Y behave like other capitals
nnoremap Y y$

" Make ; be equivalent to :
" don't remap : back to ; because it seems to break a bunch of plugins.
" Commenting these out because I miss ; to repeat last f,F,t,T
"nnoremap ; :
"vnoremap ; :
"cnoremap ; :

" Open a Scratch buffer https://github.com/vim-scripts/scratch.vim
nnoremap <leader><tab> :Scratch<CR>
