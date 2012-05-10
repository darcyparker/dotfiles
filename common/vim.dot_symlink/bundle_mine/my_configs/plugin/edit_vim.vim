"Edit the vimrc (in my git repo and not the linked folders under home)
execute "nnoremap <leader>ev :e! ".$HOME."/my_dotfiles/common/vimrc.dot_symlink<cr>"

"Open NERDTree in the folder of my modularized vimrc
execute "nnoremap <leader>evr :NERDTree ".$HOME."/my_dotfiles/common/vim.dot_symlink/bundle_mine/my_configs/plugin<cr>"
execute "nnoremap <leader>evp :NERDTree ".$HOME."/my_dotfiles/common/vim.dot_symlink/bundle_mine/my_plugin_configs/plugin<cr>"

"map to source the current file if it is one of my *.vim configuration files
autocmd! bufenter *.vim nnoremap <buffer> <leader>so :source %<cr>
