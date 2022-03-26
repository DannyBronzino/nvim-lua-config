vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.foldlevel = 99

-- tabs
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

vim.api.nvim_set_keymap("n", "<space>f", "<cmd>Neoformat<cr>", { noremap = true, silent = true }) -- format document
