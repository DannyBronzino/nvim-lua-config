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
    config = true,
  },

  -- git in the gutter
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
