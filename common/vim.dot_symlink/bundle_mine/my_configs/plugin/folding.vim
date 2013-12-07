set foldenable
set foldcolumn=3
"set foldmethod=indent

"<leader>ft -> Fold tag. (Useful for html and xml)
"(Visual Line mode, select around tag, create fold operator)
nnoremap <leader>ft Vatzf

"Refocus folds; close any other fold except the one that you are on
nnoremap ,z zMzvzz
