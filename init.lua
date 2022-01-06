-- sources
require("plugins")
require("options")
require("globals")
require("colorschemes")
require("utils")

vim.cmd([[
let g:config_files = [
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ 'wilder.vim',
      \ ]

for s:fname in g:config_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor]])
