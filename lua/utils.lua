---inspect something -@param item function|table
function Inspect(item)
	print(vim.inspect(item))
end

local M = {}

---easier vim.keymap.set syntax
---@param mode string|table nvim mode for mapping
---@param left_hand_side string
---@param right_hand_side string
---@param opts table|nil if silent = false not present then it will be set to true
---@return function vim.keymap.set
function M.map(mode, left_hand_side, right_hand_side, opts)
	opts = opts or { silent = true }
	if opts.silent == nil then
		opts.silent = true
	end
	return vim.keymap.set(mode, left_hand_side, right_hand_side, opts)
end

---does the executable exist?
---@param name string name of executable
---@return boolean
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
