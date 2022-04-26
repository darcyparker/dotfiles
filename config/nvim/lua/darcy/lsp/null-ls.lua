local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

null_ls.setup({
	debug = false,
	sources = {
		null_ls.builtins.formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
		null_ls.builtins.formatting.stylua,

    -- diagnostics.flake8
	  null_ls.builtins.diagnostics.eslint_d,
	  null_ls.builtins.code_actions.eslint_d,

    null_ls.builtins.diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
	},
})
