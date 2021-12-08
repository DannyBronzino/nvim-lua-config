-- new functions from jdhao
local function spell()
	if vim.o.spell then
		return string.format("[SPELL]")
	end

	return ""
end

local function trailing_space()
	-- Get the positions of trailing whitespaces from plugin 'jdhao/whitespace.nvim'.
	local trailing_space_pos = vim.b.trailing_whitespace_pos

	local msg = ""
	if #trailing_space_pos > 0 then
		-- Note that lua index is 1-based, not zero based!!!
		local line = trailing_space_pos[1][1]
		msg = string.format("[%d]trailing", line)
	end

	return msg
end

local function mixed_indent()
	local space_pat = [[\v^ +]]
	local tab_pat = [[\v^\t+]]
	local space_indent = vim.fn.search(space_pat, "nwc")
	local tab_indent = vim.fn.search(tab_pat, "nwc")
	local mixed = (space_indent > 0 and tab_indent > 0)
	local mixed_same_line
	if not mixed then
		mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
		mixed = mixed_same_line > 0
	end
	if not mixed then
		return ""
	end
	if mixed_same_line ~= nil and mixed_same_line > 0 then
		return "MI:" .. mixed_same_line
	end
	local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
	local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
	if space_indent_cnt > tab_indent_cnt then
		return "MI:" .. tab_indent
	else
		return "MI:" .. space_indent
	end
end

-- ensures builtin colorschemse are NOT used
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
		},
		lualine_c = { spell, "filename" },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = {
			"location",
			{
				"diagnostics",
				sources = { "nvim_lsp" },
			},
			{
				trailing_space,
				color = "WarningMsg",
			},
			{
				mixed_indent,
				color = "WarningMsg",
			},
		},
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
		"fugitive",
	},
})
