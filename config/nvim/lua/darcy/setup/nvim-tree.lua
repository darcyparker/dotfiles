
-- https://github.com/kyazdani42/nvim-tree.lua#setup
require("nvim-tree").setup {
  -- auto_close = true, -- closes the tree when it's the last window
  update_focused_file = {
    enable = true, -- show selected file on open
  },
  filters = {
    dotfiles = true, -- hide dotfiles by default
    custom = {
      ".DS_Store",
      ".cache",
      ".git",
      "fugitive:",
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    highlight_git = true,
  },
  update_cwd = true,
  actions = {
    open_file = {
      resize_window = true,
    },
  },
}
