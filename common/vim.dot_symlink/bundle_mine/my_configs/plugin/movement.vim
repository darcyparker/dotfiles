set whichwrap=h,l,~,[,],<,> " Which movemenent characters to wrap
set scrolloff=4 "keep 4 lines off the edges of the screen when scrolling

"Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

"Disable the arrow keys in normal, visual and operator pending modes
"This is to force me to use h,j,k,l
noremap <left> <NOP>
noremap <right> <NOP>
noremap <up> <NOP>
noremap <down> <NOP>
" consider adding inoremap


" Move to last edit.
nnoremap <leader>ge `.
