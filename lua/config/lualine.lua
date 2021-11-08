local function get_colorscheme()
	local colorscheme = vim.api.nvim_exec([[colorscheme]], true)

	if colorscheme == "dracula" then
		return "dracula-nvim"
	elseif colorscheme == "OceanicNext" then
		return "OceanicNext"
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
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			{ "diagnostics", sources = { "nvim_lsp", "coc" } },
		},
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
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
		"nvim-tree",
	},
})
