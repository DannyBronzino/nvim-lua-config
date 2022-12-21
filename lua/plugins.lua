local package_home = vim.fn.stdpath("data") .. "/site/pack/packer/"

local packer_install_path = package_home .. "/opt/packer.nvim"

local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_install_path)
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function(use)
    -- speeds up loading
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    })

    -- packer itself, can be optional since it's manually loaded
    use({
      "wbthomason/packer.nvim",
      opt = true,
    })

    -- highlights matching pairs
    use({
      "andymass/vim-matchup",
      setup = function()
        require("config.matchup")
      end,
    })

    -- syntax highlighting, folding, and more...
    -- doesn't always load if you make it optional (i.e. use an event)
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        -- more textobjects
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = function()
        require("config.treesitter")
      end,
      -- first run this will throw an error you can ignore
      run = ":TSUpdate",
      after = "vim-matchup",
    })

    -- vscode pictograms
    use({
      "onsails/lspkind-nvim",
      module = "lspkind",
    })

    -- vscode format snippets
    use({
      "rafamadriz/friendly-snippets",
      module = "luasnip.loaders.from_vscode",
    })

    -- snippet engine
    use({
      "L3MON4D3/LuaSnip",
      config = function()
        require("config.luasnip")
      end,
      module = "luasnip",
    })

    -- vimtex, for latex editing
    use({
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
    })

    -- completion engine
    use({
      "hrsh7th/nvim-cmp",
      requires = {},
      config = function()
        require("config.cmp")
      end,
    })

    -- completion for paths
    use({
      "hrsh7th/cmp-path",
      event = {
        "CmdLineEnter",
        "InsertEnter",
      },
      after = "nvim-cmp",
    })

    -- completion for luasnip
    use({
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
      after = "nvim-cmp",
    })

    -- completion for buffer contents
    use({
      "hrsh7th/cmp-buffer",
      event = "CmdLineEnter",
      after = "nvim-cmp",
    })

    -- completion for cmdline
    use({
      "hrsh7th/cmp-cmdline",
      event = "CmdLineEnter",
      after = "nvim-cmp",
    })

    -- completion for ripgrep
    use({
      "lukas-reineke/cmp-rg",
      event = "InsertEnter",
      after = "nvim-cmp",
    })

    -- completion for digraphs, very annoying
    use({
      "dmitmel/cmp-digraphs",
      event = "InsertEnter",
      after = "nvim-cmp",
      disable = true,
    })

    -- easy to enter symbols using latex codes
    use({
      "kdheepak/cmp-latex-symbols",
      event = "InsertEnter",
      after = "nvim-cmp",
    })

    -- source for lsp completions
    use({
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
      after = "nvim-cmp",
      module = "cmp_nvim_lsp",
    })

    use({
      "ibhagwan/fzf-lua",
      -- optional for icon support
      config = function()
        require("config.fzf-lua")
        require("config.fzf_mappings")
        require("fzf-lua").register_ui_select()
      end,
    })

    use({
      "folke/noice.nvim",
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        {
          "rcarriga/nvim-notify",
          config = function()
            require("notify").setup({
              -- Render style
              render = "minimal",
              -- Animation style
              stages = "slide",
              -- Default timeout for notifications
              timeout = 300,
            })
          end,
        },
      },
      config = function()
        require("config.noice")
      end,
      event = "VimEnter",
    })

    use({
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "barreiroleo/ltex_extra.nvim",
      },
      config = function()
        require("config.lspconfig")
      end,
      after = "fzf-lua",
    })

    use({
      "utilyre/barbecue.nvim",
      requires = {
        "smiteshp/nvim-navic",
      },
      config = function()
        require("barbecue").setup()
      end,
      after = "nvim-lspconfig",
    })

    -- icons used by everything
    use({
      "nvim-tree/nvim-web-devicons",
      module = "nvim-web-devicons",
    })

    -- allows using <tab> in Insert to jump out of brackets or quotes
    use({
      "abecodes/tabout.nvim",
      config = function()
        require("config.tabout")
      end,
      after = "nvim-treesitter",
      event = "InsertEnter",
    })

    -- automatic pair insertion while typing
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs")
      end,
      event = "InsertEnter",
    })

    -- additional powerful text object for vim, this plugin should be studied carefully to use its full power
    -- use({
    -- "wellle/targets.vim",
    -- })

    -- swiss army knife
    use({
      "echasnovski/mini.nvim",
      config = function()
        require("mini.ai").setup({}) -- adds more textobjects
        require("mini.misc").setup({}) -- miscellaneous functions
        require("mini.trailspace").setup({}) -- identify and remove trailing spaces
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
          pattern = "*",
          group = vim.api.nvim_create_augroup("MiniTrailSpace", { clear = true }),
          callback = function()
            MiniTrailspace.trim()
            MiniTrailspace.trim_last_lines()
          end,
          desc = "trim empty spaces and lines",
        })
      end,
    })

    -- divides words into smaller chunks
    -- e.g. camelCase becomes (camel) (Case) when using w motion
    use({
      "chaoren/vim-wordmotion",
    })

    -- surround stuff
    use({
      "kylechui/nvim-surround",
      config = function()
        require("config.nvim-surround")
      end,
    })

    -- easymotion type thing
    use({
      "ggandor/leap.nvim",
      requires = "tpope/vim-repeat",
      config = function()
        require("config.leap")
      end,
      event = "BufEnter",
    })

    use({
      "ggandor/flit.nvim",
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
      after = "leap.nvim",
    })

    use({
      "ggandor/leap-spooky.nvim",
      config = function()
        require("leap-spooky").setup()
      end,
      after = "leap.nvim",
    })

    -- Show match number and index for search
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("config.hlslens")
      end,
      keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
      event = "CmdLineEnter",
    })

    -- colorscheme based on hokusai
    use({
      "rebelot/kanagawa.nvim",
      as = "kanagawa",
      config = function()
        require("config.kanagawa")
      end,
      disable = true,
    })

    use({
      "rmehri01/onenord.nvim",
      as = "onenord",
      config = function()
        require("config.onenord")
      end,
      disable = true,
    })

    use({
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        require("config.catppuccin")
      end,
      event = "VimEnter",
    })

    -- status line
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("config.lualine")
      end,
      after = "catppuccin",
    })

    -- tab bar and buffer switching
    use({
      "romgrk/barbar.nvim",
      config = function()
        require("config.barbar")
      end,
      after = "lualine.nvim",
    })

    -- exit Insert mode with jj or jk or whatever
    use({
      "max397574/better-escape.nvim",
      config = function()
        -- lua, default settings
        require("better_escape").setup({
          mapping = { "jk", "jj" },
          -- the time in which the keys must be hit in ms. Use option timeoutlen by default
          timeout = 300,
          -- clear line after escaping if there is only whitespace
          clear_empty_lines = false,
          -- function for exiting
          keys = function()
            return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
          end,
        })
      end,
      event = "InsertEnter",
    })

    -- git in the gutter
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitsigns").setup()
      end,
      event = "BufEnter",
    })

    -- better quickfix window
    use({
      "kevinhwang91/nvim-bqf",
      config = function()
        require("config.bqf")
      end,
      ft = "qf",
    })

    -- rename files in neovim
    use({
      "elihunter173/dirbuf.nvim",
      cmd = { "Dirbuf", "DirbufQuit", "DirbufSync" },
    })

    -- shows you which key comes next
    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key")
      end,
    })

    use({
      "shortcuts/no-neck-pain.nvim",
      tag = "*",
      config = function()
        require("no-neck-pain").setup({
          width = 20,
          buffers = {
            left = false,
          },
        })
      end,
    })

    if is_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    autoremove = true,
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})
