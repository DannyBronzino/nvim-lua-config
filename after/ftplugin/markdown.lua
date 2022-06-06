vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.foldlevel = 99

-- tabs
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

local map = require("utils").map

map("n", "<space>f", "<cmd>Neoformat<cr>") -- format document

map("n", "<leader>ft", function()
  require("telescope.builtin").tags()
end)
