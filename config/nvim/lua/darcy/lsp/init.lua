local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "darcy.lsp.lsp-installer"
require("darcy.lsp.handlers").setup()
require "darcy.lsp.null-ls"