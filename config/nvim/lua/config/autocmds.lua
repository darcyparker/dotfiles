-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("git"),
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--   end,
-- })

local function markdown_editing_options()
  vim.opt_local.wrap = false
  vim.opt_local.spell = true
  vim.opt_local.textwidth = 0
  vim.opt_local.wrapmargin = 0
  vim.opt_local.formatoptions:remove("t")
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("markdown_editing"),
  pattern = { "markdown", "markdown.mdx" },
  callback = markdown_editing_options,
})

if vim.tbl_contains({ "markdown", "markdown.mdx" }, vim.bo.filetype) then
  markdown_editing_options()
end
