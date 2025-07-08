return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
  },
  opts = function(_, opts)
    -- Ensure we don't override existing configuration
    opts = opts or {}
    opts.sources = opts.sources or {}
    opts.sources.default = opts.sources.default or {}
    opts.sources.providers = opts.sources.providers or {}

    -- Add avante to the default sources list if not already present
    local has_avante = false
    for _, source in ipairs(opts.sources.default) do
      if source == "avante" then
        has_avante = true
        break
      end
    end

    if not has_avante then
      table.insert(opts.sources.default, "avante")
    end

    -- Add avante provider configuration
    opts.sources.providers.avante = {
      module = "blink-cmp-avante",
      name = "Avante",
      -- Only enable in specific filetypes to avoid conflicts
      enabled = function()
        local filetype = vim.bo.filetype
        return filetype == "Avante" or filetype == "markdown" or filetype == "text"
      end,
    }

    return opts
  end,
}
