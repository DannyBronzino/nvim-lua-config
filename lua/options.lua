local utils = require("utils")

vim.opt.number = true -- make line numbers default

-- enable linebreaks and options
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.breakindent = true -- enable break indent
vim.opt.breakindentopt = { "shift:1" } -- move wrapped line over 1 space

vim.opt.undofile = true -- save undo history

-- case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 1000 -- decrease update time

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

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

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

vim.opt.numberwidth = 4 -- width of number gutter
vim.opt.signcolumn = "yes:3" -- display signs before number column

vim.opt.mouse:append({ a = true }) -- enable mouse for all modes

vim.opt.spelllang = { "en" } -- set language for spell

vim.opt.background = "dark" -- background color
vim.opt.termguicolors = true -- use full color palette

-- vim.opt.cursorline = true -- highlight current line

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.laststatus = 3 -- sets status line to appear on only the last window

-- window separators
vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})
