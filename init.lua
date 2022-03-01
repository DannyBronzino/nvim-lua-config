-- load impatient first
require("impatient")

-- lua sources
require("plugins")
require("options")
require("globals")
require("plugin_settings")
require("colorschemes")
require("utils")

-- vimscript sources
vim.cmd([[
let g:config_files = [
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ ]

for s:fname in g:config_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor]])
