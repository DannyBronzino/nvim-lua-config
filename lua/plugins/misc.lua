return {
  -- icons used in multiple other plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- allows using <tab> in Insert to jump out of brackets or quotes
  {
    "abecodes/tabout.nvim",
    config = function()
      require("config.tabout")
    end,
    -- after = "nvim-treesitter",
    event = "InsertEnter",
  },

  -- divides words into smaller chunks
  -- e.g. camelCase becomes (camel) (Case) when using w motion
  {
    "chaoren/vim-wordmotion",
    lazy = false,
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

  -- rename files in neovim
  {
    "elihunter173/dirbuf.nvim",
    cmd = { "Dirbuf", "DirbufQuit", "DirbufSync" },
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
