vim.opt.formatoptions:append({ t = true })
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.foldlevel = 999
vim.opt.colorcolumn = "0"
-- the following are necessary fro cmp-spell
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spellsuggest = { "best", "5" }
