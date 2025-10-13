return {
  "folke/sidekick.nvim",
  opts = {
    term = {
      -- Terminal application to use.
      -- One of: "toggleterm", "floaterm", "tab", "vsplit", "hsplit"
      -- Or a function that returns the terminal instance.
      -- Or a command string like "tmux new-window"
      app = "tmux new-window -n sidekick",
      -- app = "zellij action new-pane --name sidekick",
    },
    cli = {
      -- Gemini CLI
      gemini = {
        cmd = "gemini",
        -- https://github.com/google/generative-ai-go/blob/main/genai/generativetools/cmd/genai/main.go
        args = { "chat" },
      },
      -- Claude CLI
      claude = {
        cmd = "claude",
        args = { "chat" },
      },
      -- Codex CLI
      codex = {
        cmd = "codex",
        args = { "chat" },
      },
      -- Cursor agent
      cursor = {
        cmd = "cursor",
        args = { "--prompt" },
      },
    },
    -- Default CLI to use (you can change this to your preferred one)
    default = "cursor",
    -- Enable/disable inline edit suggestions
    inline = true,
    -- Keymaps
    keys = {
      -- Open sidekick chat
      { "<leader>as", "<cmd>Sidekick<cr>", desc = "Sidekick: Open Chat" },
      -- Send selection to sidekick
      { "<leader>aa", mode = { "n", "v" }, "<cmd>SidekickSend<cr>", desc = "Sidekick: Send Selection" },
      -- Ask sidekick about current buffer
      { "<leader>ab", "<cmd>SidekickBuffer<cr>", desc = "Sidekick: Ask About Buffer" },
      -- Toggle inline suggestions
      { "<leader>at", "<cmd>SidekickToggle<cr>", desc = "Sidekick: Toggle Inline" },
      -- Apply current suggestion
      {
        "<leader>ay",
        function()
          require("sidekick").apply()
        end,
        desc = "Sidekick: Apply Suggestion",
      },
      -- Reject current suggestion
      {
        "<leader>an",
        function()
          require("sidekick").reject()
        end,
        desc = "Sidekick: Reject Suggestion",
      },
      -- Jump to next/previous edit suggestion
      {
        "<leader>aj",
        function()
          require("sidekick").jump_next()
        end,
        desc = "Sidekick: Next Suggestion",
      },
      {
        "<leader>ak",
        function()
          require("sidekick").jump_prev()
        end,
        desc = "Sidekick: Prev Suggestion",
      },
    },
  },
}
