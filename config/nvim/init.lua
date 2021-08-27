local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g      -- a table to access global variables
--local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
--local map = vim.api.nvim_set_keymap

-- Speed up startup time by avoiding search for python3 and python
-- Must be set before any check for has("python3") or has("python") or has("python2")
--g.loaded_python_provider = 0
--if fn.filereadable('/usr/local/bin/python3')
--  g.python3_host_prog = '/usr/local/bin/python3'
--endif
--if fn.filereadable('/usr/local/bin/python')
--  g.python_host_prog = '/usr/local/bin/python'
--endif

-- Set leader key early
g.mapleader = ','

-- Disable these built-in plugins
local disabled_built_ins = {
  'gzip', 'man', 'matchit', 'matchparen', 'shada_plugin', 'tarPlugin', 'tar', 'zipPlugin', 'zip', 'netrwPlugin'
}
for _,plugin in ipairs(disabled_built_ins) do g['loaded_' .. plugin] = 1 end

require('darcy.plugins')
require('darcy.config')
require('darcy.keymaps')
