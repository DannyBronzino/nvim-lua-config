require("hop").setup({
	case_insensitive = true,
	char2_fallback_key = "<CR>",
})

vim.opt.virtualedit:append("onemore") -- enables operations to end of line

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- replace "t"
map("n", "t", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
map("o", "t", "<cmd>lua require'hop'.hint_char1()<cr>", opts)
map("v", "t", "<cmd>lua require'hop'.hint_char1()<cr>", opts)

-- replace "f"
map("n", "f", "<cmd>lua require'hop'.hint_char1({inclusive_jump = true})<cr>", opts)
map("o", "f", "<cmd>lua require'hop'.hint_char1({inclusive_jump = true})<cr>", opts)
map("v", "f", "<cmd>lua require'hop'.hint_char1({inclusive_jump = true})<cr>", opts)

-- word jump
-- map("n", "W", "<cmd>lua require'hop'.hint_words()<cr>", opts)
-- map("o", "W", "<cmd>lua require'hop'.hint_words()<cr>", opts)
-- map("v", "W", "<cmd>lua require'hop'.hint_words()<cr>", opts)

-- two character search
map("n", "s", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
map("o", "s", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
map("v", "s", "<cmd>lua require'hop'.hint_char2()<cr>", opts)
