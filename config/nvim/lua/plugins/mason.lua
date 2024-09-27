return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = {}
    -- opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "cmakelang", --cmake
      "cmakelint", --cmake
      "codelldb", -- clangd
      "delve", --go-lang
      "gofumpt", --go-lang
      "goimports", --go-lang
      "gomodifytags", --go-lang
      "hadolint", -- docker
      "impl", --go-lang
      -- "js-debug-adapter",
      -- "markdownlint", --markdown
      -- "marksman", --markdown
      "vtsls", --typescript
    })
  end,
}
