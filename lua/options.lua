local utils = require("utils")

vim.opt.number = true -- make line numbers default

vim.opt.breakindent = true -- enable break indent

-- enable linebreaks and options
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.breakindentopt = { "shift:1" }

vim.opt.undofile = true -- save undo history

-- case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 100 -- decrease update time

vim.opt.signcolumn = "auto:1-3" -- display signs in number column

-- allows for use of "j" and "k" over wrapped lines
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- where to open new splits
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false -- turn off swapfile

-- sets up backup
vim.cmd([[
let g:backupdir=expand(stdpath('data') . '/backup')
if !isdirectory(g:backupdir)
   call mkdir(g:backupdir, 'p')
endif
let &backupdir=g:backupdir

set backup
set backupcopy=yes
]])

-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

vim.opt.fileencoding = "utf-8" -- sets file encoding

vim.opt.fileformats = "unix" -- sets file format

vim.opt.matchpairs:append({ "<:>", "「:」", "『:』", "【:】", "“:”", "‘:’", "《:》" }) -- sets pairs for "%"

vim.opt.showmode = false -- show mode

vim.opt.list = true -- show listchars

vim.opt.listchars = { -- characters for visually representing blank space
	extends = "❯",
	nbsp = "␣",
	precedes = "❮",
	tab = "▸ ",
}

vim.opt.shortmess:append({ c = true }) -- eliminate incsearch messages

vim.opt.shiftround = true -- round indent to multiple of shiftwidth

vim.opt.virtualedit = "block" -- allows for positioning of cursor on non-character space in visualblock mode

vim.opt.tildeop = true -- use tilde as an operator

vim.opt.joinspaces = false -- use only one space after ".", "?", "!" on join

-- use rg for grepping, if available
if utils.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	vim.opt.grepformat = { "%f:%l:%c:%m" }
end

-- remove characters from possible filenames
vim.opt.isfname:remove("=")
vim.opt.isfname:remove(",")

vim.opt.wrap = true -- softwrap

vim.opt.numberwidth = 4 -- width of number gutter

vim.opt.mouse:append({ a = true }) -- enable mouse for all modes

vim.opt.spelllang = { "en" } -- set language for spell
