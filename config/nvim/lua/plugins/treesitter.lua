return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "bash",
      "c",
      "cmake",
      "cpp",
      "dockerfile",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "ninja",
      "python",
      "query",
      "regex",
      "rst",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    })

    -- vim.list_extend(opts.ignore_install, {
    -- })
  end,
}
