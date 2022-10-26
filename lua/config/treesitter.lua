require("nvim-treesitter.configs").setup({
  ensure_installed = { "latex", "bibtex", "markdown", "markdown_inline", "vim", "regex", "bash" },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "latex", "bibtex" },
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
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
      enable = false,
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
