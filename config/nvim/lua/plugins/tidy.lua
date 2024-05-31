return {
  "mcauley-penney/tidy.nvim",
  opts = {
    filetype_exclude = { "markdown", "diff" },
  },
  -- stylua: ignore
  keys = {
    { "<leader>te", function() require("tidy").toggle() end, desc = "Toggle trailing whitespace" },
  },
}
