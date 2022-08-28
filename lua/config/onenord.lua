local colors = require("onenord.colors").load()

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
    diagnostics = "underline",
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
    BufferTabPageFill = {},
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
