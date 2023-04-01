return {
  -- icons used in multiple other plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- file manager plugin
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = true,
  },

  -- allows using <tab> in Insert to jump out of brackets or quotes
  {
    "abecodes/tabout.nvim",
    dependencies = "nvim-treesitter",
    opts = {
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    },
    event = "InsertEnter",
    enabled = false,
  },

  -- divides words into smaller chunks
  -- e.g. camelCase becomes (camel) (Case) when using w motion
  {
    "chaoren/vim-wordmotion",
    lazy = false,
    enabled = false,
  },

  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "x", "o" },
        desc = "Spider-w",
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "x", "o" },
        desc = "Spider-b",
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "x", "o" },
        desc = "Spider-e",
      },
      {
        "ge",
        "<cmd>lua require('spider').motion('ge')<CR>",
        mode = { "n", "x", "o" },
        desc = "Spider-ge",
      },
    },
  },

  -- exit Insert mode with jj or jk or whatever
  {
    "max397574/better-escape.nvim",
    opts = {
      -- lua, default settings
      mapping = { "jk", "jj" },
      -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      timeout = 300,
      -- clear line after escaping if there is only whitespace
      clear_empty_lines = false,
      -- function for exiting
      keys = function()
        return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
      end,
    },
    event = "InsertEnter",
  },

  -- git in the gutter
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },

  -- better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      auto_resize_height = false,
      preview = {
        auto_preview = false,
      },
    },
    ft = "qf",
  },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 15,
      buffers = {
        left = { enabled = false },
      },
    },
    cmd = "NoNeckPain",
  },
}
