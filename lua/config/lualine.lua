vim.api.nvim_create_autocmd("Colorscheme", {
  callback = function()
    -- change lualine colorscheme
    require("lualine").setup({
      options = {
        theme = "auto",
      },
    })
    -- the lua doesn't seem to work in the autocmd
    -- vim.api.nvim_set_hl(0, "BufferTabPageFill", { bg = "none" })
    vim.cmd([[hi BufferTabPageFill ctermbg=none guibg=none]])
  end,
  desc = "changes lualine colorscheme when nvim colorscheme changes",
})

-- displays spell indicator
local function spell()
  if vim.o.spell then
    return string.format("SPELL")
  end

  return ""
end

-- show word count
local function get_words()
  return tostring(vim.fn.wordcount().words .. " words")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "kanagawa",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
    },
    lualine_c = { "filename" },
    lualine_x = {
      { spell, color = "WarningMsg" },
      { get_words },
      "filetype",
    },
    lualine_y = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
      },
      "location",
    },
    lualine_z = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
    "fugitive",
    "nvim-tree",
  },
})
