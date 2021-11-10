require('hop').setup({
  case_insensitive = true,
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", opts)

map('o', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", opts)

map('v', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", opts)

map('n', 'W', "<cmd>lua require'hop'.hint_words()<cr>", opts)

map('o', 'W', "<cmd>lua require'hop'.hint_words()<cr>", opts)

map('v', 'W', "<cmd>lua require'hop'.hint_words()<cr>", opts)