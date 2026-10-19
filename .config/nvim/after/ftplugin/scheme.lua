-- For scheme, indent with 2 spaces.
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

-- When inserting a closing parenthesis, make it *very* visible where the
-- matching opening parenthesis is placed.
vim.opt_local.showmatch = true

-- By default, 'if' is marked as a lispword. Therefore, if an if-expression
-- spans multiple lines, an additional indentation of 2 is used (in the same
-- way as, for example, for 'define' and 'let'). This doesn’t aggree with the
-- usual rule of aligning all parts of the if-expression.
vim.opt_local.lispwords:remove('if')

-- Set the formatting tool to scmindent (https://github.com/ds26gte/scmindent).
-- This does not affect the auto-formatting, but is instead used for =.
vim.opt_local.equalprg = 'scmindent.lua'

