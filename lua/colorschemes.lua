vim.cmd([[syntax enable]])
vim.o.background = "dark"

-- Set colorscheme (order is important here)
vim.o.termguicolors = true

local kanagawa_colors = require("kanagawa.colors").setup()

local overrides = {
	-- new highlights
	carpYellow = { fg = kanagawa_colors.carpYellow, bg = "NONE", style = "NONE" },

	-- overide existing highlights
	WhichKeyValue = { fg = kanagawa_colors.crystalBlue, bg = "NONE" },
	LineNr = { fg = kanagawa_colors.dragonBlue, bg = "NONE" },
	Comment = { fg = kanagawa_colors.springBlue },
	Visual = { bg = kanagawa_colors.waveBlue2 },
	IncSearch = { bg = kanagawa_colors.oniViolet },
	MatchParen = { fg = kanagawa_colors.sakuraPink, style = "bold" },
}

require("kanagawa").setup({
	transparent = true,
	overrides = overrides,
})

vim.cmd([[colorscheme kanagawa]])
