return {
  "maxmx03/solarized.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme("solarized")

    -- When nvim starts, this block makes all common UI columns on the left transparent.
    -- This fixes the vertical stripe on the dashboard.
    local highlights = {
      "SignColumn",
      "NumberColumn",
      "FoldColumn",
    }

    for _, group in ipairs(highlights) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
}
