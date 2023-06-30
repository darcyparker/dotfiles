local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {

		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    -- diagnostics.flake8

    null_ls.builtins.diagnostics.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),

	  null_ls.builtins.code_actions.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),

		formatting.prettier.with({ 
		  prefer_local = "node_modules/.bin",
		  extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),

    -- json
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.formatting.fixjson,

	  -- shell scripts (bash)
	  null_ls.builtins.diagnostics.shellcheck,
	  null_ls.builtins.code_actions.shellcheck,

	  -- lua
		-- null_ls.builtins.formatting.stylua,
	  -- null_ls.builtins.diagnostics.selene,

	  -- git
	  null_ls.builtins.code_actions.gitrebase,
	  null_ls.builtins.code_actions.gitsigns,

	  -- null_ls.builtins.diagnostics.gitlint, -- consider?

	  --markdown
	  --[[ null_ls.builtins.diagnostics.proselint, ]]
	  --[[ null_ls.builtins.code_actions.proselint, ]]

	  -- consider
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/code_actions/refactoring.lua
	  --   - See https://github.com/ThePrimeagen/refactoring.nvim
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/completion/vsnip.lua

	},
})
