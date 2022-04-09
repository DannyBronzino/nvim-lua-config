local au = vim.api.nvim_create_autocmd

-- change colorscheme
au("Colorscheme", {
	callback = function()
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
	end,
})

-- set numbers to relative when in Normal mode, absolute when in Insert
local number_toggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })

au({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.opt.number:get() == true then
			vim.opt.relativenumber = true
		end
	end,
	group = number_toggle,
})

au({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.opt.number:get() == true then
			vim.opt.relativenumber = false
		end
	end,
	group = number_toggle,
})

-- local cursorline_toggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- au("InsertEnter", {
-- 	callback = function()
-- 		vim.opt.cursorline = true
-- 	end,
-- 	group = cursorline_toggle,
-- })

-- au("InsertLeave", {
-- 	callback = function()
-- 		vim.opt.cursorline = false
-- 	end,
-- 	group = cursorline_toggle,
-- })

-- resume edit position
vim.cmd([[
augroup resume_edit_position
  autocmd!
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
augroup END
]])
