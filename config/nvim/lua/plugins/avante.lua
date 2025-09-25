return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "openrouter",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",
        api_key_name = "OPENAI_API_KEY",
        extra_request_body = {
          temperature = 0.6,
          max_tokens = 8000,
        },
      },
      openrouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1", -- OpenRouter's endpoint
        api_key_name = "OPENROUTER_API_KEY",
        model = "anthropic/claude-sonnet-4",
        extra_request_body = {
          temperature = 0.6,
          max_tokens = 8000,
        },
      },
    },
    -- File selector configuration for fzf-lua
    selector = {
      provider = "fzf_lua", -- Use fzf-lua instead of native selector
      provider_opts = {}, -- Options override for fzf-lua if needed
    },
    -- Mappings for nvim-tree integration
    mappings = {
      files = {
        add_current = "<leader>ac", -- Add current buffer to selected files
        add_all_buffers = "<leader>aB", -- Add all buffer files to selected files
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope (not used in lazyvim. Using fzf below)
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'

    -- Note: blink.cmp integration with avante is configured in lua/plugins/blink-cmp.lua

    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
