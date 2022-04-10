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

-- easier syntax for mapping
function M.map(
	mode, -- vim mode
	lhs, -- left hand side
	rhs, -- right hand side
	opts -- options
)
	opts = opts or {}
	opts.silent = true
	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
