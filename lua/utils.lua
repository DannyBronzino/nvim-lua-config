-- inspect something
-- Taken from https://github.com/jamestthompson3/vimConfig/blob/eeef4a8eeb5a24938f8a0969a35f69c78643fb66/lua/tt/nvim_utils.lua#L106
function Inspect(item)
	print(vim.inspect(item))
end

-- easier syntax for mapping
function Map(mode, left_hand_side, right_hand_side, opts)
	opts = opts or { silent = true }
	vim.keymap.set(mode, left_hand_side, right_hand_side, opts)
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

-- trim whitespace from beginning of string
function M.ltrim(s)
	return s:match("^%s*(.*)")
end

-- trim whitespace from end of string
function M.rtrim(s)
	return s:match("^(.*%S)%s*$")
end

-- join all non-blank lines
-- because I can never remember
function M.join_lines()
	vim.cmd([[%!fmt -999]])
end

return M
