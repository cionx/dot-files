-- Indent with 2 spaces in markdown files.
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

-- Softwrapped lines should be properly indented in lists…
vim.opt_local.breakindentopt:append('list:-1')

-- … and for these purposes, we treat '>' as a list indicator.
-- The following regular expression was created as follows:
-- - Take the default (accessed via ':set formatlistpat?'):
--     ^\s*\d\+\.\s\+\|^\s*[-*+]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
-- - Add '>' to the list of symbols '-', '*', '+':
--     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
-- - Also modify the third option to better catch stuff like '[1]: …':
--     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\s*\[.\{-}\]:\s*
-- - Allow multiple lists to start on the same line, so that lists in quotes
--   are properly indented:
--     ^\s*\(\d\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)
--   Note that the leading '^' needs to be outside the group (this took me some
--   time to notice).
-- - Allow for list items to be labeled by words:
--     ^\s*\([a-z0-9]\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)
--   (The class \d needs to be spelled out as 0-9, but I don’t understand why.)
vim.opt_local.formatlistpat = [[^\s*\([a-z0-9]\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)\+]]





--[[ Previewing Markdown files in a browser. --]]

vim.pack.add({
  'https://www.github.com/selimacerbas/mdkite.nvim',
  'https://www.github.com/selimacerbas/kitehost.nvim', -- Dependency.
})

vim.keymap.set({'n', 'i'}, '<A-3>', ':MdKite start<CR>', {silent = true})

require("mdkite").setup({
  custom_css = vim.fn.stdpath('config') .. '/others/mdkite/style_changes.css'
})

--[[
vim.pack.add({'https://github.com/iamcco/markdown-preview.nvim'})
-- Missing: Installs a pre-built version so that nodejs and yarn are not needed.
-- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

-- Config explanation taken from: https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/README.md

-- Leave the preview open, even if the file has been closed in the editor.
-- Not what I want, but the auto-close function leads to error warnings that are more annoying than closing the preview by hand.
vim.g.mkdp_auto_close = 0
-- Disable sync scroll (default is 0); all other options are the untouched default values.
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 1,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
  toc = {}
}
-- To change the font for monospace fonts, a custom CSS file must be specified.
-- This file is just a copy of
-- https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/app/_static/markdown.css
-- with ".markdown-body code > font-family" adjusted.
vim.g.mkdp_markdown_css = vim.fn.expand('~/.config/nvim/others/markdown-preview/markdown.css')
--]]
