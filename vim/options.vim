scriptencoding utf-8

set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

set splitbelow splitright

set updatetime=100

" if !empty(provider#clipboard#Executable())
"   set clipboard+=unnamedplus
" endif

set noswapfile

let g:backupdir=expand(stdpath('data') . '/backup')
if !isdirectory(g:backupdir)
   call mkdir(g:backupdir, 'p')
endif
let &backupdir=g:backupdir

set backup
set backupcopy=yes

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

set number relativenumber

set ignorecase smartcase

set fileencoding=utf-8

set linebreak
set showbreak=↪

set wildmode=list:longest

set noshowmode

set fileformats=unix

set inccommand=nosplit

set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase

set visualbell noerrorbells
set history=500

set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

set undofile

set shortmess+=c

set spelllang=en,cjk  " Spell languages

set shiftround

set virtualedit=block

set formatoptions+=mM

set tildeop

set nojoinspaces

set synmaxcol=200
set nostartofline

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

set signcolumn=auto:2

set isfname-==
set isfname-=,

set whichwrap+=<,>,h,l
set wrap
set formatoptions+=t

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set numberwidth=6

set mouse+=a
