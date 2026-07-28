-- herdr <-> Neovim seamless nav/resize. DISABLED: herdr was trialed and backed out.
-- Kept as WIP — set enabled = true to resume (smart-splits.nvim handles tmux/plain nvim).
local splits_dir = vim.fn.expand("~/src/dotfiles/submodules/herdr-splits.nvim")
return {
  "lmilojevicc/herdr-splits.nvim",
  enabled = false,
  dir = splits_dir,
  cond = vim.env.HERDR_ENV == "1" and vim.fn.isdirectory(splits_dir) == 1,
  event = "VeryLazy",
  opts = {
    at_edge = "wrap",
    nav_at_edge = "wrap",
    default_amount = 0.03, -- herdr pane resize step (fraction of split)
    neovim_amount = 3, -- nvim window resize step (cells)
    unzoom_on_nav = true,
  },
  keys = {
    { "<C-h>", function() require("herdr-splits").move_cursor_left() end, mode = { "n", "t" }, desc = "Go to left split" },
    { "<C-j>", function() require("herdr-splits").move_cursor_down() end, mode = { "n", "t" }, desc = "Go to below split" },
    { "<C-k>", function() require("herdr-splits").move_cursor_up() end, mode = { "n", "t" }, desc = "Go to above split" },
    { "<C-l>", function() require("herdr-splits").move_cursor_right() end, mode = { "n", "t" }, desc = "Go to right split" },
    { "<M-h>", function() require("herdr-splits").resize_left() end, mode = { "n", "t" }, desc = "Resize split left" },
    { "<M-j>", function() require("herdr-splits").resize_down() end, mode = { "n", "t" }, desc = "Resize split down" },
    { "<M-k>", function() require("herdr-splits").resize_up() end, mode = { "n", "t" }, desc = "Resize split up" },
    { "<M-l>", function() require("herdr-splits").resize_right() end, mode = { "n", "t" }, desc = "Resize split right" },
  },
}
