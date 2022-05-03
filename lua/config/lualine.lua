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

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "kanagawa",
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
		-- "nvim-tree",
	},
})
