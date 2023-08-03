local util = require "lspconfig.util"
local function get_typescript_server_path(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)
  return project_root and (util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or '/Users/darcyparker/.nvm/versions/node/v18.16.1/lib/node_modules/typescript/lib' -- `npm root -g`
end
return {
  settings = {
  },
  root_dir = function(fname)
    local dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname);
    vim.notify('setting root_dir ' .. dir);
    return dir
  end,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    -- if vim.tbl_get(new_config.init_options, 'typescript') and not new_config.init_options.typescript.tsdk then
    --   new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    -- end
    vim.notify('updating tsserver ' .. new_config.init_options.typescript.tsdk)
  end,
}
