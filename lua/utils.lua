-- inspect something
-- Taken from https://github.com/jamestthompson3/vimConfig/blob/eeef4a8eeb5a24938f8a0969a35f69c78643fb66/lua/tt/nvim_utils.lua#L106
function inspect(item)
	print(vim.inspect(item))
end

local M = {}

-- does the executable exist?
function M.executable(name)
	if vim.fn.executable(name) > 0 then
		return true
	end

	return false
end

-- can the directory be created?
function M.may_create_dir()
	local fpath = vim.fn.expand("<afile>")
	local parent_dir = vim.fn.fnamemodify(fpath, ":p:h")
	local res = vim.fn.isdirectory(parent_dir)

	if res == 0 then
		vim.fn.mkdir(parent_dir, "p")
	end
end

function move_line(up)
	local current_line = vim.api.nvim_get_current_line()
	local current_row = vim.api.nvim_win_get_cursor(0)[1]

	if up == true then
		current_row = current_row - 2
	end

	-- prevents crash if you try to move the top line up
	if current_row < 0 then
		do
			return
		end
	end

	vim.api.nvim_del_current_line()
	vim.api.nvim_buf_set_lines(0, current_row, current_row, true, { current_line })
	vim.api.nvim_win_set_cursor(0, { current_row + 1, 0 })
end

return M
