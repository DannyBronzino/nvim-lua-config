vim.opt.syntax = "enable"

--Incremental live completion (note: this is now a default on master)
vim.opt.inccommand = "nosplit"

--Set highlight on search
vim.opt.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.opt.hidden = true

--Enable mouse mode
vim.opt.mouse = "a"

--Enable break indent
vim.opt.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
-- Timeout length for which-key
vim.opt.timeoutlen = 500

vim.wo.signcolumn = "yes"

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- set jj to escape insert mode
vim.g.better_escape_shortcut = "jj"
vim.g.better_escape_interval = 300

vim.opt.fillchars = "fold: ,vert:│,eob: ,msgsep:‾"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 1000

vim.opt.swapfile = false

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

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.fileencoding = "utf-8"

vim.cmd([[set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》]])

vim.opt.linebreak = true
vim.opt.showbreak = "↪"

vim.opt.wildmode = "list:longest"

vim.opt.showmode = false

vim.opt.fileformats = "unix"

vim.cmd([[
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase
]])

vim.opt.visualbell = true
vim.opt.errorbells = false

vim.opt.history = 500

vim.cmd([[set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣]])

vim.opt.undofile = true

vim.cmd([[set shortmess+=c]])

vim.opt.spelllang = "en"

vim.opt.shiftround = true

vim.opt.virtualedit = "block"

vim.cmd([[set formatoptions+=mM]])

-- use tilde as an operator
vim.opt.tildeop = true

vim.opt.joinspaces = false

vim.opt.synmaxcol = 200
vim.opt.startofline = false

vim.cmd([[
  if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
]])

vim.opt.signcolumn = "auto:2"

vim.opt.isfname:remove("=")
vim.opt.isfname:remove(",")

vim.opt.whichwrap:append("<,>,h,l")
vim.opt.wrap = true

vim.opt.formatoptions:append("t")
-- vim.cmd([[set isfname-==
-- set isfname-=,
-- set whichwrap+=<,>,h,l
-- set wrap
-- set formatoptions+=t]])

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.numberwidth = 6

-- vim.cmd([[set mouse+=a]])
vim.opt.mouse:append("a")
