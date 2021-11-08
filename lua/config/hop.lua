require('hop').setup({
  case_insensitive = true,
})

vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true})

vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {noremap = true})

vim.api.nvim_set_keymap('n', '<Leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})

vim.api.nvim_set_keymap('o', '<Leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})