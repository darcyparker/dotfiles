local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

null_ls.setup({
	debug = false,
	sources = {

		-- python
		null_ls.builtins.formatting.black.with({
		  extra_args = { "--fast" }
		}),
    -- diagnostics.flake8

		-- prettier (js, ts, etc)
		null_ls.builtins.formatting.prettier.with({
		  prefer_local = "node_modules/.bin",
		  extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),

    -- eslint (javscript, typescript, ...)
    null_ls.builtins.diagnostics.eslint_d,
	  null_ls.builtins.code_actions.eslint_d,
	  -- null_ls.builtins.formatting.eslint_d, --use prettier

	  -- xo
	  null_ls.builtins.diagnostics.xo.with({
      prefer_local = "node_modules/.bin",
	  }),
	  null_ls.builtins.code_actions.xo.with({
      prefer_local = "node_modules/.bin",
	  }),

    -- json
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.formatting.fixjson,

	  -- shell scripts (bash)
	  null_ls.builtins.diagnostics.shellcheck,
	  null_ls.builtins.code_actions.shellcheck,

	  -- lua
		null_ls.builtins.formatting.stylua,
	  null_ls.builtins.diagnostics.selene,

	  -- git
	  null_ls.builtins.code_actions.gitrebase,
	  null_ls.builtins.code_actions.gitsigns,
	  -- null_ls.builtins.diagnostics.gitlint, -- consider?

	  --markdown
	  null_ls.builtins.diagnostics.proselint,
	  null_ls.builtins.code_actions.proselint,

	  -- consider
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/code_actions/refactoring.lua
	  --   - See https://github.com/ThePrimeagen/refactoring.nvim
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/completion/vsnip.lua

	},
})
