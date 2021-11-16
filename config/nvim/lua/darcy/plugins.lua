-- Bootstrap Packer.nvim if it doesn't exist
-- https://github.com/wbthomason/packer.nvim#bootstrapping
-- local execute = vim.api.nvim_command
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]) --when plugins.lua (this file) changes, PackerCompile

return require('packer').startup({
  function(use)
        -- See https://github.com/wbthomason/packer.nvim#specifying-plugins

        -- Let Packer manage itself
        use 'wbthomason/packer.nvim'

        use 'svermeulen/vimpeccable'
        -- use 'tjdevries/astronauta.nvim' --Is this needed? for lua ftplugins anymore?

        -- Color themes
        use 'tiagovla/tokyodark.nvim' -- dark theme written in lua for neovim 0.5
        use 'morhetz/gruvbox'
        use 'ishan9299/nvim-solarized-lua' -- solarized for nvim
        --use 'altercation/vim-colors-solarized' -- solarized for vim (doesn't work well in nvim

        -- nvim-tree, statusline, bufferline and others require a patched font: https://www.nerdfonts.com/

        --https://github.com/yamatsum/nvim-nonicons (configurations for nvim-webicons)

        -- statusline
        use {'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = function()
              require('lualine').setup {
                -- https://github.com/hoob3rt/lualine.nvim#usage-and-customization
                options = {
                  theme = 'solarized',
                  icons_enabled = false
                },
                extensions = {
                  'nvim-tree',
                  'quickfix'
                },
                sections = {
                  lualine_a = {'mode'}, --vim mode
                  lualine_b = {'branch', 'diff'}, --git branch and diff status
                  lualine_c = {{'diagnostics', sources = {'nvim_lsp'}}, {'filename'}},
                  lualine_x = {'encoding', 'fileformat', 'filetype'},
                  lualine_y = {'progress'},
                  lualine_z = {'location'}
                }
              }
            end
        }
        -- Bufferline
        use {'akinsho/nvim-bufferline.lua',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = function()
              require('bufferline').setup{
                --https://github.com/akinsho/bufferline.nvim#configuration
                --options = {
                --},
                diagnostics = 'nvim-lsp'
              }
            end
        }

        -- Nvim Tree
        use {
          'kyazdani42/nvim-tree.lua',
          requires = {'kyazdani42/nvim-web-devicons', opt = true},
          config = function()
            local g = vim.g
            g.nvim_tree_git_hl = 1 -- file highlight for git attributes
            g.nvim_tree_indent_markers = 1 -- indent markers when folders are open

            -- https://github.com/kyazdani42/nvim-tree.lua#setup
            require'nvim-tree'.setup {
              auto_close = true, -- closes the tree when it's the last window
              update_focused_file = {
                enable = true, -- show selected file on open
              },
              filters = {
                dotfiles = true, -- hide dotfiles by default
                custom = {
                  '.DS_Store',
                  '.cache',
                  '.git',
                  'fugitive:',
                }
              },
              update_cwd = true,
              view = {
                auto_resize = true -- resize the tree to it's saved width when opening a new file
              },
            }
           end
        }
        -- Also see https://github.com/ms-jpq/chadtree

        -- Git Signs
        use { 'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function()
              require('gitsigns').setup {
                signs = {
                  add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                  change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                  delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                  topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                  changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                },
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                --keymaps = {
                --  -- Default keymap options
                --  noremap = true,

                --  ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
                --  ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

                --  ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
                --  ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                --  ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
                --  ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
                --  ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
                --  ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
                --  ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                --  ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
                --  ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
                --  ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

                --  -- Text objects
                --  ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
                --  ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
                --},
                watch_index = {
                  interval = 1000,
                  follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                  virt_text = true,
                  virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                  delay = 1000,
                },
                current_line_blame_formatter_opts = {
                  relative_time = false
                },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                  -- Options passed to nvim_open_win
                  border = 'single',
                  style = 'minimal',
                  relative = 'cursor',
                  row = 0,
                  col = 1
                },
                use_internal_diff = true,  -- If vim.diff or luajit is present
                yadm = {
                  enable = false
                },
              }
            end
        }

        -- Color hightlighter (for a hex value)
        use 'norcalli/nvim-colorizer.lua'

        --search
        use 'inside/vim-search-pulse'

        use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

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

        -- Comments
        use 'terrortylor/nvim-comment' -- like 'tpope/vim-commentary' but in lua

        -- Editor Config https://editorconfig.org/
        use 'editorconfig/editorconfig-vim'

        use 'tpope/vim-eunuch'

        use 'tpope/vim-surround'

        use 'tpope/vim-ragtag'
        use {'tpope/vim-unimpaired', run = ':helptags unimpaired/doc'}
        use 'tpope/vim-repeat'
        use 'tpope/vim-speeddating'

        use 'AndrewRadev/splitjoin.vim'

        -- Text objects
        use 'wellle/targets.vim' -- various text objects

        -- Delete all the buffers except the current, not modified and modifiable buffer. (Port of 'vim-scripts/BufOnly.vim')
        use {'numtostr/BufOnly.nvim', cmd = 'BufOnly' }

        -- Git
        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' } --magit clone for neovim
        use 'tpope/vim-fugitive'
        use 'tpope/vim-rhubarb'

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

    end,
    -- -- config: https://github.com/wbthomason/packer.nvim#custom-initialization
    -- -- https://github.com/wbthomason/packer.nvim#using-a-floating-window
    config = {
      display = {open_fn = require('packer.util').float}
    }
})
