require('vimp') -- https://github.com/svermeulen/vimpeccable
vimp.add_chord_cancellations('n', '<leader>') -- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps

-- Open Files Tree
vimp.nnoremap('<leader>e', [[:NvimTreeToggle<CR>]])
vimp.nnoremap('<leader>f', [[:NvimTreeFindFile<CR>]])
--Removing these from memory
--vimp.nnoremap('<leader>nt', [[:NvimTreeToggle<CR>]])
--vimp.nnoremap('<leader>nf', [[:NvimTreeFindFile<CR>]])

--Move lines up/down (uses 'vim-repeat' plugin)
vimp.bind({'repeatable'}, '[e', ':move--<cr>')
vimp.bind({'repeatable'}, ']e', ':move+<cr>')

-- reload darcy.keymaps
local util = require('darcy.util')
vimp.nnoremap('<leader>r', function()
  local darcyKeyMaps = 'darcy.keymaps'
  -- Remove all previously added vimpeccable maps
  vimp.unmap_all()
  -- Unload the lua namespace so that the next time require('vimrc.X') is called
  -- it will reload it
  util.unload_lua_namespace('darcy.keymaps')
  -- Make sure all open buffers are saved
  vim.cmd('silent wa')
  -- Execute our vimrc lua file again to add back our maps
  require('darcy.keymaps')

  print('Reloaded "darcy.keymaps"')
end)

-- Cycle through relativenumber + number, number (only), and no numbering.
vimp.nnoremap('<leader>n', function()
  if (vim.wo.number) then
    if (vim.wo.relativenumber) then
      vim.wo.relativenumber = false
    else
      vim.wo.number = false
    end
  else
    vim.wo.number = true
    vim.wo.relativenumber = true -- not(vim.wo.relativenumber)
  end
end)

-- toggle wrapping of lines
vimp.nnoremap({'silent'}, '<leader>w', ':set wrap!<CR>')

-- toggle display of invisible chars (whitespace, newlines)
vimp.nnoremap('<leader>l', function()
  vim.wo.list = not(vim.wo.list)
  if (vim.wo.list) then
    print('show invisible characters')
  else
    print('hide invisible characters')
  end
end)

--windows and tabs

-- Mappings to move around windows
vimp.nnoremap('<C-h>', '<C-W>h')
vimp.nnoremap('<C-j>', '<C-W>j')
vimp.nnoremap('<C-k>', '<C-W>k')
vimp.nnoremap('<C-l>', '<C-W>l')
vimp.nnoremap('<C-left>', '<C-W>h')
vimp.nnoremap('<C-down>', '<C-W>j')
vimp.nnoremap('<C-up>', '<C-W>k')
vimp.nnoremap('<C-right>', '<C-W>l')
-- Same mappings to move around windows (but for visual mode)
vimp.xnoremap('<C-h>', '<C-W>h')
vimp.xnoremap('<C-j>', '<C-W>j')
vimp.xnoremap('<C-k>', '<C-W>k')
vimp.xnoremap('<C-l>', '<C-W>l')
vimp.xnoremap('<C-left>', '<C-W>h')
vimp.xnoremap('<C-down>', '<C-W>j')
vimp.xnoremap('<C-up>', '<C-W>k')
vimp.xnoremap('<C-right>', '<C-W>l')

--Splits
--http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
--split window
vimp.nnoremap('<leader>sw<left>',  ':topleft  vnew<CR>')
vimp.nnoremap('<leader>sw<right>', ':botright vnew<CR>')
vimp.nnoremap('<leader>sw<up>',    ':topleft  new<CR>')
vimp.nnoremap('<leader>sw<down>',  ':botright new<CR>')
vimp.nnoremap('<leader>swh',       ':topleft  vnew<CR>')
vimp.nnoremap('<leader>swl',       ':botright vnew<CR>')
vimp.nnoremap('<leader>swk',       ':topleft  new<CR>')
vimp.nnoremap('<leader>swj',       ':botright new<CR>')
-- split relative to current buffer in window
vimp.nnoremap('<leader>s<left>',   ':leftabove  vnew<CR>')
vimp.nnoremap('<leader>s<right>',  ':rightbelow vnew<CR>')
vimp.nnoremap('<leader>s<up>',     ':leftabove  new<CR>')
vimp.nnoremap('<leader>s<down>',   ':rightbelow new<CR>')
vimp.nnoremap('<leader>sh',        ':leftabove  vnew<CR>')
vimp.nnoremap('<leader>sl',        ':rightbelow vnew<CR>')
vimp.nnoremap('<leader>sk',        ':leftabove  new<CR>')
vimp.nnoremap('<leader>sj',        ':rightbelow new<CR>')
