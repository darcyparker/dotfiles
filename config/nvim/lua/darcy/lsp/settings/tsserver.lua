--After setting up mason-lspconfig, load servers via lspconfig
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

return {
  root_dir = function(fname)
    local dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname);
    vim.notify('setting root_dir ' .. dir);
    return dir
  end,
}
