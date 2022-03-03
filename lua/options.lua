local utils = require("utils")

-- set highlight on search
-- vim.opt.hlsearch = true -- unnecessary with hlslens

-- make line numbers default
vim.opt.number = true

-- enable break indent
vim.opt.breakindent = true

-- enable linebreaks and options
vim.opt.linebreak = true
vim.opt.showbreak = "↪"
vim.opt.breakindentopt = { "shift:1" }

-- save undo history
vim.opt.undofile = true

-- case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- decrease update time
vim.opt.updatetime = 100

-- timeout length for which-key
vim.opt.timeoutlen = 1000

-- display signs in number column
vim.opt.signcolumn = "auto:1-3"

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- set jj to escape insert mode
vim.g.better_escape_shortcut = "jj"
vim.g.better_escape_interval = 300

vim.opt.fillchars = "fold: ,vert:│,eob: ,msgsep:‾"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.swapfile = false

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

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.fileencoding = "utf-8"

vim.opt.matchpairs:append({ "<:>", "「:」", "『:』", "【:】", "“:”", "‘:’", "《:》" })

vim.opt.wildmode = "list:longest"

vim.opt.showmode = false

vim.opt.fileformats = "unix"

vim.opt.wildignore:append({
	[[*.o,*.obj,*.bin,*.dll,*.exe,*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**,*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico,*.pyc,*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv]],
})
vim.opt.wildignorecase = true

vim.opt.visualbell = true
vim.opt.errorbells = false

vim.opt.history = 500

vim.opt.list = true

vim.opt.listchars = {
	extends = "❯",
	nbsp = "␣",
	precedes = "❮",
	tab = "▸ ",
}

vim.opt.shortmess:append({ c = true })

vim.opt.shiftround = true

vim.opt.virtualedit = "block"

vim.opt.formatoptions:append({ m = true, M = true, t = true })

-- use tilde as an operator
vim.opt.tildeop = true

vim.opt.joinspaces = false

vim.opt.synmaxcol = 200
vim.opt.startofline = false

-- enable rg if available
if utils.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	vim.opt.grepformat = { "%f:%l:%c:%m" }
end

vim.opt.isfname:remove("=")
vim.opt.isfname:remove(",")

vim.opt.whichwrap:append("<,>,h,l")
vim.opt.wrap = true

-- let treesitter handle folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.numberwidth = 4

vim.opt.mouse:append({ a = true })

-- the following are necessary for cmp-spell
-- set to off because it's annoying
vim.opt.spell = false
vim.opt.spelllang = { "en" }
