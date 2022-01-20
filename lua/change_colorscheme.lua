-- get current colorscheme
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

-- change lualine colorscheme
require("lualine").setup({
	options = {
		theme = get_colorscheme(),
	},
})
