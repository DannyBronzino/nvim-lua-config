local map = require("utils").map
local npairs = require("nvim-autopairs")

npairs.setup({
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
  map_bs = false,
  map_cr = false,
})

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return npairs.esc("<c-y>")
    else
      return npairs.esc("<c-e>") .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
map("i", "<cr>", "v:lua.MUtils.CR()", { expr = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
    return npairs.esc("<c-e>") .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
map("i", "<bs>", "v:lua.MUtils.BS()", { expr = true })
