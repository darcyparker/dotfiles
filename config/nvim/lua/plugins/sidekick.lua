-- sidekick.nvim runs your AI CLIs (claude/codex/…) in a tmux pane (or a Neovim terminal
-- in plain nvim), with CLI keymaps under the "," leader.
return {
  {
    "folke/sidekick.nvim",
    ---@module 'sidekick'
    ---@type sidekick.Config
    opts = {
      cli = {
        mux = {
          backend = "tmux",
          enabled = true, -- REQUIRED: without this the configured backend is ignored (falls back to terminal)
          create = "split",
          split = {
            vertical = true, -- side-by-side pane (false = top/bottom)
            size = 0.4, -- 0-1, fraction of the current pane
          },
        },
        tools = {
          -- kilo = {
          --   cmd = { "kilo" },
          --   url = "https://github.com/Kilo-Org/kilocode",
          -- },
        },
      },
    },
    config = function(_, opts)
      require("sidekick").setup(opts)
      -- disble cursor cli
      require("sidekick.config").cli.tools.cursor = nil

      -- Only reuse tmux panes that sidekick ITSELF spawned, so opening a CLI (e.g. `,ac`) never
      -- hijacks a standalone claude (like a separate Claude Code session) that merely shares the
      -- cwd. sidekick's tmux discovery is server-wide + keyed on tool+cwd, so without this it
      -- grabs any matching claude in any window. Fix: tag sidekick's panes with a @sidekick tmux
      -- pane-option on spawn, and filter discovery to tagged panes (so it spawns a fresh split
      -- unless a prior *sidekick* claude for this cwd is still alive).
      local ok_tmux, Tmux = pcall(require, "sidekick.cli.session.tmux")
      if ok_tmux and Tmux and not Tmux._sidekick_own_only then
        Tmux._sidekick_own_only = true
        local _spawn = Tmux.spawn
        function Tmux:spawn(cmd)
          _spawn(self, cmd)
          local creating = vim.tbl_contains(cmd, "split-window") or vim.tbl_contains(cmd, "new-window")
          if creating and self.tmux_pane_id then
            pcall(function()
              vim.system({ "tmux", "set-option", "-p", "-t", self.tmux_pane_id, "@sidekick", "1" }):wait()
            end)
          end
        end
        local _sessions = Tmux.sessions
        function Tmux.sessions()
          local all = _sessions() or {}
          local tagged = {} ---@type table<string, boolean>
          local out = vim.system({ "tmux", "list-panes", "-a", "-F", "#{pane_id} #{@sidekick}" }):wait()
          for line in (out.stdout or ""):gmatch("[^\n]+") do
            local pid, mark = line:match("^(%%%d+)%s+(%S*)")
            if pid and mark == "1" then
              tagged[pid] = true
            end
          end
          return vim.tbl_filter(function(s)
            return s.tmux_pane_id and tagged[s.tmux_pane_id]
          end, all)
        end
      end
    end,
    -- CLI keymaps (leader = ","). Opening a tool spawns/attaches it in a tmux pane (sidekick's own).
    keys = {
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Sidekick Focus",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Sidekick Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Sidekick Detach CLI",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send { msg = "{this}" }
        end,
        mode = { "x", "n" },
        desc = "Sidekick Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send { msg = "{file}" }
        end,
        desc = "Sidekick Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send { msg = "{selection}" }
        end,
        mode = { "x" },
        desc = "Sidekick Send Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle { name = "claude", focus = true }
        end,
        desc = "Sidekick Claude",
      },
      {
        "<leader>ax",
        function()
          require("sidekick.cli").toggle { name = "codex", focus = true }
        end,
        desc = "Sidekick Codex",
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").toggle { name = "gemini", focus = true }
        end,
        desc = "Sidekick Gemini",
      },
    },
  },
}
