local map = require("utils").map

return {
  -- swiss army knife
  {
    "echasnovski/mini.nvim",
    -- event = "VeryLazy",
    version = false,
    config = function()
      require("mini.icons").setup() -- icons
      require("mini.ai").setup() -- adds more textobjects
      require("mini.misc").setup() -- miscellaneous functions
      require("mini.misc").setup_restore_cursor()
      require("mini.move").setup()
      require("mini.bracketed").setup()
      -- require("mini.animate").setup({}) -- animations
      require("mini.trailspace").setup() -- identify and remove trailing spaces
      require("mini.tabline").setup()
      require("mini.bufremove").setup()
      require("mini.git").setup()
      require("mini.diff").setup()
      require("mini.statusline").setup({
        set_vim_settings = false,
      })
      vim.api.nvim_set_hl(0, "MiniStatuslineFilename", {})
      -- require("mini.files").setup()
      -- require("mini.pairs").setup()

      -- local map_bs = function(lhs, rhs)
      -- vim.keymap.set("i", lhs, rhs, { expr = true, replace_keycodes = false })
      -- end

      -- map_bs("<C-h>", "v:lua.MiniPairs.bs()")
      -- map_bs("<C-w>", 'v:lua.MiniPairs.bs("\23")')
      -- map_bs("<C-u>", 'v:lua.MiniPairs.bs("\21")')

      vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = "*",
        group = vim.api.nvim_create_augroup("MiniTrailSpace", { clear = true }),
        callback = function()
          require("mini.trailspace").trim()
          require("mini.trailspace").trim_last_lines()
        end,
        desc = "trim empty spaces and lines",
      })

      map("n", "<a-c>", function()
        require("mini.bufremove").delete()
      end, { desc = "delete buffer" })

      -- map("n", "<leader>fs", function()
      -- require("mini.files").open()
      -- end, { desc = "open MiniFiles" })
    end,
  },
}
