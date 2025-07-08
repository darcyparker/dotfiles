return {
  -- formatter plugin
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      glsl = { "clang_format" },

      -- prettier
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      handlebars = { "prettier" },
    },
    formattters = {
      clang_format = {
        -- Ensure it uses your .clang-format file
        args = { "--style=file", "--fallback-style=LLVM" },
      },
      prettier = {
        -- Use the project's prettier configuration
        args = { "--stdin-filepath", "$FILENAME" },
        cwd = require("conform.util").root_file {
          ".prettierrc",
          ".prettierrc.json",
          ".prettierrc.yml",
          ".prettierrc.yaml",
          ".prettierrc.js",
          ".prettierrc.mjs",
          ".prettierrc.cjs",
          "prettier.config.js",
          "prettier.config.mjs",
          "prettier.config.cjs",
          "package.json",
        },
      },
      stylua = {
        args = { "--stdin-filepath", "$FILENAME", "-" },
      },
    },
  },
}
