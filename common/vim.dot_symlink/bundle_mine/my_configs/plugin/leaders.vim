" From Chris Toomey
" https://github.com/christoomey/dotfiles/blob/master/vim/rcfiles/leaders
"
" Mapleader => ',' in primary vimrc. Must occur before any <leader> maps
" I have it in the main vimrc now
"
" :exec ListMapShaddows()

nnoremap <leader>lm :exec ListMapShaddows()<CR>
nnoremap <leader>lmv :exec ListMapShaddows_visual()<CR>

function! ListMapShaddows()
     silent! redir @a
     silent! nmap <LEADER>
     silent! redir END
     silent! new
     silent! put! a
     silent! g/^s*$/d
     "improved substitute below to only remove up to the first comma
     silent! %s/^[^,]*,//
     silent! normal! ggVg
     silent! sort
     "last step is to get out of visual line mode
     silent! normal! V
     "silent! let lines = getline(1,"$")
endfunction

function! ListMapShaddows_visual()
     silent! redir @a
     silent! vmap <LEADER>
     silent! redir END
     silent! new
     silent! put! a
     silent! g/^s*$/d
     "improved substitute below to only remove up to the first comma
     silent! %s/^[^,]*,//
     silent! normal! ggVg
     silent! sort
     "last step is to get out of visual line mode
     silent! normal! V
     "silent! let lines = getline(1,"$")
endfunction
