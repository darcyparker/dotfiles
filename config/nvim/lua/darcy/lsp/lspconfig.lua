--After setting up mason-lspconfig, load servers via lspconfig
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- Using mason...

-- lspconfig.jsonls.setup(vim.tbl_deep_extend( 'force', require('darcy.lsp.settings.jsonls'), {
--   on_attach = require('darcy.lsp.handlers').on_attach,
--   capabilities = require('darcy.lsp.handlers').capabilities,
-- }));
-- lspconfig.pyright.setup(vim.tbl_deep_extend( 'force', require('darcy.lsp.settings.pyright'), {
--   on_attach = require('darcy.lsp.handlers').on_attach,
--   capabilities = require('darcy.lsp.handlers').capabilities,
-- }));
-- lspconfig.lua_ls.setup(vim.tbl_deep_extend( 'force', require('darcy.lsp.settings.lua_ls'), {
--   on_attach = require('darcy.lsp.handlers').on_attach,
--   capabilities = require('darcy.lsp.handlers').capabilities,
-- }));
-- lspconfig.tsserver.setup();
