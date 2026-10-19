-- Lean support.

vim.pack.add({'https://github.com/Julian/lean.nvim'})

vim.g.lean_config = {
  infoview = {
    autoopen = false
  },
  stderr = {
    enable = false
  }
}
