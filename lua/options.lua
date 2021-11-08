--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = "nosplit"

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Remap for dealing with word wrap
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

vim.o.fillchars = "fold: ,vert:│,eob: ,msgsep:‾"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.updatetime = 1000

vim.o.swapfile = false

vim.cmd([[
let g:backupdir=expand(stdpath('data') . '/backup')
if !isdirectory(g:backupdir)
   call mkdir(g:backupdir, 'p')
endif
let &backupdir=g:backupdir

set backup
set backupcopy=yes
]])

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.fileencoding = "utf-8"

vim.cmd([[set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》]])

vim.o.linebreak = true
vim.o.showbreak = "↪"

vim.o.wildmode = "list:longest"

vim.o.showmode = false

vim.o.fileformats = "unix"

vim.cmd([[
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase
]])

vim.o.visualbell = true
vim.o.errorbells = false

vim.o.history = 500

vim.cmd([[set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣]])

vim.o.undofile = true

vim.cmd([[set shortmess+=c]])

vim.o.spelllang = "en"

vim.o.shiftround = true

vim.o.virtualedit = "block"

vim.cmd([[set formatoptions+=mM]])

-- use tilde as an operator
vim.o.tildeop = true

vim.o.joinspaces = false

vim.o.synmaxcol = 200
vim.o.startofline = false

vim.cmd([[
  if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif
]])

vim.o.signcolumn = "auto:2"

vim.cmd([[set isfname-==
set isfname-=,
set whichwrap+=<,>,h,l
set wrap
set formatoptions+=t]])

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.numberwidth = 6

vim.cmd([[set mouse+=a]])