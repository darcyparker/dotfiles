return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = {
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
  },
  opts = {
    adapters = {
      ["neotest-go"] = {
        -- Here we can set options for neotest-go, e.g.
        -- args = { "-tags=integration" }
      },
      ["neotest-python"] = {
        -- Here you can specify the settings for the adapter, i.e.
        -- runner = "pytest",
        -- python = ".venv/bin/python",
      },
    },
  },
}
