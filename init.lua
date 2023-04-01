local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- lua sources

-- pulls this repo before syncing
vim.api.nvim_create_user_command("SyncLazy", function()
  -- pull latest changes
  vim.fn.system("cd " .. vim.fn.stdpath("config") .. "; git pull")
  require("lazy").sync()
end, { desc = "pulls changes from nvim config repo before running Lazy sync" })

require("config.globals")
require("config.options")

-- set leader to comma
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("lazy").setup({
  version = "*",
  spec = {
    { import = "plugins" },
  },
  install = {
    missing = false, -- prevents lock-file from being inadvertently changed
    colorscheme = { "catppuccin", "habamax" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- autocmds and keymaps can wait to load
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.autocmds")
    require("config.keymaps")
  end,
})

-- run after :Lazy sync
vim.api.nvim_create_autocmd("User", {
  pattern = { "LazySync", "LazyInstall", "LazyUpdate", "LazyClean" },
  callback = function()
    vim.fn.system("cd " .. vim.fn.stdpath("config") .. "; git commit 'lazy-lock.json' -m 'update lazy lock'; git push")
  end,
})
