local typescript_status_ok, typescript = pcall(require, 'typescript')
if not typescript_status_ok then
	return
end

typescript.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  -- server = { -- pass options to lspconfig's setup method
  --   on_attach = ...,
  -- },
})
