-- WGSL / WESL (WebGPU shaders): tree-sitter-wesl for highlighting, wgsl-analyzer for LSP
if vim.g.vscode then return {} end

-- Neovim detects *.wgsl but not *.wesl
vim.filetype.add { extension = { wesl = "wesl" } }
-- tree-sitter-wesl parses both (WESL is a WGSL superset)
vim.treesitter.language.register("wesl", { "wesl", "wgsl" })

-- wgsl-analyzer's formatter ignores shiftwidth (always 4 spaces) and reorders imports
local group = vim.api.nvim_create_augroup("user_wesl", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "wgsl", "wesl" },
  callback = function() vim.b.autoformat = false end,
})

-- tree-sitter-wesl's nvim queries still use the pre-0.10 capture names for if/else/for/loop
local function link_legacy_captures()
  vim.api.nvim_set_hl(0, "@conditional.wesl", { link = "@keyword.conditional", default = true })
  vim.api.nvim_set_hl(0, "@repeat.wesl", { link = "@keyword.repeat", default = true })
end
link_legacy_captures()
vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = link_legacy_captures })

-- `gd` on a builtin (vec3f, …) lands in wgsl-analyzer's virtual std module (wgsl:///std/…).
-- Neovim does not fetch LSP 3.18 `workspace/textDocumentContent` itself; left empty, the buffer's
-- didOpen would replace std in the server and every builtin alias would stop resolving.
vim.api.nvim_create_autocmd("BufReadCmd", {
  group = group,
  pattern = "wgsl://*",
  callback = function(ev)
    local client = vim.lsp.get_clients({ name = "wgsl_analyzer" })[1]
    local res = client and client:request_sync("workspace/textDocumentContent", { uri = ev.match }, 5000)
    local text = res and res.result and res.result.text
    if not text then
      vim.notify("wgsl-analyzer: cannot load " .. ev.match, vim.log.levels.ERROR)
      return
    end
    local buf = ev.buf
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { plain = true }))
    vim.bo[buf].buftype = "nowrite"
    vim.bo[buf].modified = false
    -- the LSP jump resets 'modifiable' after loading
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(buf) then vim.bo[buf].modifiable = false end
    end)
    -- highlight without a filetype, so no LSP client attaches to the read-only copy
    pcall(vim.treesitter.start, buf, "wesl")
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").wesl = {
            install_info = {
              url = "https://github.com/webgpu-tools/tree-sitter-wesl",
              queries = "queries/nvim",
            },
          }
        end,
      })
    end,
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "wesl" }) end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        wgsl_analyzer = {
          filetypes = { "wgsl", "wesl" },
          -- root at the shader package, not the whole monorepo
          root_markers = { "wesl.toml", ".git" },
        },
      },
    },
  },
}
