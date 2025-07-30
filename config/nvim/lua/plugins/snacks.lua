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
    -- To have Snacks handle vim.ui.input and vim.ui.select,
    -- you need to ensure it's loaded appropriately and potentially
    -- disable/reconfigure other plugins that might be overriding these,
    -- like 'dressing.nvim' for select.
    -- For simplicity, if you want Snacks to take over, you might set these directly
    -- or ensure Snacks is loaded after/configured to take precedence.
    -- LazyVim might manage some UI overrides, so be mindful of conflicts.
    -- A common approach is to set these in your main config or in the Snacks opts.
    -- For example:
    -- input = {
    --   override_ui = true, -- To set vim.ui.input to Snacks.input
    -- },
    -- picker = {
    --   override_ui = true, -- To set vim.ui.select to Snacks.picker.select
    -- },
    -- Keep this if you want to explicitly use Snacks for UI components.
    -- However, be aware that if 'dressing.nvim' is also active for these,
    -- you might need to adjust dressing's configuration to not handle them.
  },
}
