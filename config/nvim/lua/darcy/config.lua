-- Configurations

vim.o.eol = false
vim.o.hidden = true -- Allows hiding buffers even though they contain modifications which have not yet been written back to the associated file

vim.switchbuf='usetab' --switch to first window/tab found for buffer when switching buffers

vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

vim.o.clipboard = "unnamedplus"

vim.o.completeopt = "menuone,noinsert"

local uname = vim.loop.os_uname()
if uname.sysname == 'Darwin' then
  vim.g.open_command = 'open'
  vim.g.system_name = 'macOS'
  vim.g.is_mac = true
elseif uname.sysname == 'Linux' then
  vim.g.open_command = 'xdg-open'
  vim.g.system_name = 'Linux'
  vim.g.is_linux = true
end

--indents and tabs
vim.o.expandtab = true  -- tab key is expanded into spaces. Use Ctrl-V before tab to insert a real tab
vim.o.tabstop = 2 -- render a tab as 2 spaces
vim.o.shiftwidth = 2 -- number of spaces to (auto)indent, used with cindent, <<, >> etc
vim.o.softtabstop = 2 -- instead of inserting a real tab, insert spaces
vim.o.copyindent = true -- copy the preivous indentation on autoindenting
vim.o.shiftround = true -- use multiple of shiftwidth when indenting with '<' and '>'
vim.o.showtabline = 2 -- always disable tabs (as 2 spaces)
vim.o.autoindent = true
vim.o.smartindent = true

-- folding
vim.wo.foldcolumn = "3"
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 10

--search and replace
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- override the 'ignorecase' option if the search pattern contains upper case chars
vim.o.incsearch = true -- start to search as typing starts
vim.o.shortmess:gsub('S', '') -- replaces 'henrik/vim-indexed-search'

--mouse
vim.o.mouse = "a" -- mouse is enabled in all modes

vim.o.pumheight = 15 -- max items in pop up menu

--window splits
vim.o.splitbelow = true
vim.o.splitright = true

-- appearance
vim.o.termguicolors = true
vim.o.title = true --display filename in window title
vim.o.titlestring = "%<%F%=%l/%L - nvim"
vim.o.background = "dark"
vim.cmd 'colorscheme solarized'
vim.g.solarized_termtrans = 1
vim.g.solarized_termcolors = 256
vim.o.cursorline = true --marks the cursor's line with a line
vim.wo.number = true --aways show numbers
vim.wo.signcolumn = "yes"
vim.o.showtabline = 2 --always show tab labels
vim.wo.wrap = false -- don't wrap lines
vim.o.sidescroll = 4 -- when vim.wo.wrap == false and long lines, scroll by 4 chars at a time
vim.o.showmatch = true -- show matching bracket briefly
vim.o.matchtime = 2 -- time to show the matching bracket (2 tenths of second)
vim.bo.matchpairs = vim.bo.matchpairs .. ",<:>" -- add these for html/xml (not a substitute for matchit.vim, but useful)
-- vim.v.loaded_matchparen = 1 -- don't load matchparen plugin. It throws lots of errors in some cases... (typescript for example)
vim.wo.list = true -- show invisible characters
-- render bar at columns 100-101
vim.wo.colorcolumn = '100,101'
vim.cmd 'highlight ColorColumn ctermbg=lightgrey guibg=#5C5558'

-- undo, swap & backup
vim.o.history = 1000
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir/"
vim.o.undolevels = 1000
