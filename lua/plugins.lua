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

    -- syntax highlighting, folding, and more...
    -- doesn't always load if you make it optional (i.e. use an event)
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        -- highlights matching pairs
        {
          "andymass/vim-matchup",
          config = function()
            require("config.matchup")
          end,
        },
        -- more textobjects
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      config = function()
        require("config.treesitter")
      end,
      -- first run this will throw an error you can ignore
      run = ":TSUpdate",
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
      event = "BufEnter",
    })

    use({
      "hrsh7th/cmp-omni",
      event = "InsertEnter",
    })

    -- completion for paths
    use({
      "hrsh7th/cmp-path",
      event = {
        "CmdLineEnter",
        "InsertEnter",
      },
    })

    -- completion for luasnip
    use({
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
    })

    -- completion for buffer contents
    use({
      "hrsh7th/cmp-buffer",
      event = "CmdLineEnter",
    })

    -- completion for cmdline
    use({
      "hrsh7th/cmp-cmdline",
      event = "CmdLineEnter",
    })

    -- completion for ripgrep
    use({
      "lukas-reineke/cmp-rg",
      event = "InsertEnter",
    })

    -- completion for digraphs, very annoying
    use({
      "dmitmel/cmp-digraphs",
      event = "InsertEnter",
      disable = true,
    })

    -- easy to enter symbols using latex codes
    use({
      "kdheepak/cmp-latex-symbols",
      event = "InsertEnter",
    })

    -- wrapper for ltex so you can use codeactions
    use({
      "vigoux/ltex-ls.nvim",
      module = "ltex-ls",
    })

    use({
      "williamboman/mason-lspconfig.nvim",
      requires = {
        "williamboman/mason.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = { "texlab", "ltex" } })
      end,
    })

    use({
      "ray-x/navigator.lua",
      requires = {
        {
          "ray-x/guihua.lua",
          run = "cd lua/fzy && make",
        },
        "neovim/nvim-lspconfig",
        {
          "hrsh7th/cmp-nvim-lsp",
          event = "InsertEnter",
        },
        wants = "nvim-treesitter",
      },
      config = function()
        require("config.navigator")
      end,
      event = "BufEnter",
    })

    use({
      "ibhagwan/fzf-lua",
      -- optional for icon support
      requires = { "kyazdani42/nvim-web-devicons" },
      setup = function()
        require("config.fzf_maps")
      end,
      config = function()
        require("config.fzf")
      end,
      -- event = "BufEnter",
      module = "fzf-lua",
      event = "CmdLineEnter",
    })

    -- allows using <tab> in Insert to jump out of brackets or quotes
    use({
      "abecodes/tabout.nvim",
      wants = "nvim-treesitter",
      config = function()
        require("config.tabout")
      end,
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
    use({
      "wellle/targets.vim",
      event = "BufEnter",
    })

    -- divides words into smaller chunks
    -- e.g. camelCase becomes (camel) (Case) when using w motion
    use({
      "chaoren/vim-wordmotion",
      event = "BufEnter",
    })

    -- several modules are available
    use({
      "echasnovski/mini.nvim",
      config = function()
        -- extends 'f' and 't'
        require("mini.jump").setup({})

        -- jump to beginning or ending of word via 2-character input
        -- activates with <cr>
        require("mini.jump2d").setup({})

        -- manipulate surrounding items
        require("mini.surround").setup({
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            -- Add surrounding in Normal and Visual modes
            add = "<space>sa",
            -- Delete surrounding
            delete = "<space>sd",
            -- Find surrounding (to the right)
            find = "",
            -- Find surrounding (to the left)
            find_left = "",
            -- Highlight surrounding
            highlight = "",
            -- Replace surrounding
            replace = "<space>sr",
            -- Update `n_lines`
            update_n_lines = "",
          },
        })
      end,
      event = "BufEnter",
    })

    --  buffer jumping like EasyMotion or Sneak
    use({
      "ggandor/leap.nvim",
      -- enhances dot repeat
      requires = "tpope/vim-repeat",
      config = function()
        require("leap").set_default_keymaps()
        require("leap").setup({
          highlight_unlabeled = true,
        })
        local map = require("utils").map

        map("n", "s", function()
          local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0))
          require("leap").leap({ target_windows = focusable_windows_on_tabpage })
        end, { desc = "changes leap's 's' to work bidirectionally on all visible buffers" })
      end,
      event = "BufEnter",
    })

    -- use({
    -- "rlane/pounce.nvim",
    -- config = function()
    -- local map = require("utils").map

    -- map({ "n", "v", "o" }, "s", "<cmd>Pounce<cr>")
    -- end,
    -- event = "BufEnter",
    -- })

    -- Show match number and index for search
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("config.hlslens")
      end,
      keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
      event = "CmdLineEnter",
    })

    -- asterisk improved
    use({
      "haya14busa/vim-asterisk",
      after = "nvim-hlslens",
    })

    -- colorscheme based on hokusai
    use({
      "rebelot/kanagawa.nvim",
      config = function()
        require("config.kanagawa")
      end,
    })

    use({
      "rmehri01/onenord.nvim",
      config = function()
        require("config.onenord")
        vim.cmd([[colorscheme onenord]])
      end,
    })

    -- status line
    use({
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("config.lualine")
      end,
      -- must be loaded after the colorscheme or it loads default vim colors
      after = "onenord.nvim",
    })

    -- tab bar and buffer switching
    use({
      "romgrk/barbar.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.barbar")
      end,
      -- must be loaded after the colorscheme or it loads default vim colors
      after = "lualine.nvim",
    })

    -- notification plugin
    use({
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

    -- git inside vim
    use({
      "tpope/vim-fugitive",
      setup = function()
        -- commit current file
        vim.keymap.set("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>")
      end,
      cmd = "Git",
    })

    -- fuzzy search
    -- better quickfix window
    use({
      "kevinhwang91/nvim-bqf",
      config = [[require("config.bqf")]],
      ft = "qf",
    })

    -- file browser/picker
    use({
      "luukvbaal/nnn.nvim",
      -- set up maps beforehand so that they can load nnn when required
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

    -- visual undo
    use({
      "simnalamburt/vim-mundo",
      setup = function()
        vim.g.mundo_width = 80
        local map = require("utils").map

        map("n", "<F9>", "<cmd>MundoToggle<cr>")
      end,
      cmd = { "MundoToggle", "MundoShow" },
    })

    -- yank manager
    use({
      "gbprod/yanky.nvim",
      config = function()
        require("yanky").setup({})

        local map = require("utils").map

        map("n", "p", "<Plug>(YankyPutAfter)")
        map("n", "P", "<Plug>(YankyPutBefore)")
        map("x", "p", "<Plug>(YankyPutAfter)")
        map("x", "P", "<Plug>(YankyPutBefore)")
        map("n", "gp", "<Plug>(YankyGPutAfter)")
        map("n", "gP", "<Plug>(YankyGPutBefore)")
        map("x", "gp", "<Plug>(YankyGPutAfter)")
        map("x", "gP", "<Plug>(YankyGPutBefore)")
        map("n", "<c-n>", "<Plug>(YankyCycleForward)")
        map("n", "<c-p>", "<Plug>(YankyCycleBackward)")
        map("n", "y", "<Plug>(YankyYank)")
        map("x", "y", "<Plug>(YankyYank)")
      end,
      event = "BufEnter",
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
