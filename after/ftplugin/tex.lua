vim.opt.formatoptions:append({ t = true })
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.foldlevel = 999
vim.opt.colorcolumn = "0"

local buf_map = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

-- Expansions for book I'm writing
buf_map(0, "i", "\\tq", "\\tq{}<left>", opts)
buf_map(0, "i", "...", "\\dots{}", opts)
vim.cmd([[
iabbrev <buffer> Qing \Qing{}
iabbrev <buffer> Therese \Therese{}
iabbrev <buffer> Lakshmi \Lakshmi{}
]])
