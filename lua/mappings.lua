-- Easier syntax
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- set leader to comma
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","
