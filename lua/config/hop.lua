require("hop").setup({
	case_insensitive = true,
	char2_fallback_key = "<CR>",
	quit_key = "<esc>",
	multi_windows = true,
})

vim.opt.virtualedit = { "onemore" } -- enables operations to end of line

local map = require("utils").map
local opts = { silent = true }

-- replace "t"
map({ "n", "o", "v" }, "T", function()
	require("hop").hint_char1()
end, opts)

-- replace "f"
map({ "n", "o", "v" }, "F", function()
	require("hop").hint_char1({ inclusive_jump = true })
end, opts)

-- word jump
map({ "n", "o", "v" }, "<leader>l", function()
	require("hop").hint_lines_skip_whitespace()
end, opts)

-- two character search
map({ "n", "o", "v" }, "s", function()
	require("hop").hint_char2()
end, opts)