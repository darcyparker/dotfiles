-- Bootstrap Packer.nvim if it doesn't exist
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn

--Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
print(install_path)
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print "Installing packer close and reopen Neovim..."
  vim.api.nvim_command('packadd packer.nvim')
end

-- Autocommand to reload neovim when plugins.lua (this file) is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
-- https://github.com/wbthomason/packer.nvim#using-a-floating-window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- See https://github.com/wbthomason/packer.nvim#specifying-plugins

  use "wbthomason/packer.nvim" -- Let Packer manage itself

  use "svermeulen/vimpeccable"

  use "nvim-lua/popup.nvim" -- Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used in lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Also looked at 'terrortylor/nvim-comment', 'tpope/vim-commentary'

  -- nvim-tree, statusline, bufferline and others require a patched font: https://www.nerdfonts.com/
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua" -- Also see https://github.com/ms-jpq/chadtree
  use "akinsho/nvim-bufferline.lua"
  use "moll/vim-bbye" -- close buffers without closing windows or messing up layout
  use "hoob3rt/lualine.nvim" -- TODO: Compare to https://github.com/Famiu/feline.nvim#why-feline
  use "akinsho/toggleterm.nvim" -- https://github.com/akinsho/toggleterm.nvim
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.
  use "lukas-reineke/indent-blankline.nvim" -- indent guidelines
  use "goolord/alpha-nvim" -- greeter for nvim
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- displays a popup with possible key bindings of the command you started typing

  -- Color themes
  use "tiagovla/tokyodark.nvim" -- dark theme written in lua for neovim 0.5
  use "morhetz/gruvbox"
  use "ishan9299/nvim-solarized-lua" -- solarized for nvim
  use "lunarvim/darkplus.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "jose-elias-alvarez/nvim-lsp-ts-utils" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "TimUntersberger/neogit" -- magit clone for neovim
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"

  -- Color hightlighter (for a hex value)
  use 'norcalli/nvim-colorizer.lua'

  --search (pulses cursor when search completes)
  use 'inside/vim-search-pulse'

  --https://vimeo.com/63116209
  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }

  -- andymoss/vim-match replaces 'vim-scripts/matchit.zip' and 'matchparen'
  use {'andymass/vim-matchup', event = 'VimEnter'}
  --TODO: https://github.com/andymass/vim-matchup#tree-sitter-integration
  --
  --use {
  --  'windwp/nvim-autopairs',
  --  config = function()
  --     require('nvim-autopairs').setup{}
  --  end
  --}

  -- Editor Config https://editorconfig.org/
  use 'editorconfig/editorconfig-vim'

  -- Vim sugar for the UNIX shell commands
  use 'tpope/vim-eunuch'

  use 'tpope/vim-surround' -- compare to blackCauldron7/surround.nvim

  use 'tpope/vim-ragtag'
  use {
    'tpope/vim-unimpaired',
    run = ':helptags unimpaired/doc'
  }
  use 'tpope/vim-repeat'
  use 'tpope/vim-speeddating' -- Ctrl-A and Ctrl-X for dates

  use 'AndrewRadev/splitjoin.vim' -- gS and GJ to split one-liner to multiple lines and vice versa

  -- Text objects
  use 'wellle/targets.vim' -- various text objects

  -- Delete all the buffers except the current, not modified and modifiable buffer. (Port of 'vim-scripts/BufOnly.vim')
  use {'numtostr/BufOnly.nvim', cmd = 'BufOnly' }

  -- Tmux
  use 'tpope/vim-tbone'
  use 'ericpruitt/tmux.vim' --syntax for tmux conf

  -- Neovim motions on speed! (easymotion-like plugin)
  use {
      'phaazon/hop.nvim',
      as = 'hop',
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
  }

  -- -- Plugin to configure formatter by language
  -- -- TODO: configure
  -- use 'mhartington/formatter.nvim'

  -- Profile Startup Time
  use 'dstein64/vim-startuptime'
  -- use 'tweekmonster/startuptime.vim'

  use 'McAuleyPenney/Tidy.nvim'

  -- -- Neovim Completion
  -- use 'hrsh7th/nvim-cmp'
  --      hrsh7th/nvim-compe
  -- https://github.com/ms-jpq/coq_nvim

  -- -- A debug adapter protocol implementation for step-through debugging of your code.
  -- use 'mfussenegger/nvim-dap'

  -- -- Snippets
  -- use 'hrsh7th/vim-vsnip'

  -- TODO: Try these
  -- use { '9mm/vim-closer' }
  -- use {
  --   'w0rp/ale',
  --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'javascript', 'typescript', 'vim'},
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }
  -- -- which-key
  -- use {
  --     'folke/which-key.nvim',
  --     config = function() require('which-key').setup {} end
  -- }

  -- -- For Auto Pairs
  -- use 'steelsojka/pears.nvim'

  -- -- TeleScope
  -- use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }

  -- -- TreeSitter
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'p00f/nvim-ts-rainbow'
  -- use 'nvim-treesitter/nvim-treesitter-refactor'
  -- See https://github.com/andymass/vim-matchup#tree-sitter-integration

  -- -- Neovim LSP
  -- use 'neovim/nvim-lspconfig'
  -- https://github.com/nanotee/nvim-lsp-basics
  -- https://github.com/kabouzeid/nvim-lspinstall
  -- use 'ray-x/lsp_signature.nvim'

  -- -- Lsp based folding
  -- use 'pierreglaser/folding-nvim'

  -- --lsp
  -- use 'onsails/lspkind-nvim' -- pictograms next to lsp choices
  -- use 'simrat39/symbols-outline.nvim' --lsp symbols in tree like view (an outline like tagbar)
  -- use 'glepnir/lspsaga.nvim' -- lsp widgets/helpers
  -- use 'ray-x/lsp_signature.nvim' -- display's function signature while typing (lsp)
  -- use 'kosayoda/nvim-lightbulb' -- lightbulb on lines with lsp codeActions available

  -- Pretty list for showing diagnostics, references, telescope results, quickfix and location lists
  -- use {
  --     'folke/lsp-trouble.nvim',
  --     requires = {'kyazdani42/nvim-web-devicons', opt = true},
  --     config = function() require('trouble').setup {} end
  -- }

  -- use {'windwp/nvim-spectre', opt = false}

  -- -- async render indent guides
  -- use 'glepnir/indent-guides.nvim'
  -- use 'lukas-reineke/indent-blankline.nvim'

  -- use 'p00f/nvim-ts-rainbow'
  -- use 'Konfekt/FastFold'
  -- use 'matze/vim-move'

  -- use 'blackCauldron7/surround.nvim'
  -- use 'RRethy/vim-illuminate'

  -- use 'haya14busa/incsearch.vim'
  -- use 'haya14busa/vim-asterisk'

  -- -- Spell Check
  -- use {
  --     'lewis6991/spellsitter.nvim',
  --     config = function() require('spellsitter').setup() end
  -- }
  --
  -- https://github.com/svermeulen/vim-cutlass
  -- https://github.com/svermeulen/vim-yoink
  -- https://github.com/svermeulen/vim-subversive
  -- https://github.com/svermeulen/vim-easyclip
  -- https://github.com/glts/vim-radical
  --
  -- https://github.com/jpalardy/vim-slime
  --
  -- https://github.com/sotte/presenting.vim
  --
  -- use {'akinsho/toggleterm.nvim'}
  --
  -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
  -- https://github.com/liuchengxu/vista.vim
  -- https://github.com/simrat39/symbols-outline.nvim
  -- https://github.com/stevearc/aerial.nvim
  --
  -- Language Packs
  -- https://github.com/sheerun/vim-polyglot
  --
  -- https://github.com/alec-gibson/nvim-tetris

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
