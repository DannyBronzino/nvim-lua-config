local package_home = vim.fn.stdpath("data") .. "/site/pack/packer/" -- set directory for packages
local packer_install_path = package_home .. "/opt/packer.nvim"
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_install_path)
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function(use)
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
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
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = function()
        require("config.treesitter")
      end,
      run = ":TSUpdate",
    })

    use({ -- completion engine
      "hrsh7th/nvim-cmp",
      requires = {
        "onsails/lspkind-nvim", -- vscode pictograms,
        {
          "L3MON4D3/LuaSnip",
          requires = {
            "rafamadriz/friendly-snippets", -- vscode format snippets
            { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
          },
          config = function()
            require("config.luasnip")
          end,
        },
        { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
        { "hrsh7th/cmp-path", event = { "CmdLineEnter", "InsertEnter" } }, -- completion for path
        { "hrsh7th/cmp-buffer", event = "CmdLineEnter" }, -- completion for buffer contents
        { "hrsh7th/cmp-cmdline", event = "CmdLineEnter" }, -- completion for cmdline
        { "lukas-reineke/cmp-rg", event = "InsertEnter" }, -- completion for ripgrep
        { "f3fora/cmp-spell", event = "InsertEnter" }, -- completion for spell
        { "kdheepak/cmp-latex-symbols", event = "InsertEnter" }, -- easy to enter latex symbols
        { "dmitmel/cmp-digraphs", event = "InsertEnter", disable = true }, -- completion for digraphs
      },
      config = function()
        require("config.cmp")
      end,
      event = "BufEnter",
    })

    use({ -- interface for easy LSP configs
      "williamboman/nvim-lsp-installer",
      requires = {
        { "tami5/lspsaga.nvim" }, -- nice lsp actions
        { "neovim/nvim-lspconfig" }, -- easy lspconfig
        { "vigoux/ltex-ls.nvim" },
      },
      config = function()
        require("config.lsp")
      end,
      after = "nvim-cmp",
    })

    use({
      "abecodes/tabout.nvim",
      wants = "nvim-treesitter", -- or require if not used so far
      config = function()
        require("config.tabout")
      end,
      event = "InsertEnter",
    })

    use({ -- automatic pairs
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs")
      end,
      event = "InsertEnter",
    })

    -- additional powerful text object for vim, this plugin should be studied carefully to use its full power
    use({ "wellle/targets.vim", event = "BufEnter" })

    -- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
    use({
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

    -- colorscheme based on Hokusai
    use({
      "rebelot/kanagawa.nvim",
      config = function()
        require("config.kanagawa")
      end,
      event = "BufEnter",
    })

    use({ -- status line
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons", -- icons, duh
      },
      config = function()
        require("config.lualine")
      end,
      after = "kanagawa.nvim",
    })

    use({ -- tab bar and buffer switching
      "romgrk/barbar.nvim",
      requires = "kyazdani42/nvim-web-devicons", -- icons, duh
      config = function()
        require("config.barbar")
      end,
      after = "kanagawa.nvim", -- needs to be after or the colorscheme doesn't apply
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

    -- exit insert mode with jj or jk or whatever
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
      event = "InsertEnter",
    })

    -- LSP doesn't do formatting on some languages so use this
    use({
      "sbdchd/neoformat",
      cmd = "Neoformat",
    })

    -- git in the gutter
    use({
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim", -- extra neovim functions
      config = function()
        require("gitsigns").setup()
      end,
      event = "BufEnter",
    })

    -- git inside vim
    use({
      "tpope/vim-fugitive",
      setup = function()
        vim.keymap.set("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>") -- commit current file
      end,
      cmd = "Git",
    })

    -- fuzzy search utilizing fzf
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { -- interface for fzf
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        "nvim-telescope/telescope-symbols.nvim", -- emojis and other symbols
      },
      setup = function()
        -- use find_files if not in git project
        local project_files = function(opts)
          local ok = pcall(require("telescope.builtin").git_files, opts)
          if not ok then
            require("telescope.builtin").find_files(opts)
          end
        end

        local map = require("utils").map

        map("n", "<leader><space>", function()
          require("telescope.builtin").buffers()
        end, { desc = "display open buffers with telescope" })

        map("n", "<leader>ff", function()
          project_files(require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } }))
        end, { desc = "display project files with telescope" })

        map("n", "<leader>fb", function()
          require("telescope.builtin").current_buffer_fuzzy_find({ layout_strategy = "bottom_pane" })
        end, { desc = "current buffer fuzzy find with telescope" })

        map("n", "<leader>fh", function()
          require("telescope.builtin").help_tags({ layout_strategy = "bottom_pane" })
        end, { desc = "display help topics with telescope" })

        map("n", "<leader>fd", function()
          require("telescope.builtin").grep_string({ layout_strategy = "bottom_pane" })
        end, { desc = "grep string with telescope" })

        map("n", "<leader>fg", function()
          require("telescope.builtin").live_grep({ layout_strategy = "bottom_pane" })
        end, { desc = "live grep with telescope" })

        map("n", "<leader>?", function()
          require("telescope.builtin").oldfiles({ layout_strategy = "bottom_pane" })
        end, { desc = "display recent files with telescope" })

        map("n", "<leader>ft", function()
          require("telescope.builtin").tags({ layout_strategy = "bottom_pane" })
        end, { desc = "display tags with telescope" })
      end,
      config = function()
        require("config.telescope")
      end,
      module = "telescope",
    })

    -- better quickfix window
    use({
      "kevinhwang91/nvim-bqf",
      config = [[require("config.bqf")]],
      ft = "qf",
    })

    -- creates missing directories when saving a new file
    use({
      "jghauser/mkdir.nvim",
      event = "CmdLineEnter",
    })

    -- file browser/picker
    use({
      "luukvbaal/nnn.nvim",
      setup = function()
        local map = require("utils").map

        map("n", "<space>n", "<cmd>NnnPicker<cr>", { desc = "toggles NNN picker" })
      end,
      config = function()
        require("config.nnn")
      end,
      cmd = { "NnnPicker", "NnnExplorer" },
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
