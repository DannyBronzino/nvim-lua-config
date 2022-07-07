local wilder = require("wilder")
local colors = require("kanagawa.colors").setup()

wilder.setup({ modes = { ":", "/", "?" } })
-- Disable Python remote plugin
wilder.set_option("use_python_remote_plugin", 0)

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 2,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  ),
})

wilder.set_option(
  "renderer",
  wilder.renderer_mux({
    [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
      highlighter = wilder.lua_fzy_highlighter(),
      left = {
        " ",
        wilder.popupmenu_devicons(),
      },
      highlights = {
        border = "LineNr",
        accent = wilder.make_hl("WilderAccent", "Pmenu", {
          { a = 1 },
          { a = 1 },
          { foreground = colors.crystalBlue },
        }),
      },
      border = "single",
      pumblend = 20,
    })),
    ["/"] = wilder.wildmenu_renderer({
      highlighter = wilder.lua_fzy_highlighter(),
      separator = " · ",
      left = { " ", wilder.wildmenu_spinner(), " " },
      right = { " ", wilder.wildmenu_index() },
      highlights = {
        accent = wilder.make_hl("WilderAccent", "Pmenu", {
          { a = 1 },
          { a = 1 },
          { foreground = colors.crystalBlue },
        }),
      },
    }),
  })
)
