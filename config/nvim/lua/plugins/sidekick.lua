return {
  "folke/sidekick.nvim",
  ---@module 'sidekick'
  ---@type sidekick.Config
  opts = {
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
        create = "split",
        split = {
          vertical = true, -- side-by-side pane (false = top/bottom)
          size = 0.4, -- 0-1, fraction of the current pane
        },
      },
      tools = {
        kilo = {
          cmd = { "kilo" },
          url = "https://github.com/Kilo-Org/kilocode",
        },
      },
    },
  },
  config = function(_, opts)
    require("sidekick").setup(opts)
    -- disble cursor cli
    require("sidekick.config").cli.tools.cursor = nil
  end,
}
