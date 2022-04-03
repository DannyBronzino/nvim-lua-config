-- displays spell indicator
local function spell()
	if vim.o.spell then
		return string.format("SPELL")
	end

	return ""
end

-- Get the positions of trailing whitespaces from plugin 'jdhao/whitespace.nvim'.
local function trailing_space()
	local trailing_space_pos = vim.b.trailing_whitespace_pos

	local msg = ""
	if #trailing_space_pos > 0 then
		-- Note that lua index is 1-based, not zero based!!!
		local line = trailing_space_pos[1][1]
		msg = string.format("[%d]trailing", line)
	end

	return msg
end

-- displays error if indents are mixed
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
			{
				trailing_space,
				color = "WarningMsg",
			},
			{
				mixed_indent,
				color = "WarningMsg",
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
		-- "nvim-tree",
		"fugitive",
	},
})
