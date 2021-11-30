vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme doom-one]])

-- source config.lualine when colorscheme changes
vim.cmd([[
autocmd colorscheme * source ~/.config/nvim/lua/config/lualine.lua
]])
