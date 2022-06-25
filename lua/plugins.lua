vim.g.package_home = vim.fn.stdpath("data") .. "/site/pack/packer/" -- set directory for packages
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim" -- set packer installation directory
local packer_repo = "https://github.com/wbthomason/packer.nvim" -- packer repo location
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir) -- installation command

-- Auto-install packer in case it hasn't been installed.
if vim.fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require("packer.util")

require("packer").startup({
  function(use)
    -- NOTICE
    -- impatient will throw an error on the the next startup if you clear the catch
    -- run :PackerSync again and then restart to fix this
    use({ -- it is recommened to put impatient.nvim before any other plugins
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient") -- load impatient first
      end,
    })

    use({ -- packer itself, can be optional
      "wbthomason/packer.nvim",
      opt = true,
    })

    use({ -- syntax highlighting, folding, and more... doesn't always load if you make it optional (i.e. use an event)
      "nvim-treesitter/nvim-treesitter",
      requires = {
        { "andymass/vim-matchup" }, -- matching parens
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = [[require("config.treesitter")]],
      run = ":TSUpdateSync",
    })

    use({
      "L3MON4D3/LuaSnip",
      requires = "rafamadriz/friendly-snippets", -- vscode format snippets }) -- snippet engine
      event = "BufEnter",
    })

    use({ -- completion engine
      "hrsh7th/nvim-cmp",
      requires = "onsails/lspkind-nvim", -- vscode pictograms,
      config = [[require("config.cmp")]], -- contains luasnip setup as well
      after = "LuaSnip",
    })

    use({ "hrsh7th/cmp-omni", event = "InsertEnter" }) -- omni completion for vimtex

    use({ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }) -- completion for LuaSnip
    use({ "hrsh7th/cmp-nvim-lua", event = "InsertEnter", disable = true }) -- completion for neovim lua
    use({ "hrsh7th/cmp-path", event = { "CmdLineEnter", "InsertEnter" } }) -- completion for path
    use({ "hrsh7th/cmp-buffer", event = "CmdLineEnter" }) -- completion for buffer contents
    use({ "hrsh7th/cmp-cmdline", event = "CmdLineEnter" }) -- completion for cmdline

    use({ "lukas-reineke/cmp-rg", event = "InsertEnter" }) -- completion for ripgrep

    use({ "f3fora/cmp-spell", event = "InsertEnter" }) -- completion for spell
    use({ "kdheepak/cmp-latex-symbols", event = "InsertEnter" }) -- easy to enter latex symbols
    use({ "dmitmel/cmp-digraphs", event = "InsertEnter", disable = true }) -- completion for digraphs

    use({ -- interface for easy LSP configs
      "williamboman/nvim-lsp-installer",
      requires = {
        { "tami5/lspsaga.nvim" }, -- nice lsp actions
        { "neovim/nvim-lspconfig" }, -- easy lspconfig
        { "lukas-reineke/lsp-format.nvim" },
        { "hrsh7th/cmp-nvim-lsp" }, -- completion for LSP
        { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- signature help in completion menu
      },
      config = [[require("config.lsp-installer")]],
      after = "nvim-cmp",
    })

    use({ -- automatic pairs
      "windwp/nvim-autopairs",
      config = [[require("config.autopairs")]],
      event = "InsertEnter",
    })

    use({ "wellle/targets.vim", event = "BufEnter" }) -- additional powerful text object for vim, this plugin should be studied carefully to use its full power

    use({ -- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
      "chaoren/vim-wordmotion",
      event = "BufEnter",
    })

    use({ -- buffer jumping like EasyMotion or Sneak
      "ggandor/lightspeed.nvim",
      requires = "tpope/vim-repeat",
      config = function()
        require("lightspeed").setup({
          ignore_case = true,
        })
      end,
      event = "BufEnter",
      disable = true,
    })

    use({
      "phaazon/hop.nvim",
      branch = "v1",
      config = [[require("config.hop")]],
      event = "BufEnter",
    })

    use({
      "echasnovski/mini.nvim",
      config = function()
        require("mini.surround").setup({
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            add = "sa", -- Add surrounding in Normal and Visual modes
            delete = "sd", -- Delete surrounding
            find = "", -- Find surrounding (to the right)
            find_left = "", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            replace = "sr", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`
          },
        })
      end,
    })

    use({ -- Show match number and index for search
      "kevinhwang91/nvim-hlslens",
      requires = "haya14busa/vim-asterisk", -- asterisk improved
      config = [[require('config.hlslens')]],
      keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
      event = "CmdLineEnter",
    })

    use({ -- tab bar and buffer switching
      "romgrk/barbar.nvim",
      requires = "kyazdani42/nvim-web-devicons", -- icons, duh
      config = [[require("config.barbar")]],
      event = "VimEnter",
    })

    use({ -- status line
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons", -- icons, duh
        "sainnhe/sonokai",
        "rebelot/kanagawa.nvim",
        "projekt0n/github-nvim-theme",
      },
      config = [[require("config.ui")]],
    })

    use({ -- indent markers
      "lukas-reineke/indent-blankline.nvim",
      event = "BufEnter",
    })

    use({ -- notification plugin
      "rcarriga/nvim-notify",
      config = [[require("config.notify")]],
      event = "VimEnter",
    })

    use({ -- escape insert quickly with "jj" or "jk" or whatever
      "jdhao/better-escape.vim",
      setup = function() -- need to set options FIRST
        vim.g.better_escape_shortcut = "jj"
        vim.g.better_escape_interval = 300
      end,
      event = "InsertEnter",
      disable = true,
    })

    -- lua with packer.nvim
    use({
      "max397574/better-escape.nvim",
      config = function()
        -- lua, default settings
        require("better_escape").setup({
          mapping = { "jk", "jj" }, -- a table with mappings to use
          timeout = 300, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
          clear_empty_lines = false, -- clear line after escaping if there is only whitespace
          keys = function()
            return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
          end,
        })
      end,
    })

    use({ -- LSP doesn't do formatting on some languages so use this
      "sbdchd/neoformat",
      cmd = "Neoformat",
    })

    use({ -- git in the gutter
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim", -- extra neovim functions
      config = function()
        require("gitsigns").setup()
      end,
      event = "BufEnter",
    })

    use({ -- git inside vim
      "tpope/vim-fugitive",
      setup = function()
        vim.keymap.set("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>") -- commit current file
      end,
      cmd = "Git",
    })

    use({ -- Fixes scroll in middle of page (works poorly with soft wrapping)
      "vim-scripts/scrollfix",
      event = "BufEnter",
      disable = true,
    })

    use({ -- automatic window sizing
      "dm1try/golden_size",
      event = "WinEnter",
      disable = true,
    })

    use({ -- fuzzy search utilizing fzf
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" }, -- api for popups
        { "nvim-lua/plenary.nvim" }, -- extra neovim functions
        { -- fuzzy search
          "junegunn/fzf",
          run = function()
            vim.fn["fzf#install"]()
          end,
        },
        { -- interface for fzf
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        { "nvim-telescope/telescope-packer.nvim" }, -- packer browser
        { "nvim-telescope/telescope-symbols.nvim" }, -- emojis and other symbols
        { "benfowler/telescope-luasnip.nvim" }, -- luasnip browser
        { "ahmedkhalf/project.nvim" },
        { "sudormrfbin/cheatsheet.nvim", cmd = "Cheatsheet" }, -- list of commands
      },
      config = [[require("config.telescope")]],
      event = "BufEnter",
    })

    use({ -- better quickfix window
      "kevinhwang91/nvim-bqf",
      config = [[require("config.bqf")]],
      ft = "qf",
    })

    use({ -- creates missing directories when saving a new file
      "jghauser/mkdir.nvim",
      event = "CmdLineEnter",
    })

    use({
      "luukvbaal/nnn.nvim",
      config = [[require("config.nnn")]],
      event = "BufEnter",
    })

    use({ -- file explorer
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
      config = [[require("config.nvim-tree")]],
      event = "BufEnter",
      disable = true,
    })

    use({
      "elihunter173/dirbuf.nvim",
      event = "BufEnter",
    })

    use({
      "folke/which-key.nvim",
      config = [[require("config.which-key")]],
    })
  end,
  config = {
    compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
    autoremove = true,
  },
})

local status, _ = pcall(require, "packer_compiled")
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
