-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
---- This file is automatically loaded by lazyvim.config.init

local map = vim.keymap.set
-- map({ "n", "x", "v" }, "<C-n>", "<cmd>Neotree toggle current reveal_force_cwd left<cr>")

if vim.g.vscode then
  local vsc = require("vscode")

  -- File finding (replaces fzf-lua)
  map("n", "<leader>ff", function() vsc.action("workbench.action.quickOpen") end,           { desc = "Find files" })
  map("n", "<leader>fg", function() vsc.action("workbench.action.findInFiles") end,         { desc = "Find in files (grep)" })
  map("n", "<leader>fb", function() vsc.action("workbench.action.showAllEditors") end,      { desc = "Find buffers" })
  map("n", "<leader>fr", function() vsc.action("workbench.action.openRecent") end,          { desc = "Recent files" })

  -- Explorer (replaces neo-tree) — toggles sidebar on/off
  map("n", "<leader>e",  function() vsc.action("workbench.action.toggleSidebarVisibility") end, { desc = "Toggle explorer" })

  -- LSP-like actions (VSCode handles these instead of nvim-lspconfig)
  map("n", "gd",         function() vsc.action("editor.action.revealDefinition") end,       { desc = "Go to definition" })
  map("n", "gr",         function() vsc.action("editor.action.goToReferences") end,         { desc = "Go to references" })
  map("n", "K",          function() vsc.action("editor.action.showHover") end,              { desc = "Hover docs" })
  map("n", "<leader>ca", function() vsc.action("editor.action.quickFix") end,               { desc = "Code action" })
  map("n", "<leader>cr", function() vsc.action("editor.action.rename") end,                 { desc = "Rename symbol" })
  map("n", "]d",         function() vsc.action("editor.action.marker.next") end,            { desc = "Next diagnostic" })
  map("n", "[d",         function() vsc.action("editor.action.marker.prev") end,            { desc = "Prev diagnostic" })
end
