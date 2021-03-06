require("hlslens").setup({
  calm_down = true,
  nearest_only = true,
})

local activate_hlslens = function(direction)
  local cmd = string.format("normal! %s%szzzv", vim.v.count1, direction)
  local status, msg = pcall(vim.fn.execute, cmd)
  -- 13 is the index where real error message starts
  msg = msg:sub(13)

  if not status then
    vim.api.nvim_echo({ { msg, "ErrorMsg" } }, false, {})
    return
  end
  require("hlslens").start()
end

local map = require("utils").map

map("n", "n", "", {
  noremap = true,
  silent = true,
  callback = function()
    activate_hlslens("n")
  end,
})

map("n", "N", "", {
  noremap = true,
  silent = true,
  callback = function()
    activate_hlslens("N")
  end,
})

map("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>")

map("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>")
