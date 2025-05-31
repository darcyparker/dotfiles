return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      glsl = { "clang_format" },
    },
    formatters = {
      clang_format = {
        -- Ensure it uses your .clang-format file
        args = { "--style=file", "--fallback-style=LLVM" },
      },
    },
  },
}
