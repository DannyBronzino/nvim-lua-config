return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
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
      local npairs = require("nvim-autopairs")

      npairs.setup({
        check_ts = true,
        disable_filetype = { "guihua", "guihua_rust", "clap_input" },
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
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
      local api = vim.api
      local autocmd = vim.api.nvim_create_autocmd

      -- nvim-surround tex commands
      autocmd({ "BufEnter" }, {
        pattern = { "*.tex", "*.bib" },
        group = api.nvim_create_augroup("tex_file", { clear = true }),
        callback = function()
          require("nvim-surround").buffer_setup({
            surrounds = {
              ["c"] = {
                add = function()
                  local cmd = require("nvim-surround.config").get_input("Command: ")
                  return { { "\\" .. cmd .. "{" }, { "}" } }
                end,
              },
              ["e"] = {
                add = function()
                  local env = require("nvim-surround.config").get_input("Environment: ")
                  return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
                end,
              },
            },
          })
        end,
        desc = "loads latex only surrounds",
      })

      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "yz",
          normal_cur = "yzz",
          normal_line = "yZ",
          normal_cur_line = "yZZ",
          visual = "Z",
          visual_line = "gZ",
          delete = "dz",
          change = "cz",
        },
      })
    end,
  },

  -- Show match number and index for search
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      local hlslens = require("hlslens")

      hlslens.setup({
        calm_down = true,
        nearest_only = true,
      })

      local activate_hlslens = function(direction)
        local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
        local status, msg = pcall(vim.fn.execute, cmd)
        -- 13 is the index where real error message starts
        msg = msg:sub(13)

        if not status then
          vim.api.nvim_echo({ { msg, "ErrorMsg" } }, false, {})
          return
        end
        hlslens.start()
      end

      local map = require("utils").map

      map("n", "n", "", {
        noremap = true,
        silent = true,
        callback = function()
          activate_hlslens("n")
        end,
      })

      map("n", "N", "", {
        noremap = true,
        silent = true,
        callback = function()
          activate_hlslens("N")
        end,
      })

      map("n", "*", "", {
        callback = function()
          vim.fn.execute("normal! *N")
          hlslens.start()
        end,
      })

      map("n", "#", "", {
        callback = function()
          vim.fn.execute("normal! #N")
          hlslens.start()
        end,
      })
    end,
    keys = {
      { "*", mode = "n" },
      { "#", mode = "n" },
      { "n", mode = "n" },
      { "N", mode = "n" },
    },
    event = "CmdLineEnter",
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
    config = {
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

  -- shows you which key comes next
  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      vim.opt.timeoutlen = 1000 -- timeout before which-key appears

      require("which-key").setup({
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 9, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<cr>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-n>", -- binding to scroll down inside the popup
          scroll_up = "<c-p>", -- binding to scroll up inside the popup
        },
        window = {
          border = "none", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
          padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
          winblend = 33,
        },
        layout = {
          height = { min = 6, max = 12 }, -- min and max height of the columns
          width = { min = 100, max = 100 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "center", -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        show_keys = false,
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      })
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
