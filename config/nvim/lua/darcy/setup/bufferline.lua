local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

require('bufferline').setup{
  --https://github.com/akinsho/bufferline.nvim#configuration
  --options = {
  --},
  diagnostics = 'nvim-lsp'
}
