return {
  "jszakmeister/vim-togglecursor",
  config = function()
    -- This plugin automatically saves the cursor shape on startup and
    -- restores it on exit. No extra configuration is needed for that.

    -- However, you can set a specific shape to restore to.
    -- 6 = steady vertical bar/line
    -- 5 = blinking vertical bar/line
    vim.g.togglecursor_default_shape = 6
  end,
}
