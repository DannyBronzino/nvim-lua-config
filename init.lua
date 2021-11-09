-- sources
require("plugins")
require("options")

vim.cmd([[
let g:config_files = [
      \ 'globals.vim',
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ 'themes.vim'
      \ ]

for s:fname in g:config_files
  execute printf('source %s/core/%s', stdpath('config'), s:fname)
endfor]])

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme dracula]])
