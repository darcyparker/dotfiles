-- Seamless Ctrl-h/j/k/l movement + Alt-h/j/k/l resize between Neovim splits and tmux panes
-- (and plain-nvim windows) — the vim-tmux-navigator-style bridge. Pairs with the smart-splits
-- block in tmux.conf. Must NOT be lazy-loaded: it sets the tmux @pane-is-vim option on startup.
return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    at_edge = "wrap",
    default_amount = 3,
    -- Don't trap the nav keys inside LazyVim sidebars.
    ignored_filetypes = { "neo-tree", "NvimTree", "snacks_layout_box" },
  },
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, mode = { "n", "t" }, desc = "Go to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, mode = { "n", "t" }, desc = "Go to below split" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, mode = { "n", "t" }, desc = "Go to above split" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, mode = { "n", "t" }, desc = "Go to right split" },
    { "<A-h>", function() require("smart-splits").resize_left() end, mode = { "n", "t" }, desc = "Resize split left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, mode = { "n", "t" }, desc = "Resize split down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, mode = { "n", "t" }, desc = "Resize split up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, mode = { "n", "t" }, desc = "Resize split right" },
  },
}
