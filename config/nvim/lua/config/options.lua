-- Set leader key early
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.python3_host_prog = "/usr/local/bin/python3"

local opt = vim.opt -- https://github.com/neovim/neovim/pull/13479
local g = vim.g
local cmd = vim.cmd

g.autoformat = false

opt.eol = false
opt.hidden = true -- Allows hiding buffers even though they contain modifications which have not yet been written back to the associated file

vim.switchbuf = "usetab" --switch to first window/tab found for buffer when switching buffers

cmd("syntax enable")
cmd("filetype plugin indent on")

opt.completeopt = "menuone,noinsert"

local uname = vim.loop.os_uname()
if uname.sysname == "Darwin" then
  g.open_command = "open"
  g.system_name = "macOS"
  g.is_mac = true
elseif uname.sysname == "Linux" then
  g.open_command = "xdg-open"
  g.system_name = "Linux"
  g.is_linux = true
end

--indents and tabs
opt.expandtab = true -- tab key is expanded into spaces. Use Ctrl-V before tab to insert a real tab
opt.tabstop = 2 -- render a tab as 2 spaces
opt.shiftwidth = 2 -- number of spaces to (auto)indent, used with cindent, <<, >> etc
opt.softtabstop = 2 -- instead of inserting a real tab, insert spaces
opt.copyindent = true -- copy the preivous indentation on autoindenting
opt.shiftround = true -- use multiple of shiftwidth when indenting with '<' and '>'
opt.showtabline = 2 -- always disable tabs (as 2 spaces)
opt.autoindent = true
opt.smartindent = true

-- folding
opt.foldcolumn = "3" -- vim.wo
opt.foldmethod = "expr" -- vim.wo
opt.foldexpr = "nvim_treesitter#foldexpr()" -- vim.wo
opt.foldlevelstart = 10

--search and replace
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- override the 'ignorecase' option if the search pattern contains upper case chars
opt.incsearch = true -- start to search as typing starts

--mouse
opt.mouse = "a" -- mouse is enabled in all modes

opt.pumheight = 15 -- max items in pop up menu

--window splits
opt.splitbelow = true
opt.splitright = true

-- appearance
opt.termguicolors = true
opt.title = true --display filename in window title
opt.titlestring = "%<%F%=%l/%L - nvim"
opt.background = "dark"
g.solarized_termtrans = 1 --relevant to altercation/vim-colors-solarized
g.solarized_termcolors = 256 --relevant to altercation/vim-colors-solarized
opt.cursorline = true --marks the cursor's line with a line
opt.number = true --aways show numbers -- vim.wo
opt.signcolumn = "yes" -- vim.wo
opt.showtabline = 2 --always show tab labels
opt.wrap = false -- don't wrap lines -- vim.wo
opt.sidescroll = 4 -- when opt.wrap == false and long lines, scroll by 4 chars at a time
opt.showmatch = true -- show matching bracket briefly
opt.matchtime = 2 -- time to show the matching bracket (2 tenths of second)
--vim.bo.matchpairs = vim.bo.matchpairs .. ',<:>' -- add these for html/xml (not a substitute for andymass/vim-matchup (or matchit.vim), but useful)
-- vim.v.loaded_matchparen = 1 -- don't load matchparen plugin. It throws lots of errors in some cases... (typescript for example)
opt.list = true -- show invisible characters -- vim.wo
-- render bar at columns 100-101
opt.colorcolumn = "100,101" -- vim.wo
--cmd("highlight ColorColumn ctermbg=lightgrey guibg=#5C5558")

-- GUI Appearance
-- https://github.com/neovide/neovide/wiki/Configuration
opt.guifont = "MesloLGMDZ Nerd Font Mono:h16"

-- undo, swap & backup
opt.history = 1000
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir/"
opt.undolevels = 1000

--encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileformat = "unix"

--filetypes
--cmd([[autocmd BufNewFile,BufRead * if expand('%:t') == 'web.config' | set filetype=xml | endif]])
--cmd([[autocmd BufNewFile,BufRead * if match(expand('%:t'), '\.html\.template$') > -1 | set filetype=html | endif]])
cmd([[autocmd BufNewFile,BufRead .jshintrc,.jsbeautifyrc,.eslintcache set filetype=json]])
cmd([[autocmd BufNewFile,BufRead *.sch set filetype=xml]]) -- schematron

--insert mode
opt.pastetoggle = "<F2>" -- when in insert mode, press <F2> to go to paste mode, where you can paste mass data that won't be autoindented

--movement
opt.whichwrap = "h,l,~,[,],<,>" -- Which movemenent characters to wrap
opt.scrolloff = 4 -- keep 4 lines off the edges of the screen when scrolling
