-- automatically open list after neomake
vim.g.neomake_open_list = 2

-- vim-matchup settings
-- improve performance
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_timeout = 100
vim.g.matchup_matchparen_insert_timeout = 30
-- enhanced matching with matchup plugin
vim.g.matchup_override_vimtex = 1
-- whether to enable matching inside comment or string
vim.g.matchup_delim_noskips = 0
-- show offscreen match pair in popup window
vim.g.matchup_matchparen_offscreen = { method = "popup" }
