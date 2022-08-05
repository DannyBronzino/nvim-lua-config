local colors = {
  fg = "#C8D0E0",
  fg_light = "#E5E9F0",
  bg = "#2E3440",
  gray = "#646A76",
  light_gray = "#6C7A96",
  cyan = "#88C0D0",
  blue = "#81A1C1",
  dark_blue = "#5E81AC",
  green = "#A3BE8C",
  light_green = "#8FBCBB",
  dark_red = "#BF616A",
  red = "#D57780",
  light_red = "#DE878F",
  pink = "#E85B7A",
  dark_pink = "#E44675",
  orange = "#D08F70",
  yellow = "#EBCB8B",
  purple = "#B988B0",
  light_purple = "#B48EAD",
  none = "NONE",
}

require("onenord").setup({
  theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
  borders = true, -- Split window borders
  fade_nc = false, -- Fade non-current windows, making them more distinguishable
  -- Style that is applied to various groups: see `highlight-args` for options
  styles = {
    comments = "italic",
    strings = "NONE",
    keywords = "NONE",
    functions = "NONE",
    variables = "NONE",
    diagnostics = "inverse",
  },
  disable = {
    background = true, -- Disable setting the background color
    cursorline = false, -- Disable the cursorline
    eob_lines = true, -- Hide the end-of-buffer lines
  },
  -- Inverse highlight for different groups
  inverse = {
    match_paren = false,
  },
  custom_highlights = {
    -- Normal = { fg = colors.fg_light },
    WhichKeyValue = { fg = colors.fg },
    WhichKeyDesc = { fg = colors.yellow },
    BufferTabPageFill = { bg = "none" },
    Visual = { fg = colors.bg, bg = colors.light_purple },
    Comment = { fg = colors.orange },
    MiniJump2dSpot = { fg = colors.light_green },
    YankyYanked = { fg = colors.bg, bg = colors.light_purple },
    YankyPut = { link = "YankyYanked" },
    LeapLabelPrimary = { fg = colors.bg, bg = colors.light_green },
    LeapMatch = { fg = colors.light_green },
  }, -- Overwrite default highlight groups
  custom_colors = {}, -- Overwrite default colors
})

---swap two highlight groups
---@param hl_group_1 string name of highlight group
---@param hl_group_2 string name of highlight group
local swap_highlights = function(hl_group_1, hl_group_2)
  local hl_1 = vim.api.nvim_get_hl_by_name(hl_group_1, true)
  local hl_2 = vim.api.nvim_get_hl_by_name(hl_group_2, true)

  vim.api.nvim_set_hl(0, hl_group_1, hl_2)
  vim.api.nvim_set_hl(0, hl_group_2, hl_1)
end
