local g = vim.g
g.nvim_tree_git_hl = 1 -- file highlight for git attributes
g.nvim_tree_indent_markers = 1 -- indent markers when folders are open

-- https://github.com/kyazdani42/nvim-tree.lua#setup
require'nvim-tree'.setup {
  auto_close = true, -- closes the tree when it's the last window
  update_focused_file = {
    enable = true, -- show selected file on open
  },
  filters = {
    dotfiles = true, -- hide dotfiles by default
    custom = {
      '.DS_Store',
      '.cache',
      '.git',
      'fugitive:',
    }
  },
  update_cwd = true,
  view = {
    auto_resize = true -- resize the tree to it's saved width when opening a new file
  },
}
