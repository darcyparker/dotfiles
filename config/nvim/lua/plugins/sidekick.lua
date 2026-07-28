-- sidekick.nvim runs your AI CLIs (claude/codex/…) in a terminal multiplexer pane.
-- Uses the tmux backend (or a Neovim terminal in plain nvim). The herdr-native backend
-- (sidekick_herdr shim, below) is DISABLED — herdr was trialed and backed out.
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
  {
    -- herdr-native backend: runs sidekick's CLI as a real herdr agent pane. DISABLED — herdr was
    -- trialed and backed out. Kept as WIP: monkeypatches the shim's `_spawn_agent` to herdr 0.7.x's
    -- `pane split` + `agent start --kind --pane` API (sync, race fixed). Set enabled = true to resume.
    "UN-9BOT/sidekick_herdr",
    enabled = false,
    dependencies = { "folke/sidekick.nvim" },
    cond = vim.env.HERDR_ENV == "1",
    config = function()
      require("sidekick_herdr").setup {}

      local Herdr = require("sidekick_herdr")
      local S = require("sidekick_herdr.session")
      function S:_spawn_agent()
        if self.herdr_pane_id and self.herdr_pane_id ~= "" then
          return
        end
        local Util = require("sidekick.util")
        local Config = require("sidekick.config")
        local split = Config.cli.mux.split or {}
        local menv = vim.tbl_extend("force", Herdr.env(), { HERDR = false, HERDR_CONFIG_PATH = false })

        -- 1. Create a herdr pane next to the current (nvim) pane, at a shell prompt, in self.cwd.
        local scmd = {
          "herdr",
          "pane",
          "split",
          "--cwd",
          self.cwd,
          "--direction",
          (split.vertical == false) and "down" or "right",
          "--ratio",
          tostring(split.size or 0.4),
        }
        local src = vim.env.HERDR_PANE_ID
        if src and src ~= "" then
          vim.list_extend(scmd, { "--pane", src })
        else
          scmd[#scmd + 1] = "--current"
        end
        local r1 = vim.system(scmd, { env = menv, text = true }):wait()
        local ok, dec = pcall(vim.json.decode, r1.stdout or "")
        local pane = ok and dec and ((dec.result and dec.result.pane) or dec.pane) or nil
        if r1.code ~= 0 or not (pane and pane.pane_id) then
          Util.error("sidekick_herdr: `herdr pane split` failed: " .. ((r1.stderr or "") .. (r1.stdout or "")))
          return
        end
        self.herdr_pane_id = pane.pane_id
        self.herdr_workspace_id = pane.workspace_id
        self.herdr_tab_id = pane.tab_id
        -- 2. Promote that pane to the agent. SYNCHRONOUS on purpose: sidekick sends the file/
        -- selection context right after start() returns, so the agent must already be up or that
        -- text lands in the shell. herdr's --timeout bounds the wait; it returns as soon as the
        -- agent is detected (usually a few seconds).
        local kind = self.tool.name
        local acmd = { "herdr", "agent", "start", kind, "--kind", kind, "--pane", pane.pane_id, "--timeout", "20000" }
        local r2 = vim.system(acmd, { env = menv, text = true }):wait()
        if r2.code ~= 0 then
          Util.error(
            ("sidekick_herdr: `herdr agent start` failed (code=%d): %s"):format(
              r2.code,
              ((r2.stderr or "") .. (r2.stdout or "")):gsub("%s+", " ")
            )
          )
          return
        end
        self.started = true
      end
    end,
  },
}
