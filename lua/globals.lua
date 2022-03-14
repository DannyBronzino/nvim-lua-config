-- Disable Python2 support
vim.g.loaded_python_provider = 0

vim.g.loaded_perl_provider = 0 -- Disable perl provider

vim.g.loaded_ruby_provider = 0 -- Disable ruby provider

vim.g.loaded_node_provider = 0 -- Disable node provider

vim.g.did_install_default_menus = 1 -- do not load menu

vim.g.python3_host_prog = "~/miniconda3/bin/python3" -- location of python3

-- Disable loading certain plugins
-- Whether to load netrw by default, see
-- https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.netrw_liststyle = 3

vim.g.loaded_2html_plugin = 1 -- Do not load tohtml.vim

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_tutor_mode_plugin = 1 -- do not load the tutor plugin

-- do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.matchup_motion_enabled = 0

vim.g.matchup_matchparen_offscreen = { method = "popup" } -- matchup floating match

-- folding
vim.g.markdown_folding = 1
vim.g.tex_fold_enabled = 1