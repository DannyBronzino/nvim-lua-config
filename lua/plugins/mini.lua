local map = require("utils").map

return {
  -- swiss army knife
  {
    "echasnovski/mini.nvim",
    lazy = false,
    version = false,
    config = function()
      require("mini.ai").setup() -- adds more textobjects
      require("mini.misc").setup() -- miscellaneous functions
      require("mini.misc").setup_restore_cursor()
      require("mini.move").setup()
      require("mini.bracketed").setup()
      -- require("mini.animate").setup({}) -- animations
      require("mini.trailspace").setup() -- identify and remove trailing spaces
      require("mini.tabline").setup()
      require("mini.bufremove").setup()
      require("mini.statusline").setup({
        set_vim_settings = false,
      })

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
