-- Easier syntax
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- set leader to comma
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- allows for use of "j" and "k" over wrapped lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

map("n", "<Tab>", "%", opts) -- easier matchit movement

-- move to beginning of wrapped line
map("n", "H", "g^", opts)
map("x", "H", "g^", opts)

-- move to beginning of wrapped line
map("n", "L", "g$", opts)
map("x", "L", "g$", opts)

map("n", "Y", "y$", opts) -- yank until end of line

map("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>", opts) -- commit current file