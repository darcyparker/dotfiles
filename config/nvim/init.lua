local g = vim.g      -- a table to access global variables
--local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
--local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
--local map = vim.api.nvim_set_keymap

-- Speed up startup time by avoiding search for python3 and python
-- Must be set before any check for has("python3") or has("python") or has("python2")
--g.loaded_python_provider = 0
--if fn.filereadable("/usr/local/bin/python3")
--  g.python3_host_prog = "/usr/local/bin/python3"
--endif
--if fn.filereadable("/usr/local/bin/python")
--  g.python_host_prog = "/usr/local/bin/python"
--endif

-- Set leader key early
g.mapleader = ","

-- Disable these built-in plugins
local disabled_built_ins = {
  "gzip", "man", "matchit", "matchparen", "shada_plugin", "tarPlugin", "tar", "zipPlugin", "zip", "netrwPlugin"
}
for _,plugin in ipairs(disabled_built_ins) do g["loaded_" .. plugin] = 1 end

require "darcy.plugins"
require "darcy.options"
require "darcy.keymaps"

require "darcy.setup.cmp"
require "darcy.lsp"
require "darcy.setup.telescope"
require "darcy.setup.treesitter"

require "darcy.setup.lualine"
require "darcy.setup.bufferline"
require "darcy.setup.autopairs"
require "darcy.setup.comment"
require "darcy.setup.gitsigns"
require "darcy.setup.nvim-tree"
require "darcy.setup.toggleterm"
require "darcy.setup.project"
require "darcy.setup.impatient"
require "darcy.setup.indentline"
require "darcy.setup.alpha"
require "darcy.setup.whichkey"

require "darcy.autocommands"
