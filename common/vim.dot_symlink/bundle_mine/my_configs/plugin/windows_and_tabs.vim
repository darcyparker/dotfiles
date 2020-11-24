"Mappings to move around windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-left> <C-W>h
nnoremap <C-down> <C-W>j
nnoremap <C-up> <C-W>k
nnoremap <C-right> <C-W>l
"Same mappings to move around windows (but for visual mode)
xnoremap <C-h> <C-W>h
xnoremap <C-j> <C-W>j
xnoremap <C-k> <C-W>k
xnoremap <C-l> <C-W>l
xnoremap <C-left> <C-W>h
xnoremap <C-down> <C-W>j
xnoremap <C-up> <C-W>k
xnoremap <C-right> <C-W>l

"Splits
"http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
"split window
nnoremap <leader>sw<left>  :topleft  vnew<CR>
nnoremap <leader>sw<right> :botright vnew<CR>
nnoremap <leader>sw<up>    :topleft  new<CR>
nnoremap <leader>sw<down>  :botright new<CR>
nnoremap <leader>swh       :topleft  vnew<CR>
nnoremap <leader>swl       :botright vnew<CR>
nnoremap <leader>swk       :topleft  new<CR>
nnoremap <leader>swj       :botright new<CR>
" split relative to current buffer in window
nnoremap <leader>s<left>   :leftabove  vnew<CR>
nnoremap <leader>s<right>  :rightbelow vnew<CR>
nnoremap <leader>s<up>     :leftabove  new<CR>
nnoremap <leader>s<down>   :rightbelow new<CR>
nnoremap <leader>sh        :leftabove  vnew<CR>
nnoremap <leader>sl        :rightbelow vnew<CR>
nnoremap <leader>sk        :leftabove  new<CR>
nnoremap <leader>sj        :rightbelow new<CR>

"<leader>w -> Create a vertical window split and move to it
"nnoremap <leader>w <C-w>v<C-w>l
