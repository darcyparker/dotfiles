local servers = {
	'lua_ls',
	'cssls',
	'html',
	'pyright',
	'bashls',
	'jsonls',
  'yamlls',
  'tsserver',

  --'rome',
	--'vtsls',
	--'tsserver', -- trying vtsls instead
  --'cssmodules_ls',
  -- 'remark_ls', -- disabled
	--'sumneko_lua', --deprecated
}

local settings = {
	ui = {
		border = 'none',
		icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

-- Order matters
require('mason').setup(settings)
require('mason-lspconfig').setup({
	ensure_installed = servers,
	automatic_installation = true,
})

--After setting up mason-lspconfig, load servers via lspconfig
local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
	return
end

require('mason-lspconfig').setup_handlers({
  function(server)
    local opts = {}
    local require_ok, conf_opts = pcall(require, 'darcy.lsp.settings.' .. server)
    if require_ok then
      opts = vim.tbl_deep_extend(
        'force',
        conf_opts,
        {
          on_attach = require('darcy.lsp.handlers').on_attach,
          capabilities = require('darcy.lsp.handlers').capabilities,
        }
      )
    end

    lspconfig[server].setup(opts)
  end,
})

require('mason-update-all').setup()

vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonUpdateAllComplete',
  callback = function()
    print('mason-update-all has finished')
  end,
})

require('mason-nvim-dap').setup()

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {

    -- you can pin a tool to a particular version
    { 'golangci-lint', version = 'v1.47.0' },

    -- you can turn off/on auto_update per tool
    { 'bash-language-server', auto_update = true },

    'lua-language-server',
    'vim-language-server',
    'gopls',
    'stylua',
    'shellcheck',
    'editorconfig-checker',
    'gofumpt',
    'golines',
    'gomodifytags',
    'gotests',
    'impl',
    'json-to-struct',
    'luacheck',
    'misspell',
    'revive',
    'shellcheck',
    'shfmt',
    'staticcheck',
    'vint',
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay

  -- Only attempt to install if 'debounce_hours' number of hours has
  -- elapsed since the last time Neovim was started. This stores a
  -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
  -- This is only relevant when you are using 'run_on_start'. It has no
  -- effect when running manually via ':MasonToolsInstall' etc....
  -- Default: nil
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsStartingInstall',
  callback = function()
    vim.schedule(function()
      print 'mason-tool-installer is starting'
    end)
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function(e)
    vim.schedule(function()
      print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
    end)
  end,
})
