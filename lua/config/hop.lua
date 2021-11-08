require('hop').setup({
  case_insensitive = true,
})

local map = vim.api.nvim_set_keymap

map('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true})

map('o', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true})

map('v', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true})

map('n', 'W', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})

map('o', 'W', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})

map('v', 'W', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})