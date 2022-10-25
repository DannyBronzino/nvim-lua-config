require("noice").setup({
  cmdline = {
    enabled = true, -- enables the Noice cmdline UI
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
    ---@type table<string, CmdlineFormat>
    format = {
      -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
      -- view: (default is cmdline view)
      -- opts: any options passed to the view
      -- icon_hl_group: optional hl_group for the icon
      cmdline = { pattern = "^:", icon = "" },
      search = { pattern = "^[?/]", icon = " ", conceal = false },
      filter = { pattern = "^:%s*!", icon = "$", opts = { buf_options = { filetype = "sh" } } },
      lua = { pattern = "^:%s*lua%s+", icon = "", opts = { buf_options = { filetype = "lua" } } },
      -- lua = false, -- to disable a format, set to `false`
    },
  },
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = true, -- enables the Noice messages UI
    view = "notify", -- default view for messages
    view_error = "notify", -- view for errors
    view_warn = "notify", -- view for warnings
    view_history = "split", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
  popupmenu = {
    enabled = true, -- enables the Noice popupmenu UI
    ---@type 'nui'|'cmp'
    backend = "cmp", -- backend to use to show regular cmdline completions
  },
  ---@type NoiceRouteConfig
  history = {
    view = "popup",
    opts = { enter = true, format = "details" },
    filter = { event = { "msg_show", "notify" }, ["not"] = { kind = { "search_count", "echo" } } },
  },
  notify = {
    -- Noice can be used as `vim.notify` so you can route any notification like other messages
    -- Notification messages have their level and other properties set.
    -- event is always "notify" and kind can be any log level as a string
    -- The default routes will forward notifications to nvim-notify
    -- Benefit of using Noice for this is the routing and consistent history view
    enabled = true,
    view = "notify",
  },
  lsp_progress = {
    enabled = true,
    -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
    -- See the section on formatting for more details on how to customize.
    --- @type NoiceFormat|string
    format = "lsp_progress",
    --- @type NoiceFormat|string
    format_done = "lsp_progress_done",
    throttle = 1000 / 30, -- frequency to update lsp progress message
    view = "mini",
  },
  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  ---@type NoiceConfigViews
  views = {
    cmdline_popup = {
      position = {
        row = 0,
        col = "50%",
      },
      size = {
        width = "auto",
        height = "auto",
      },
    },
  }, ---@see section on views
  ---@type NoiceRouteConfig[]
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "search_count",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        find = "VimTeX:",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        find = "Syntax highlighting.+Tree",
      },
      -- opts = { skip = true },
      view = "mini",
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      view = "mini",
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "%d+ change",
      },
      view = "mini",
    },
  }, --- @see section on routes
  ---@type table<string, NoiceFilter>
  status = {}, --- @see section on statusline components
  ---@type NoiceFormatOptions
  format = {}, --- @see section on formatting
})
