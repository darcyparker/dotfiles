local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {

		formatting.black.with({ extra_args = { "--fast" } }),
    -- diagnostics.flake8

    diagnostics.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),

	  code_actions.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),

		formatting.prettier.with({
		  prefer_local = "node_modules/.bin",
		  extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),

    -- json
    diagnostics.jsonlint,
    formatting.fixjson,

	  -- shell scripts (bash)
	  diagnostics.shellcheck,
	  code_actions.shellcheck,

	  -- lua
		formatting.stylua,
	  diagnostics.selene,

	  -- git
	  code_actions.gitrebase,
	  code_actions.gitsigns,

	  -- diagnostics.gitlint, -- consider?

	  --markdown
	  --[[ diagnostics.proselint, ]]
	  --[[ code_actions.proselint, ]]

	  -- consider
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/code_actions/refactoring.lua
	  --   - See https://github.com/ThePrimeagen/refactoring.nvim
	  -- - https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/completion/vsnip.lua

	},
})
