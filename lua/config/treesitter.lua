require("nvim-treesitter.configs").setup({
  ensure_installed = { "latex", "bibtex", "markdown", "markdown_inline", "lua", "python", "scheme" },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {},
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
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

require("vim.treesitter.query").set_query("bibtex", "textobjects", "(entry) @class.outer") -- override bibtex query

-- let treesitter handle folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
