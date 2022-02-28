require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "latex", "bibtex", "markdown", "python" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = false,
	},
	matchup = {
		enable = enable, -- mandatory, false will disable the whole extension
		disable = {}, -- optional, list of language that will be disabled
		-- [options]
	},
})
