-- join all non-blank lines
function _G.join_lines()
  vim.cmd([[%!fmt -999]])
end

---returns context of event
---@param event string|table
---@return table
function _G.get_ctx(event)
  vim.api.nvim_create_autocmd(event, {
    group = vim.api.nvim_create_augroup("get_ctx", { clear = true }),
    callback = function(ctx)
      Got_ctx = ctx
    end,
  })

  vim.api.nvim_exec_autocmds(event, { group = "get_ctx" })
  return Got_ctx
end

local M = {}

---easier vim.keymap.set syntax
---@param mode string|table nvim mode for mapping
---@param left_hand_side string
---@param right_hand_side string|function
---@param opts table|nil if {silent = false} not present then it will be set to true
---@return function vim.keymap.set
function M.map(mode, left_hand_side, right_hand_side, opts)
  opts = opts or { silent = true }
  if opts.silent == nil then
    opts.silent = true
  end
  return vim.keymap.set(mode, left_hand_side, right_hand_side, opts)
end

---does the executable exist?
---@param name string name of executable
---@return boolean
function M.executable(name)
  if vim.fn.executable(name) > 0 then
    return true
  end

  return false
end

---trim whitespace from beginning of string
---@param s string
---@return string
function M.ltrim(s)
  return s:match("^%s*(.*)")
end

---trim whitespace from end of string
---@param s string
---@return string
function M.rtrim(s)
  return s:match("^(.*%S)%s*$")
end

return M
