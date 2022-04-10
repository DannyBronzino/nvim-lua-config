vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

local map = require("utils").map

map("n", "<F5>", "<cmd>luafile %<cr>") -- source file
