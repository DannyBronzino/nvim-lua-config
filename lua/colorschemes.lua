vim.cmd([[syntax enable]])
vim.o.background = "dark"

-- Set colorscheme (order is important here)
vim.o.termguicolors = true

local kanagawa_colors = require("kanagawa.colors").setup()

local overrides = {
	-- new highlights
	carpYellow = { fg = kanagawa_colors.carpYellow, bg = "NONE", style = "NONE" },

	-- overide existing highlights
	WhichKeyValue = { fg = kanagawa_colors.crystalBlue },
	LineNr = { fg = kanagawa_colors.dragonBlue },
	Comment = { fg = kanagawa_colors.springBlue },
	Visual = { bg = kanagawa_colors.waveBlue2 },
	IncSearch = { bg = kanagawa_colors.oniViolet },
	MatchParen = { fg = kanagawa_colors.sakuraPink, style = "bold" }, -- for vim-matchup
	SpellBad = { fg = kanagawa_colors.peachRed, style = "bold" },
	SpellCap = { fg = kanagawa_colors.peachRed, style = "bold" },
	SpellRare = { fg = kanagawa_colors.peachRed, style = "bold" },
	SpellLocal = { fg = kanagawa_colors.peachRed, style = "bold" },
}

require("kanagawa").setup({
	transparent = true,
	overrides = overrides,
})

vim.g.tokynight_style = "night"
vim.g.tokyonight_transparent = true

vim.g.nightflytransparent = "1"

vim.cmd([[colorscheme kanagawa]])
