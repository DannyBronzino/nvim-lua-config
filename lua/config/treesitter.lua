require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	sync_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	matchup = {
		enable = enable, -- mandatory, false will disable the whole extension
		disable = {}, -- optional, list of language that will be disabled
		-- [options]
	},
})

-- let treesitter handle folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
