" Select all
map <Leader>a ggVG

" Fix linewise visual selection of various text objects
  " First around or inside a tag from visual-line mode
  nnoremap Vit vitVkoj
  nnoremap Vat vatV
  "Second, around blocks - b=() and B={} - when in visual-line mode
  nnoremap Vab vabV
  nnoremap VaB vaBV

" Visually select last edit or pasted. (Similar to gv which selects last selected.)
" Note: There are many similar mappings such as `[v`], but this is better because
"       instead of v, it looks up the type of the last normal mode register used.
"       (characterwise, linewise, blockwise)
" See:  http://stackoverflow.com/questions/6228079/remove-newlines-from-a-register-in-vim/6235707#6235707
nnoremap <expr> gV    "`[".getregtype(v:register)[0]."`]"
