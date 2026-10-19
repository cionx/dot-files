-- VimTex for all kinds of LaTeX stuff.
vim.pack.add({'https://github.com/lervag/vimtex'})

vim.g.tex_flavor = 'latex'

-- Disable highlighting of Unicode mathematics as TeX commands, see https://github.com/lervag/vimtex/issues/2732#issuecomment-1677584255
vim.g.vimtex_syntax_match_unicode = false

-- When inside some delimiters (e.g., parentheses) use tsd (toggle surrounding
-- delimiters) to toggle through these (+ no delimiters).
vim.g.vimtex_delim_toggle_mod_list = {
  {'\\bigl',  '\\bigr'},
  {'\\Bigl',  '\\Bigr'},
  {'\\biggl', '\\biggr'},
  {'\\Biggl', '\\Biggr'},
  {'\\left',  '\\right'},
}

-- Paired delimiters that we can jump between using %.
vim.g.vimtex_delim_list = {
  delim_math = {
    name = {
      {'(', ')'},
      {'[', ']'},
      {'\\{',           '\\}'},
      {'⟨',             '⟩'},
      {'⦅',             '⦆'},
      {'⟦',             '⟧'},
      {'⦃',             '⦄'},
      {'⌈',             '⌉'},
      {'⌊',             '⌋'},
      {'\\begingroup', '\\endgroup'},
      {'\\lparen',     '\\rparen'},
      {'\\lbrack',     '\\rbrack'},
      {'\\lbrace',     '\\rbrace'},
      {'\\langle',     '\\rangle'},
      {'\\lBrack',     '\\rBrack'},
      {'\\lceil',      '\\rceil'},
      {'\\lfloor',     '\\rfloor'},
      {'\\ulcorner',   '\\urcorner'},
      {'\\lvert',      '\\rvert'},
      {'\\lVert',      '\\rVert'},
    },
  },
}

-- Disable automatic compilation for every little change.
vim.g.vimtex_compiler_latexmk = {continuous = 0}
-- Alt+2 for compilation; uses 'latexmk' per default
vim.keymap.set('n', '<M-2>', ':wall<Return>:VimtexCompile<Return>')
-- Alt+3 for opening the PDF viewer at the current position
vim.keymap.set('n', '<M-3>', ':VimtexView<Return>')

-- Forward and backward search with okular, as explained in
-- :help vimtex-view-okular
-- :help vimtex-synctex-inverse-search
vim.g.vimtex_compiler_progname    = 'nvr'
vim.g.vimtex_view_method          = 'general'
vim.g.vimtex_view_general_viewer  = 'okular'
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
-- In Okular, under
--   Settings > Configure Okular > Editor
-- choose 'Custom Text Editor' and enter the following command:
--   nvim --headless -c "VimtexInverseSearch %l '%f'"






----- TexLab

local lspconfig = vim.lsp

lspconfig.enable('texlab')

lspconfig.config('texlab', {
  filetypes = { "tex", "plaintex", "sty", "cls", "bib" },
  settings = {
      texlab = {
          build = {
              isContinuous = true,
          },
          chktex = {
              onEdit = false,
              onOpenAndSave = false,
          },
          formatterLineLength = 100,
          forwardSearch = {
              executable = "okular",
              args = { "--unique", "%p#src:%l%f" }
          }
      }
  }
})
