local kanagawa_colors = require("kanagawa.colors").setup()

local overrides = {
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
