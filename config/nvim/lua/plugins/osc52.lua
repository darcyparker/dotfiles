return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup {
      silent = true, -- Suppress message on copy
      trim = false, -- Don't trim surrounding whitespace
    }

    -- Sync with system clipboard automatically
    local function copy()
      if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
        require("osc52").copy_register("+")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
}
