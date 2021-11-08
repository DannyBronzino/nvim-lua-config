-- sources
require("plugins")
require("options")

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme OceanicNext]])

--Remap space as leader key
vim.api.nvim_set_keymap("", "Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","
