vim.cmd([[syntax enable]])
vim.o.background = "dark"
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- Set colorscheme (order is important here)
vim.o.termguicolors = true

local default_colors = require("kanagawa.colors").setup()

local overrides = {
	WhichKeyValue = { fg = default_colors.crystalBlue, bg = "NONE" },
	LineNr = { fg = default_colors.dragonBlue, bg = "NONE" },
}

require("kanagawa").setup({
	transparent = true,
	overrides = overrides,
})

vim.cmd([[colorscheme kanagawa]])
