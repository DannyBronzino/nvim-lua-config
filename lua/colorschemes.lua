vim.cmd([[syntax enable]])
vim.o.background = "dark"
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- Set colorscheme (order is important here)
vim.o.termguicolors = true

local kanagawa_colors = require("kanagawa.colors").setup()

local overrides = {
	WhichKeyValue = { fg = kanagawa_colors.crystalBlue, bg = "NONE" },
	LineNr = { fg = kanagawa_colors.dragonBlue, bg = "NONE" },
  Comment = { fg = kanagawa_colors.springBlue },
}

require("kanagawa").setup({
	transparent = true,
	overrides = overrides,
})

vim.cmd([[colorscheme kanagawa]])
