-- Disable Python2 support
vim.g.loaded_python_provider = 0

-- Disable perl provider
vim.g.loaded_perl_provider = 0

-- Disable ruby provider
vim.g.loaded_ruby_provider = 0

-- Disable node provider
vim.g.loaded_node_provider = 0

-- do not load menu
vim.g.did_install_default_menus = 1

vim.g.python3_host_prog = "/home/guilt/miniconda3/bin/python3"

vim.g.vimsyn_embed = "l"

-- Disable loading certain plugins
-- Whether to load netrw by default, see
-- https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.netrw_liststyle = 3

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Set leader to comma
vim.api.nvim_set_keymap("", "Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","
