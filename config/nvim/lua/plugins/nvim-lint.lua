return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      cmake = { "cmakelint" },
      dockerfile = { "hadolint" },
      -- markdown = { "markdownlint" },
      typescript = { "eslint" },
    },
  },
}
