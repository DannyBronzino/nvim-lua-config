require("impatient") -- load impatient first

-- lua sources
require("plugins")
require("options")
require("globals")
require("mappings")
require("autocmds")
require("utils")

-- vimscript sources
vim.cmd([[
let g:config_files = [
      \ 'mappings.vim',
      \ ]

for s:fname in g:config_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor]])

vim.cmd([[colorscheme kanagawa]]) -- colorscheme