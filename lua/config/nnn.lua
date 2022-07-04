local builtin = require("nnn").builtin

require("nnn").setup({
  explorer = {
    cmd = "nnn", -- command overrride (-F1 flag is implied, -a flag is invalid!)
    width = 20, -- width of the vertical split
    side = "topleft", -- or "botright", location of the explorer window
    session = "shared", -- or "global" / "local" / "shared"
    tabs = true, -- seperate nnn instance per tab
  },
  picker = {
    cmd = "nnn", -- command override (-p flag is implied)
    style = {
      width = 50, -- percentage relative to terminal size when < 1, absolute otherwise
      height = 0.9, -- ^
      xoffset = 2, -- ^
      yoffset = 2, -- ^
      border = "single", -- border decoration for example "rounded"(:h nvim_open_win)
    },
    session = "shared", -- or "global" / "local" / "shared"
  },
  auto_open = {
    setup = nil, -- or "explorer" / "picker", auto open on setup function
    tabpage = nil, -- or "explorer" / "picker", auto open when opening new tabpage
    empty = false, -- only auto open on empty buffer
    ft_ignore = { -- dont auto open for these filetypes
      "gitcommit",
    },
  },
  auto_close = true, -- close tabpage/nvim when nnn is last window
  replace_netrw = "explorer", -- or "explorer" / "picker"
  mappings = {
    { "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
    { "<C-s>", builtin.open_in_split }, -- open file(s) in split
    { "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
    { "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
    { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
    { "<C-w>", builtin.cd_to_path }, -- cd to file directory
    { "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
  }, -- table containing mappings, see below
  windownav = { -- window movement mappings to navigate out of nnn
    left = "<C-w>h",
    right = "<C-w>l",
    next = "<C-w>w",
    prev = "<C-w>W",
  },
  buflisted = false, -- wether or not nnn buffers show up in the bufferlist
  quitcd = "tcd", -- or "cd" / "lcd", command to run if quitcd file is found
})
