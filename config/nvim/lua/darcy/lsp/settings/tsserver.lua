local util = require "lspconfig.util"

local function get_typescript_server_path(root_dir)
  -- Alternative location if installed as root:
  local global_ts = '/Users/darcyparker/.nvm/versions/node/v18.16.1/lib/node_modules' -- `npm root -g`
  local found_ts = ''
  local function check_dir(path)
    found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end

  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

return {
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
  settings = {
    -- rootdir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    -- root_dir = util.root_pattern("package.json"),
    root_dir = '/Users/darcyparker/src/paperless/frontend',
    --See https://github.com/typescript-language-server/typescript-language-server
    completions = {
      completeFunctionCalls = true
    },
    --See https://github.com/typescript-language-server/typescript-language-server#initializationoptions
    init_options = {
      typescript = {
        tsdk = '/Users/darcyparker/src/paperless/frontend'
      },
      preferences = {
        -- importModuleSpecifierPreference = "relative"
        -- implicitProjectConfiguration = {
        --   target = "2020"
        -- }
      }
    }
  },
}
