return {
  "neovim/nvim-lspconfig",
  -- dependencies = {
  --   "jose-elias-alvarez/typescript.nvim",
  --   init = function()
  --     require("lazyvim.util").lsp.on_attach(function(_, buffer)
  --       -- stylua: ignore
  --       vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
  --       vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
  --     end)
  --   end,
  -- },
  opts = {
    -- make sure mason installs the server
    servers = {

      clangd = {
        keys = {
          { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },

      neocmake = {}, -- cmake

      dockerls = {},
      docker_compose_language_service = {},

      -- eslint = {
      --   settings = {
      --     -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
      --     workingDirectory = { mode = "auto" },
      --   },
      -- },

      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },

      gopls = {
        keys = {
          -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
          { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
        },
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      },

      --python
      pyright = {},

      --python
      ruff_lsp = {
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

      --markdown
      marksman = {},

      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { "source.organizeImports.ts" },
                  diagnostics = {},
                },
              }
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              }
            end,
            desc = "Remove Unused Imports",
          },
        },
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          completions = {
            completeFunctionCalls = true,
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

        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
            },
            validate = true,
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
          },
        },
      },
    },
    setup = {
      clangd = function(_, opts)
        local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        return false
      end,

      -- eslint = function()
      --   local function get_client(buf)
      --     return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
      --   end
      --
      --   local formatter = require("lazyvim.util").lsp.formatter {
      --     name = "eslint: lsp",
      --     primary = false,
      --     priority = 200,
      --     filter = "eslint",
      --   }
      --
      --   -- Use EslintFixAll on Neovim < 0.10.0
      --   if not pcall(require, "vim.lsp._dynamic") then
      --     formatter.name = "eslint: EslintFixAll"
      --     formatter.sources = function(buf)
      --       local client = get_client(buf)
      --       return client and { "eslint" } or {}
      --     end
      --     formatter.format = function(buf)
      --       local client = get_client(buf)
      --       if client then
      --         local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
      --         if #diag > 0 then
      --           vim.cmd("EslintFixAll")
      --         end
      --       end
      --     end
      --   end
      --
      --   -- register the formatter with LazyVim
      --   require("lazyvim.util").format.register(formatter)
      -- end,

      gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        require("lazyvim.util").lsp.on_attach(function(client, _)
          if client.name == "gopls" then
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end
        end)
        -- end workaround
      end,

      ruff_lsp = function()
        require("lazyvim.util").lsp.on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,

      yamlls = function()
        -- Neovim < 0.10 does not have dynamic registration for formatting
        if vim.fn.has("nvim-0.10") == 0 then
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "yamlls" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end
      end,
    },
  },
}
