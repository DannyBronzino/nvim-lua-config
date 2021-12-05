vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme doom-one]])

-- source config.lualine when colorscheme changes reset background highlights
vim.cmd([[
augroup colorscheme_switch
	autocmd!
	autocmd colorscheme * source ~/.config/nvim/lua/config/lualine.lua
	autocmd colorscheme * hi Normal guibg=NONE ctermbg=NONE
	autocmd colorscheme * hi LineNr guibg=NONE ctermbg=NONE
	autocmd colorscheme * hi SignColumn guibg=NONE ctermbg=NONE
	autocmd colorscheme * hi EndOfBuffer guibg=NONE ctermbg=NONE
augroup END
]])
