return {
  -- easymotion type thing
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      local leap = require("leap")
      local map = require("utils").map

      map("n", "gs", function()
        leap.leap({
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        })
      end, { desc = "search in all windows (including the current one) on the tab page." })

      -- The following example showcases a custom action, using `multiselect`. We're
      -- executing a `normal!` command at each selected position (this could be even
      -- more useful if we'd pass in custom targets too).

      function Paranormal(targets)
        -- Get the :normal sequence to be executed.
        local input = vim.fn.input("normal! ")
        if #input < 1 then
          return
        end

        local ns = vim.api.nvim_create_namespace("")

        -- Set an extmark as an anchor for each target, so that we can also execute
        -- commands that modify the positions of other targets (insert/change/delete).
        for _, target in ipairs(targets) do
          local line, col = unpack(target.pos)
          Fd = vim.api.nvim_buf_set_extmark(0, ns, line - 1, col - 1, {})
          target.extmark_id = Fd
        end

        -- Jump to each extmark (anchored to the "moving" targets), and execute the
        -- command sequence.
        for _, target in ipairs(targets) do
          local id = target.extmark_id
          local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
          vim.fn.cursor(pos[1] + 1, pos[2] + 1)
          vim.cmd("normal! " .. input)
        end

        -- Clean up the extmarks.
        vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
      end

      -- Usage:
      map("n", "<leader>s", function()
        leap.leap({
          target_windows = { vim.fn.win_getid() },
          action = Paranormal,
          multiselect = true,
        })
      end, { desc = "paranormal leap" })

      leap.add_default_mappings()
    end,
  },

  {
    "ggandor/flit.nvim",
    dependencies = "leap.nvim",
    opts = {
      keys = { f = "f", F = "F", t = "t", T = "T" },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "nvo",
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {},
    },
  },

  {
    "ggandor/leap-spooky.nvim",
    dependencies = "leap.nvim",
    config = true,
  },
}
