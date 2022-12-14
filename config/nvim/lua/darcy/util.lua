local M = {}

-- Unload a lua namespace
-- Example: `require('darcy.config')` loads a lua script. and `unload_lua_namespace('darcy.config')` unloads/removes it.
M['unload_lua_namespace'] = function(prefix)
  local prefix_with_dot = prefix .. '.'
  for key, value in pairs(package.loaded) do
    if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
      package.loaded[key] = nil
    end
  end
end

return M
