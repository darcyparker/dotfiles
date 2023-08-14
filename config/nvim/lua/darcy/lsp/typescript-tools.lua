local typescript_tools_status_ok, typescript_tools = pcall(require, 'typescript-tools')
if not typescript_tools_status_ok then
	return
end

-- local api = typescript_tools.api

typescript_tools.setup {
  on_attach = require('darcy.lsp.handlers').on_attach,
  -- function(client, bufnr)
  --   require('darcy.lsp.handlers').on_attach(client, bufnr);
  -- end,
  on_init = function(client)
    -- disable; prettier_d is used for formatting
    client.server_capabilities.documentFormattingProvider = false
  end,
  handlers = {
    -- ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
    --   -- Ignore 'This may be converted to an async function' diagnostics.
    --   { 80006 }
    -- ),
  },
  capabilities = require('darcy.lsp.handlers').capabilities,
  settings = {
    expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
    tsserver_plugins = { '@styled/typescript-styled-plugin' },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = 'all',
      includeCompletionsForModuleExports = true,
      quotePreference = 'auto',
    },
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    -- complete_function_calls = false,
  },
}
