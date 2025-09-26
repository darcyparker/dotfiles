-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      -- Install 'imagemagick' (provides 'magick' or 'convert') for broader image format support
      -- On Ubuntu/Debian: sudo apt install imagemagick
      -- On macOS (Homebrew): brew install imagemagick
    },
    input = {
      override_ui = true, -- To set vim.ui.input to Snacks.input
    },
    picker = {
      override_ui = true, -- To set vim.ui.select to Snacks.picker.select
    },
    -- Note: If you have 'dressing.nvim' or other UI plugins active,
    -- you might need to adjust their configuration to not handle these functions.
  },
}
