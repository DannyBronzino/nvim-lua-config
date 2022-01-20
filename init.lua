-- lua sources
require("plugins")
require("options")
require("globals")
require("colorschemes")
require("utils")

-- vimscript sources
vim.cmd([[
let g:config_files = [
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ ]

for s:fname in g:config_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor]])
