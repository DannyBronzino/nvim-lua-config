-- displays spell indicator
local function spell()
	if vim.o.spell then
		return string.format("SPELL")
	end

	return ""
end

-- show word count
local function get_words()
	return tostring(vim.fn.wordcount().words .. " words")
end

-- ensures builtin colorschemes are NOT used
local function get_colorscheme()
	local colorscheme = vim.api.nvim_exec([[colorscheme]], true)
	if colorscheme == "dracula" then
		return "dracula-nvim"
	elseif colorscheme == "nightfly" then
		return "nightfly"
	elseif colorscheme == "tokyonight" then
		return "tokyonight"
	else
		return "auto"
	end
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = get_colorscheme(),
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
		},
		lualine_c = { "filename" },
		lualine_x = {
			{ spell, color = "WarningMsg" },
			{ get_words },
			"filetype",
		},
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
			},
			"location",
		},
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"quickfix",
		"fugitive",
		"nvim-tree",
	},
})
