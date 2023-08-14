local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "darcy.lsp.mason"
require("darcy.lsp.lspconfig")

-- require("darcy.lsp.typescript-tools")
require("darcy.lsp.handlers").setup()
--require("darcy.lsp.typescript")
