"Edit the vimrc (in my git repo and not the linked folders under home)
execute "nnoremap <leader>ev :e! ".$HOME."/.vimrc<cr>"

"Open NERDTree in the folder of my modularized vimrc
execute "nnoremap <leader>evr :NERDTree ".$HOME."/.vim/bundle_mine/my_configs<cr><cr>"
execute "nnoremap <leader>evp :NERDTree ".$HOME."/.vim/bundle_mine/my_plugin_configs<cr><cr>"

"map to source the current file if it is one of my *.vim configuration files
autocmd! bufenter *.vim nnoremap <buffer> <leader>so :source %<cr>
