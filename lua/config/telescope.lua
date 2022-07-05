-- wrap telescope results
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.opt_local.wrap = true
  end,
})

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    initial_mode = "normal",
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        prompt_position = "top",
        preview_cutoff = 1,
        preview_height = 0.45,
        height = 0.99,
        width = 0.99,
      },
      bottom_pane = {
        preview_cutoff = 1,
        prompt_position = "top",
        height = 0.75,
      },
      center = {
        width = 0.5,
      },
    },
    sorting_strategy = "ascending",
    dynamic_preview_title = true,
    mappings = {
      i = {
        ["<c-n>"] = actions.preview_scrolling_down,
        ["<c-p>"] = actions.preview_scrolling_up,
        ["<tab>"] = actions.move_selection_next,
        ["<s-tab>"] = actions.move_selection_previous,
        ["<c-l>"] = actions.toggle_selection,
      },
      n = {
        ["l"] = actions.toggle_selection,
      },
    },
  },
  pickers = {
    buffers = {
      theme = "dropdown",
      layout_config = {
        width = 0.5,
      },
    },
    spell_suggest = {
      theme = "cursor",
      layout_config = {
        width = 0.33,
      },
    },
    find_files = {
      theme = "dropdown",
      layout_config = {
        width = 0.5,
      },
    },
    projects = {
      theme = "dropdown",
      layout_config = {
        width = 0.5,
      },
    },
  },
  extensions = {},
})
