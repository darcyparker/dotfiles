return {
  "neovim/nvim-lspconfig",
  ---@module 'lspconfig'
  opts = {
    inlay_hints = { enabled = false },
    servers = {

      --python
      pyright = {},

      --python - using ruff (the modern replacement for ruff_lsp)
      ruff = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              }
            end,
            desc = "Organize Imports",
          },
        },
      },

      yamlls = {
        -- Have to add this for yamlls to understand that we support line folding
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
        end,
      },

      vtsls = {
        -- Let vtsls use its default root detection (looks for tsconfig.json, package.json, etc.)
        -- This ensures proper cross-file navigation and project understanding

        -- Settings to prevent TypeScript server crashes (commented out to enable auto-imports)
        -- Note: includePackageJsonAutoImports provides helpful auto-completion from package.json
        -- but can cause "Bad line number" crashes in some cases. If you experience vtsls crashes,
        -- uncomment these settings to disable the feature.
        -- settings = {
        --   typescript = {
        --     preferences = {
        --       includePackageJsonAutoImports = "off",
        --     },
        --   },
        --   javascript = {
        --     preferences = {
        --       includePackageJsonAutoImports = "off",
        --     },
        --   },
        -- },
      },
    },
  },
}
