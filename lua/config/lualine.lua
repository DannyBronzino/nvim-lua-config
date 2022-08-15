-- show word count
local function get_words()
  return tostring(vim.fn.wordcount().words .. " words")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
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
  -- winbar = {
  -- lualine_a = {},
  -- lualine_b = {},
  -- lualine_c = {
  -- { navic.get_location, cond = navic.is_available },
  -- },
  -- lualine_x = {},
  -- lualine_y = {},
  -- lualine_z = {},
  -- },
  extensions = {
    "quickfix",
    "fugitive",
  },
})
