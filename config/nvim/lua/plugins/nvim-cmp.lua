return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer", -- Completion source for buffer words
    "hrsh7th/cmp-calc", -- Completion source for math calculations
    "hrsh7th/cmp-cmdline", -- Completion source for vim's cmdline
    "hrsh7th/cmp-emoji", -- completion source for emojis
    "saadparwaiz1/cmp_luasnip", -- Completion source for luasnip
    "hrsh7th/cmp-nvim-lsp", -- Completion source for LSP
    "hrsh7th/cmp-nvim-lua", -- Completion source for lua
    "hrsh7th/cmp-path", -- Completion source for filesystem paths
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))

    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
      { name = "buffer" },
      { name = "buffer" },
      { name = "calc" },
      { name = "cmdline" },
      { name = "emoji" },
      { name = "emoji" },
      { name = "luasnip" },
      { name = "nvim-lsp" },
      { name = "nvim-lua" },
      { name = "path" },
    }))

    --Enable supertab in cmp (was disabled in luasnip.lua)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- this way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })
  end,
}
