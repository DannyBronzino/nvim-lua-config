-- show word count
local function get_words()
  return tostring(vim.fn.wordcount().words .. " words")
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function get_colorscheme()
  local is_in_table = require("utils").is_in_table
  local installed_colorschemes = vim.g.installed_colorschemes
  local colorscheme = vim.api.nvim_exec("colorscheme", true)

  if is_in_table(installed_colorschemes, colorscheme) then
    return colorscheme
  else
    return "auto"
  end
end

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = get_colorscheme(),
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "b:gitsigns_head", icon = "" },
      { "diff", source = diff_source },
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
      "progress",
    },
    lualine_z = {},
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
  winbar = {},
  extensions = {
    "quickfix",
    "fugitive",
  },
})
