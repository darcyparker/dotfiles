-- lua/plugins/render-markdown.lua
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Disable LaTeX support as you don't use it
    -- latex = {
    --   enabled = false,
    -- },
  },
}
