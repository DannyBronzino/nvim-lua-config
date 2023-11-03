return {
  -- icons used in multiple other plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
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
}
