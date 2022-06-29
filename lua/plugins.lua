vim.g.package_home = vim.fn.stdpath("data") .. "/site/pack/packer/" -- set directory for packages
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim" -- set packer installation directory
local packer_repo = "https://github.com/wbthomason/packer.nvim" -- packer repo location
local packer_install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir) -- installation command

-- Auto-install packer in case it hasn't been installed.
if vim.fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(packer_install_cmd)
end

local impatient_install_dir = vim.g.package_home .. "/opt/impatient.nvim" -- set impatient installation directory
local impatient_repo = "https://github.com/lewis6991/impatient.nvim" -- impatient repo location
local impatient_install_cmd = string.format(
  "10split |term git clone --depth=1 %s %s",
  impatient_repo,
  impatient_install_dir
) -- installation command

-- Auto-install impatient in case it hasn't been installed.
if vim.fn.glob(impatient_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing impatient.nvim", "Type" } }, true, {})
  vim.cmd(impatient_install_cmd)
end

-- load impatient.nvim
vim.cmd("packadd impatient.nvim")
require("impatient")

-- load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require("packer.util")

require("packer").startup({
  function(use)
    use({ -- impatient itself
      "lewis6991/impatient.nvim",
      opt = true,
    })

    use({ -- packer itself, can be optional
      "wbthomason/packer.nvim",
      opt = true,
    })

    use({ -- syntax highlighting, folding, and more... doesn't always load if you make it optional (i.e. use an event)
      "nvim-treesitter/nvim-treesitter",
      requires = {
        {
          "andymass/vim-matchup",
          config = function()
            require("config.matchup")
          end,
        }, -- matching parens
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = function()
        require("config.treesitter")
      end,
      run = ":TSUpdateSync",
    })

    use({ -- snippet engine
      "L3MON4D3/LuaSnip",
      requires = "rafamadriz/friendly-snippets", -- vscode format snippets
      event = "BufEnter",
    })

    use({ -- completion engine
      "hrsh7th/nvim-cmp",
      requires = {
        "onsails/lspkind-nvim", -- vscode pictograms,
        {
          "L3MON4D3/LuaSnip",
          requires = "rafamadriz/friendly-snippets", -- vscode format snippets
          config = function()
            require("config.luasnip")
          end,
        },
      },
      config = function()
        require("config.cmp")
      end,
      event = "BufEnter",
    })

    use({ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }) -- completion for LuaSnip
    use({ "hrsh7th/cmp-path", event = { "CmdLineEnter", "InsertEnter" } }) -- completion for path
    use({ "hrsh7th/cmp-buffer", event = "CmdLineEnter" }) -- completion for buffer contents
    use({ "hrsh7th/cmp-cmdline", event = "CmdLineEnter" }) -- completion for cmdline

    use({ "lukas-reineke/cmp-rg", event = "InsertEnter" }) -- completion for ripgrep

    use({ "f3fora/cmp-spell", event = "InsertEnter" }) -- completion for spell
    use({ "kdheepak/cmp-latex-symbols", event = "InsertEnter" }) -- easy to enter latex symbols
    use({ "dmitmel/cmp-digraphs", event = "InsertEnter", disable = true }) -- completion for digraphs

    -- Lua
    use({
      "abecodes/tabout.nvim",
      requires = { "nvim-treesitter" }, -- or require if not used so far
      config = function()
        require("config.tabout")
      end,
      after = "nvim-cmp", -- if a completion plugin is using tabs load it before
    })

    use({ -- interface for easy LSP configs
      "williamboman/nvim-lsp-installer",
      requires = {
        { "tami5/lspsaga.nvim" }, -- nice lsp actions
        { "neovim/nvim-lspconfig" }, -- easy lspconfig
        { "lukas-reineke/lsp-format.nvim" },
        { "hrsh7th/cmp-nvim-lsp", event = { "CmdLineEnter", "InsertEnter" } }, -- completion for LSP
        {
          "hrsh7th/cmp-nvim-lsp-signature-help",
          event = { "CmdLineEnter", "InsertEnter" }, -- signature help in completion menu
        },
      },
      config = function()
        require("config.lsp-installer")
      end,
      after = "nvim-cmp",
    })

    use({ -- automatic pairs
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs")
      end,
      event = "InsertEnter",
    })

    use({ "wellle/targets.vim", event = "BufEnter" }) -- additional powerful text object for vim, this plugin should be studied carefully to use its full power

    use({ -- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
      "chaoren/vim-wordmotion",
      event = "BufEnter",
    })

    use({
      "echasnovski/mini.nvim",
      config = function()
        require("mini.surround").setup({
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            add = "<space>sa", -- Add surrounding in Normal and Visual modes
            delete = "<space>sd", -- Delete surrounding
            find = "", -- Find surrounding (to the right)
            find_left = "", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            replace = "<space>sr", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`
          },
        })
      end,
      event = "BufEnter",
    })

    use({ -- buffer jumping like EasyMotion or Sneak
      "ggandor/leap.nvim",
      requires = "tpope/vim-repeat",
      config = function()
        require("leap").set_default_keymaps()
      end,
      event = "BufEnter",
    })

    use({ -- Show match number and index for search
      "kevinhwang91/nvim-hlslens",
      requires = "haya14busa/vim-asterisk", -- asterisk improved
      config = function()
        require("config.hlslens")
      end,
      keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
      event = "CmdLineEnter",
    })

    use({ -- tab bar and buffer switching
      "romgrk/barbar.nvim",
      requires = "kyazdani42/nvim-web-devicons", -- icons, duh
      config = function()
        require("config.barbar")
      end,
      event = "BufEnter",
    })

    use({ -- status line
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons", -- icons, duh
        {
          "rebelot/kanagawa.nvim",
          config = function()
            require("config.kanagawa")
            vim.cmd([[colorscheme kanagawa]])
          end,
        },
      },
      config = function()
        require("config.ui")
      end,
      event = "WinEnter",
    })

    use({ -- indent markers
      "lukas-reineke/indent-blankline.nvim",
      event = "BufEnter",
    })

    use({ -- notification plugin
      "rcarriga/nvim-notify",
      config = function()
        local nvim_notify = require("notify")
        nvim_notify.setup({
          -- Render style
          render = "minimal",
          -- Animation style
          stages = "slide",
          -- Default timeout for notifications
          timeout = 300,
        })

        vim.notify = nvim_notify
      end,
      event = "VimEnter",
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
      config = function()
        require("config.telescope")
      end,
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
      config = function()
        require("config.nnn")
      end,
      event = "BufEnter",
    })

    use({ -- file explorer
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
      config = function()
        require("config.nvim-tree")
      end,
      event = "BufEnter",
      disable = true,
    })

    use({
      "elihunter173/dirbuf.nvim",
      cmd = { "Dirbuf", "DirbufQuit", "DirbufSync" },
    })

    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which-key")
      end,
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
