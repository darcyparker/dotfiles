return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
        vim.list_extend(opts.ensure_installed, { "delve" })
      end,
    },
    {
      "leoluz/nvim-dap-go",
      config = true,
    },
  },
  opts = function()
    local dap = require("dap")

    if not dap.adapters["codelldb"] then
      require("dap").adapters["codelldb"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {
            "--port",
            "${port}",
          },
        },
      }
    end
    for _, lang in ipairs { "c", "cpp" } do
      dap.configurations[lang] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end
    for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end
  end,
}
