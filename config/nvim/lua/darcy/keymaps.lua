local status_ok, vimp = pcall(require, "vimp") -- https://github.com/svermeulen/vimpeccable
if not status_ok then
  return
end

local nnoremap = vimp.nnoremap
local vnoremap = vimp.vnoremap
local xnoremap = vimp.xnoremap
local noremap = vimp.noremap
local bind = vimp.bind

vimp.add_chord_cancellations('n', '<leader>') -- https://github.com/svermeulen/vimpeccable#chord-cancellation-maps

-- Open Files Tree
-- nnoremap({'silent'}, '<C-n>', [[:NvimTreeToggle<CR>]])
nnoremap({'silent'}, '<C-n>', [[:NvimTreeFindFileToggle<CR>]])
-- nnoremap({'silent'}, '<C-n>', [[:NvimTreeFindFile<CR>]])
-- nnoremap({'silent'}, '<leader>f', [[:NvimTreeFindFile<CR>]])
-- nnoremap({'<leader>e'}, function()
--   -- Open Files tree focused on my nvim configuration files
--   vim.cmd[[:cd $HOME/src/dotfiles/config/nvim/lua/darcy]]
--   vim.cmd[[:NvimTreeToggle]]
--   --vim.cmd[[:e $HOME/src/dotfiles/config/nvim/lua/darcy]]
-- end)

--Navigate Buffers
nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")

--Move lines up/down (uses 'vim-repeat' plugin)
bind({'repeatable'}, '[e', ':move--<cr>')
bind({'repeatable'}, ']e', ':move+<cr>')

if (vim.g.neovide) then
  vim.cmd[[:command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen]]
  -- Cmd-Enter toggles fullscreen
  -- Broken: https://github.com/neovide/neovide/issues/994
  bind('<D-enter>', [[:NeovideToggleFullscreen<CR>]])
end

-- reload darcy.config & darcy.keymaps
local util = require('darcy.util')
nnoremap('<leader>r', function()

  local darcyOptions = 'darcy.options'
  local darcyKeyMaps = 'darcy.keymaps'
  util.unload_lua_namespace(darcyOptions)
  util.unload_lua_namespace(darcyKeyMaps)
  vim.cmd('silent wa') -- Make sure all open buffers are saved

  require(darcyOptions)
  print('Reloaded '..darcyOptions)

  vimp.unmap_all() -- Remove all previously added vimpeccable maps
  require(darcyKeyMaps)
  print('Reloaded '..darcyKeyMaps)
end)

-- Cycle through relativenumber + number, number (only), and no numbering.
nnoremap('<leader>n', function()
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
nnoremap({'silent'}, '<leader>W', ':set wrap!<CR>')

-- toggle display of invisible chars (whitespace, newlines)
-- nnoremap('<leader>l', function()
--   vim.wo.list = not(vim.wo.list)
--   if (vim.wo.list) then
--     print('show invisible characters')
--   else
--     print('hide invisible characters')
--   end
-- end)

-- Trim trailing white space (and preserve cursor)
-- See http://vimcasts.org/episodes/tidying-whitespace/
-- https://github.com/McAuleyPenney/tidy.nvim
nnoremap('<leader>ws', require('tidy.init').tidy_up)

--windows and tabs

-- Mappings to move around windows
nnoremap(              '<C-h>', '<C-W>h')
nnoremap(              '<C-j>', '<C-W>j')
nnoremap(              '<C-k>', '<C-W>k')
nnoremap({'override'}, '<C-l>', '<C-W>l') -- override ctrl-l (clear and redraw screen)
nnoremap('<C-left>', '<C-W>h')
nnoremap('<C-down>', '<C-W>j')
nnoremap('<C-up>', '<C-W>k')
nnoremap('<C-right>', '<C-W>l')
-- Same mappings to move around windows (but for visual mode)
xnoremap('<C-h>', '<C-W>h')
xnoremap('<C-j>', '<C-W>j')
xnoremap('<C-k>', '<C-W>k')
xnoremap('<C-l>', '<C-W>l')
xnoremap('<C-left>', '<C-W>h')
xnoremap('<C-down>', '<C-W>j')
xnoremap('<C-up>', '<C-W>k')
xnoremap('<C-right>', '<C-W>l')

--Splits
--http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
--split window
nnoremap('<leader>sw<left>',  ':topleft  vnew<CR>')
nnoremap('<leader>sw<right>', ':botright vnew<CR>')
nnoremap('<leader>sw<up>',    ':topleft  new<CR>')
nnoremap('<leader>sw<down>',  ':botright new<CR>')
nnoremap('<leader>swh',       ':topleft  vnew<CR>')
nnoremap('<leader>swl',       ':botright vnew<CR>')
nnoremap('<leader>swk',       ':topleft  new<CR>')
nnoremap('<leader>swj',       ':botright new<CR>')
-- split relative to current buffer in window
nnoremap('<leader>s<left>',   ':leftabove  vnew<CR>')
nnoremap('<leader>s<right>',  ':rightbelow vnew<CR>')
nnoremap('<leader>s<up>',     ':leftabove  new<CR>')
nnoremap('<leader>s<down>',   ':rightbelow new<CR>')
nnoremap('<leader>sh',        ':leftabove  vnew<CR>')
nnoremap('<leader>sl',        ':rightbelow vnew<CR>')
nnoremap('<leader>sk',        ':leftabove  new<CR>')
nnoremap('<leader>sj',        ':rightbelow new<CR>')

--nnoremap('<leader>z', 'Vatzf') --fold tag (useful fo rhtml/xml) (Visual Line mode, select around tag, create fold operator)
nnoremap('<leader>z', 'zMzvzz') -- "Refocus folds; close any other fold except the one that you are on

nnoremap('<leader>c', ':cd %:p:h<CR>') -- switch to the directory of the open buffer

--Reselect visual block after indent/outdent
vnoremap('<', '<gv')
vnoremap('>', '>gv')

--macros
nnoremap('<leader>qp', ':g//@a<left><left><left>') --Execute macro in register @a on lines that match pattern

--Disable the arrow keys in normal, visual and operator pending modes
noremap('<left>', '<NOP>')
noremap('<right>', '<NOP>')
noremap('<up>', '<NOP>')
noremap('<down>', '<NOP>')

--nnoremap('<leader>ge', '`.') -- move to last edit (just use the . marker)

--Easier increment/decrement of numbers
nnoremap('+', '<C-a>')
nnoremap('-', '<C-x>')

--Normal Mode edits
nnoremap({'silent'}, '<leader><CR>', 'i<CR><ESC>') --break the line at the cursor

--Search and Replace
nnoremap({'silent'}, '<leader>/', ':let @/ = ""<CR>') -- clear the last search pattern
vnoremap('g/', 'y/<C-R>"<CR>') -- search for the visually selected text
nnoremap('c*', '*Ncgn') -- https://www.youtube.com/watch?v=7Bx_mLDBtRc (change what's under cursor... (use with n and . to repeat)

-- http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
-- `:h magic` `\v` prefix before allows regular regex's without crazy escape patterns
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Command mode mappings
-- c_CTRL-B -- move to beginning of line
-- c_CTRL-E -- move to ending of line
-- c_CTRL-F -- command line history and editing
-- c_CTRL-U -- remove chars from cursor to beginning of line
-- c_CTRL-W -- Delete word before cursor
-- c_CTRL-H -- Delete character before cursor
