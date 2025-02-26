local map = require("utils").map

return {
  -- swiss army knife
  {
    "echasnovski/mini.nvim",
    -- event = "VeryLazy",
    version = false,
    config = function()
      require("mini.ai").setup() -- adds more textobjects
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.diff").setup()
      require("mini.git").setup()
      require("mini.icons").setup() -- icons
      require("mini.misc").setup() -- miscellaneous functions
      require("mini.misc").setup_restore_cursor()
      require("mini.move").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup() -- identify and remove trailing spaces

      vim.api.nvim_set_hl(0, "MiniStatuslineFilename", {})
      vim.api.nvim_set_hl(0, "MiniTablineCurrent", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "MiniTablineFill", {})

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
    end,
  },
}
