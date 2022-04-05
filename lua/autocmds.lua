-- change colorscheme
vim.api.nvim_create_autocmd("Colorscheme", {
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
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.opt.number:get() == true then
			vim.opt.relativenumber = true
		end
	end,
	group = numbertoggle,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.opt.number:get() == true then
			vim.opt.relativenumber = false
		end
	end,
	group = numbertoggle,
})

-- resume edit position
vim.cmd([[
augroup resume_edit_position
  autocmd!
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
augroup END
]])
