-- Disable Python2 support
vim.g.loaded_python_provider = 0

vim.g.loaded_perl_provider = 0 -- Disable perl provider

vim.g.loaded_ruby_provider = 0 -- Disable ruby provider

vim.g.loaded_node_provider = 0 -- Disable node provider

vim.g.did_install_default_menus = 1 -- do not load menu

vim.g.python3_host_prog = "/usr/bin/python3" -- location of python3

-- Disable loading certain plugins
-- Whether to load netrw by default, see
-- https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.netrw_liststyle = 3

-- folding
vim.g.markdown_folding = 1
vim.g.tex_fold_enabled = 1
