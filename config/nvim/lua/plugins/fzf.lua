if vim.g.vscode then return {} end

return {
  "ibhagwan/fzf-lua",
  opts = {
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- "nvim-mini/mini.pick" //if using mini icons
    },
    winopts = {
      preview = {
        devicons = true,
      },
    },
  },
}
