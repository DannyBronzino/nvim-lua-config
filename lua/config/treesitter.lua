vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_motion_enabled = 0
vim.g.matchup_text_obj_enabled = 0
vim.g.matchup_matchparen_hi_surround_always = 1 -- highlights surrounding matches always
vim.g.matchup_transmute_enabled = 1 -- easy change of tags

vim.g.matchup_matchparen_deferred = 1 -- improve performance
vim.g.matchup_matchparen_timeout = 100 -- improve performance
vim.g.matchup_matchparen_insert_timeout = 30 -- improve performance
vim.g.matchup_delim_noskips = 0 -- whether to enable matching inside comment or string
vim.g.matchup_matchparen_offscreen = { method = "popup" } -- show offscreen match pair in popup window

require("nvim-treesitter.configs").setup({
  ensure_installed = { "latex", "bibtex", "markdown" },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "latex", "bibtex" },
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      node_decremental = "grn",
      -- scope_incremental = "gns",
    },
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = {}, -- optional, list of language that will be disabled
    -- [options]
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@class.outer", -- move to chapter/section in latex
        ["]s"] = "@statement.outer", -- move to commands
      },
      goto_next_end = {
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@class.outer",
        ["[s"] = "@statement.outer",
      },
      goto_previous_end = {
        ["[]"] = "@class.outer",
      },
    },
  },
})

-- override bibtex query
require("vim.treesitter.query").set_query("bibtex", "textobjects", "(entry) @class.outer (field) @statement.outer")

-- let treesitter handle folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
