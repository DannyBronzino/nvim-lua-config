vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme doom-one]])
vim.cmd([[hi WhichKeyValue guifg=Normal]])
vim.cmd([[hi Comment guifg=darkgrey]])
