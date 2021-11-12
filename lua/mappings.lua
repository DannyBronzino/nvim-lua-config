-- Easier syntax
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<c-K>", ":<C-U>lprevious<CR>zv", opts)
map("n", "<c-J>", ":<C-U>lnext<CR>zv", opts)
map("n", "<c-H>", ":<C-U>lfirst<CR>zv", opts)
map("n", "<c-L>", ":<C-U>llast<CR>zv", opts)