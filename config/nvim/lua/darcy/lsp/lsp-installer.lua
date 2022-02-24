local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- Install these servers
local servers = {
  "bashls",
  "cssls",
  "cssmodules_ls",
  "eslint",
  "html",
  "jsonls",
  "pyright",
  -- "remark_ls", -- disabled
  "sumneko_lua",
  "tsserver",
  "yamlls",
}
for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("darcy.lsp.handlers").on_attach,
    capabilities = require("darcy.lsp.handlers").capabilities,
  }

  if server.name == "jsonls" then
    local jsonls_opts = require("darcy.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("darcy.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "tsserver" then
    local tsserver_opts = require("darcy.lsp.settings.tsserver")
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
