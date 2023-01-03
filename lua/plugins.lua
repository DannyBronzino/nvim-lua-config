return {
  -- highlights matching pairs
  {
    "andymass/vim-matchup",
    lazy = true,
    init = function()
      require("config.matchup")
    end,
  },

  -- syntax highlighting, folding, and more...
  -- doesn't always load if you make it optional (i.e. use an event)
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- more textobjects
      "nvim-treesitter/nvim-treesitter-textobjects",
      "vim-matchup",
    },
    config = function()
      require("config.treesitter")
    end,
    -- first run this will throw an error you can ignore
    build = ":TSUpdate",
    -- after = "vim-matchup",
  },

  -- vimtex, for latex editing
  {
    "lervag/vimtex",
    config = function()
      local map = require("utils").map

      -- open LaTeX documentation in browser
      map("n", "<c-k>", [[<plug>(vimtex-doc-package)]])

      -- set up TOC
      vim.g.vimtex_toc_config = {
        layer_status = { include = 0 },
        split_pos = "vert rightbelow",
        split_width = 30,
        show_help = 0,
      }
    end,
    ft = { "tex", "bibtex" },
  },

  -- snippet engine
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("config.luasnip")
    end,
    event = "InsertEnter",
  },

  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = {
      "onsails/lspkind-nvim",
    },
    config = function()
      require("config.cmp")
    end,
  },

  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter", enabled = false },

  { "hrsh7th/cmp-omni", event = "InsertEnter" },

  { "dmitmel/cmp-digraphs", event = "InsertEnter", enabled = false },

  { "hrsh7th/cmp-path", event = { "InsertEnter", "CmdLineEnter" } },

  { "hrsh7th/cmp-cmdline", event = "CmdLineEnter" },

  { "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdLineEnter" } },

  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },

  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function()
      require("config.fzf-lua")
      require("config.fzf_mappings")
      require("fzf-lua").register_ui_select()
    end,
  },

  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = {
          -- Render style
          render = "minimal",
          -- Animation style
          stages = "slide",
          -- Default timeout for notifications
          timeout = 300,
        },
      },
    },
    config = function()
      require("config.noice")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "barreiroleo/ltex_extra.nvim",
    },
    config = function()
      require("config.lspconfig")
    end,
    ft = { "tex", "bib" },
  },

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

  -- automatic pair insertion while typing
  {
    "windwp/nvim-autopairs",
    config = function()
      require("config.autopairs")
    end,
    event = "InsertEnter",
  },

  -- swiss army knife
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({}) -- adds more textobjects
      require("mini.misc").setup({}) -- miscellaneous functions
      -- require("mini.animate").setup({}) -- animations
      require("mini.trailspace").setup({}) -- identify and remove trailing spaces
      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*",
        group = vim.api.nvim_create_augroup("MiniTrailSpace", { clear = true }),
        callback = function()
          require("mini.trailspace").trim()
          require("mini.trailspace").trim_last_lines()
        end,
        desc = "trim empty spaces and lines",
      })
    end,
  },

  -- divides words into smaller chunks
  -- e.g. camelCase becomes (camel) (Case) when using w motion
  {
    "chaoren/vim-wordmotion",
    lazy = false,
  },

  -- surround stuff
  {
    "kylechui/nvim-surround",
    config = function()
      require("config.nvim-surround")
    end,
  },

  -- easymotion type thing
  {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = "tpope/vim-repeat",
    config = function()
      require("config.leap")
    end,
  },

  {
    "ggandor/flit.nvim",
    lazy = false,
    dependencies = "leap.nvim",
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "nvo",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {},
      })
    end,
  },

  {
    "ggandor/leap-spooky.nvim",
    lazy = false,
    dependencies = "leap.nvim",
    config = true,
  },

  -- Show match number and index for search
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.hlslens")
    end,
    keys = {
      { "*", mode = "n" },
      { "#", mode = "n" },
      { "n", mode = "n" },
      { "N", mode = "n" },
    },
    event = "CmdLineEnter",
  },

  -- colorscheme based on hokusai
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    name = "kanagawa",
    config = function()
      require("config.kanagawa")
    end,
    enabled = false,
  },

  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    name = "onenord",
    config = function()
      require("config.onenord")
    end,
    enabled = false,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("config.catppuccin")
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("config.lualine")
    end,
  },

  -- tab bar and buffer switching
  {
    "romgrk/barbar.nvim",
    lazy = false,
    config = function()
      require("config.barbar")
    end,
  },

  -- exit Insert mode with jj or jk or whatever
  {
    "max397574/better-escape.nvim",
    config = {
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
    config = function()
      require("config.bqf")
    end,
    ft = "qf",
  },

  -- rename files in neovim
  {
    "elihunter173/dirbuf.nvim",
    cmd = { "Dirbuf", "DirbufQuit", "DirbufSync" },
  },

  -- shows you which key comes next
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      require("config.which-key")
    end,
  },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = {
      width = 15,
      buffers = {
        left = { enabled = false },
      },
    },
    cmd = "NoNeckPain",
  },
}
