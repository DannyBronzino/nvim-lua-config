vim.g.package_home = vim.fn.stdpath("data") .. "/site/pack/packer/" -- set directory for packages
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim" -- set packer installation directory
local packer_repo = "https://github.com/wbthomason/packer.nvim" -- packer repo location
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir) -- installation command

-- Auto-install packer in case it hasn't been installed.
if vim.fn.glob(packer_install_dir) == "" then
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
	vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require("packer.util")

require("packer").startup({
	function(use)
		use({ -- it is recommened to put impatient.nvim before any other plugins
			"lewis6991/impatient.nvim",
		})

		use({ -- packer itself, can be optional
			"wbthomason/packer.nvim",
			opt = true,
		})

		use({ -- syntax highlighting, folding, and more... doesn't always load if you make it optional (i.e. use an event)
			"nvim-treesitter/nvim-treesitter",
			requires = {
				{ "andymass/vim-matchup" }, -- matching parens
			},
			config = [[require("config.treesitter")]],
			run = ":TSUpdateSync",
			event = "BufEnter",
		})

		use({
			"L3MON4D3/LuaSnip",
			requires = "rafamadriz/friendly-snippets", -- vscode format snippets }) -- snippet engine
			event = "BufEnter",
		})

		use({ -- completion engine
			"hrsh7th/nvim-cmp",
			requires = "onsails/lspkind-nvim", -- vscode pictograms},
			config = [[require("config.cmp")]],
			after = "LuaSnip",
		})

		use({ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" }) -- completion for LuaSnip
		use({ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" }) -- completion for neovim lua
		use({ "hrsh7th/cmp-path", event = { "CmdLineEnter", "InsertEnter" } }) -- completion for path
		use({ "hrsh7th/cmp-buffer", event = "CmdLineEnter" }) -- completion for buffer contents
		use({ "hrsh7th/cmp-cmdline", event = "CmdLineEnter" }) -- completion for cmdline

		use({ "lukas-reineke/cmp-rg", event = "InsertEnter" }) -- completion for ripgrep

		use({ "f3fora/cmp-spell", event = "InsertEnter" }) -- completion for spell
		use({ "kdheepak/cmp-latex-symbols", event = "InsertEnter" }) -- easy to enter latex symbols
		use({ "dmitmel/cmp-digraphs", event = "InsertEnter", disable = true }) -- completion for digraphs

		use({ -- interface for easy LSP configs
			"williamboman/nvim-lsp-installer",
			requires = {
				{ "tami5/lspsaga.nvim" }, -- nice lsp actions
				{ "neovim/nvim-lspconfig" }, -- easy lspconfig
				{ "hrsh7th/cmp-nvim-lsp" }, -- completion for LSP
				{ "hrsh7th/cmp-nvim-lsp-signature-help" }, -- signature help in completion menu
			},
			config = [[require("config.lsp-installer")]],
			after = "nvim-cmp",
		})

		use({ -- automatic pairs
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
				-- If you want insert `(` after select function or method item
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local cmp = require("cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
			end,
			event = "InsertEnter",
		})

		use({ "wellle/targets.vim", event = "BufEnter" }) -- additional powerful text object for vim, this plugin should be studied carefully to use its full power

		use({ -- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
			"chaoren/vim-wordmotion",
			event = "BufEnter",
		})

		use({ -- buffer jumping like EasyMotion or Sneak
			"ggandor/lightspeed.nvim",
			requires = "tpope/vim-repeat",
			config = function()
				require("lightspeed").setup({
					ignore_case = true,
				})
			end,
			event = "BufEnter",
		})

		use({
			"phaazon/hop.nvim",
			branch = "v1",
			config = [[require("config.hop")]],
			event = "BufEnter",
			disable = true,
		})

		use({ -- Show match number and index for search
			"kevinhwang91/nvim-hlslens",
			requires = "haya14busa/vim-asterisk", -- asterisk improved
			config = [[require('config.hlslens')]],
			keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
			event = "CmdLineEnter",
		})

		use({ -- tab bar and buffer switching
			"romgrk/barbar.nvim",
			requires = "kyazdani42/nvim-web-devicons", -- icons, duh
			config = [[require("config.barbar")]],
			event = "BufEnter",
		})

		use({
			"rebelot/kanagawa.nvim",
			config = [[require("config.kanagawa")]],
			event = "VimEnter",
		})

		use({
			"folke/tokyonight.nvim",
			setup = function()
				vim.g.tokyonight_style = "night"
				vim.g.tokyonight_transparent = true
			end,
			disable = true,
		})

		use({ -- status line
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons", -- icons, duh
			config = [[require("config.lualine")]],
			after = "kanagawa.nvim",
		})

		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require('config.nvim-tree')]],
			disable = true,
		})

		use({ -- indent markers
			"lukas-reineke/indent-blankline.nvim",
		})

		use({ -- notification plugin
			"rcarriga/nvim-notify",
			config = [[require("config.notify")]],
			event = "VimEnter",
		})

		use({ -- escape insert quickly with "jj" or "jk" or whatever
			"jdhao/better-escape.vim",
			setup = function() -- need to set options FIRST
				vim.g.better_escape_shortcut = "jj"
				vim.g.better_escape_interval = 300
			end,
			event = "InsertEnter",
		})

		use({ -- LSP doesn't do formatting on some languages so use this
			"sbdchd/neoformat",
			cmd = "Neoformat",
		})

		use({ -- git in the gutter
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim", -- extra neovim functions
			config = function()
				require("gitsigns").setup()
			end,
			event = "BufEnter",
		})

		use({ -- git inside vim
			"tpope/vim-fugitive",
			setup = function()
				vim.keymap.set("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>") -- commit current file
			end,
			cmd = "Git",
		})

		use({ -- show keybindings and registers and marks and more
			"folke/which-key.nvim",
			config = [[require("config.which-key")]],
			disable = true,
		})

		use({ -- Fixes scroll in middle of page (works poorly with soft wrapping)
			"vim-scripts/scrollfix",
			event = "BufEnter",
			disable = true,
		})

		use({ -- automatic window sizing
			"dm1try/golden_size",
			event = "WinEnter",
			disable = true,
		})

		use({ -- fuzzy search utilizing fzf
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" }, -- api for popups
				{ "nvim-lua/plenary.nvim" }, -- extra neovim functions
				{ -- fuzzy search
					"junegunn/fzf",
					run = function()
						vim.fn["fzf#install"]()
					end,
				},
				{ -- interface for fzf
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
				{ "nvim-telescope/telescope-packer.nvim" }, -- packer browser
				{ "nvim-telescope/telescope-symbols.nvim" }, -- emojis and other symbols
				{ "benfowler/telescope-luasnip.nvim" }, -- luasnip browser
				{ "ahmedkhalf/project.nvim" },
				{ "sudormrfbin/cheatsheet.nvim", cmd = "Cheatsheet" }, -- list of commands
			},
			config = [[require("config.telescope")]],
			event = "BufEnter",
		})

		use({ -- better quickfix window
			"kevinhwang91/nvim-bqf",
			config = [[require("config.bqf")]],
			ft = "qf",
		})

		use({ -- creates missing directories when saving a new file
			"jghauser/mkdir.nvim",
			event = "CmdLineEnter",
		})
	end,
	config = {
		compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
		autoremove = true,
	},
})

local status, _ = pcall(require, "packer_compiled")
if not status then
	vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
