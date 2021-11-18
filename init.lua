-- sources
require("plugins")
require("options")
require("globals")

vim.cmd([[
let g:config_files = [
      \ 'autocommands.vim',
      \ 'mappings.vim',
      \ 'plugins.vim',
      \ 'themes.vim'
      \ ]

for s:fname in g:config_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor]])

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd([[colorscheme dracula]])

-- source config.lualine when colorscheme changes
vim.cmd([[
autocmd colorscheme * source ~/.config/nvim/lua/config/lualine.lua
]])
