local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "darcy.lsp.mason"
-- require "darcy.lsp.typescript"
require("darcy.lsp.handlers").setup()

--TODO find replacement for null-ls
--require("mason-null-ls").setup({
--  ensure_installed = {
--    "stylua",
--    "jq",
--    "eslint_d",
--    "prettierd"
--  }
--})
-- require "darcy.lsp.null-ls"
