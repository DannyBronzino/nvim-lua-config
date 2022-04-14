require("hop").setup({
	case_insensitive = true,
	char2_fallback_key = "<CR>",
	quit_key = "<esc>",
	multi_windows = true,
})

vim.opt.virtualedit:append("onemore") -- enables operations to end of line

local map = require("utils").map
local opts = { silent = true }

-- replace "t"
map("n", "T", function()
	require("hop").hint_char1()
end, opts)
map("o", "T", function()
	require("hop").hint_char1()
end, opts)
map("v", "T", function()
	require("hop").hint_char1()
end, opts)

-- replace "f"
map("n", "F", function()
	require("hop").hint_char1({ inclusive_jump = true })
end, opts)
map("o", "F", function()
	require("hop").hint_char1({ inclusive_jump = true })
end, opts)
map("v", "F", function()
	require("hop").hint_char1({ inclusive_jump = true })
end, opts)

-- word jump
map("n", "W", function()
	require("hop").hint_words()
end, opts)
map("o", "W", function()
	require("hop").hint_words()
end, opts)
map("v", "W", function()
	require("hop").hint_words()
end, opts)

-- two character search
map("n", "s", function()
	require("hop").hint_char2()
end, opts)
map("o", "s", function()
	require("hop").hint_char2()
end, opts)
map("v", "s", function()
	require("hop").hint_char2()
end, opts)
