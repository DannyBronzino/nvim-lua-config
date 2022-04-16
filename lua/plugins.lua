vim.g.package_home = vim.fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

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

		use({ "wellle/targets.vim", event = "BufEnter" }) -- additional powerful text object for vim, this plugin should be studied carefully to use its full power

		use({ -- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
			"chaoren/vim-wordmotion",
			event = "BufEnter",
		})

		use({ -- syntax highlighting, folding, and more
			"nvim-treesitter/nvim-treesitter",
			requires = {
				{ -- highlights matching brackets
					"andymass/vim-matchup",
					setup = function() -- put the settings here for easy removal
						vim.g.matchup_matchparen_deferred = 1 -- improve performance
						vim.g.matchup_matchparen_timeout = 100 -- improve performance
						vim.g.matchup_matchparen_insert_timeout = 30 -- improve performance
						vim.g.matchup_delim_noskips = 0 -- whether to enable matching inside comment or string
						vim.g.matchup_matchparen_hi_surround_always = 1 -- highlights surrounding matches always
						vim.g.matchup_transmute_enabled = 1 -- easy change of tags
						vim.g.matchup_matchparen_offscreen = { method = "popup" } -- show offscreen match pair in popup window
					end,
				},
			},
			config = [[require("config.treesitter")]],
			run = ":TSUpdateSync",
		})

		use({ -- interface for easy LSP configs
			"neovim/nvim-lspconfig",
			requires = {
				{ -- easy LSP commands
					"tami5/lspsaga.nvim",
					config = [[require("config.lspsaga")]],
				},
				{ -- completion engine
					"hrsh7th/nvim-cmp",
					requires = {
						{ "folke/lua-dev.nvim" }, -- adds much needed signature help and other niceties for neovim lua
						{ -- snippets in lua, accepts vscode style and snipmate as well
							"L3MON4D3/LuaSnip",
							requires = "rafamadriz/friendly-snippets", -- vscode snippets
							config = [[require("config.luasnip")]],
						},
						{ "onsails/lspkind-nvim" }, -- vscode pictograms
						{ "hrsh7th/cmp-nvim-lsp" }, -- completion for LSP
						{ "hrsh7th/cmp-nvim-lua" }, -- completion for neovim lua
						{ "hrsh7th/cmp-nvim-lsp-signature-help" },
						{ "hrsh7th/cmp-path" }, -- completion for path
						{ "lukas-reineke/cmp-rg" }, -- completion for ripgrep
						{ "hrsh7th/cmp-buffer", event = "BufRead" }, -- completion for buffer contents
						{ "hrsh7th/cmp-cmdline", event = "CmdLineEnter" }, -- completion for cmdline
						{ "f3fora/cmp-spell" }, -- completion for spell
						{ "saadparwaiz1/cmp_luasnip" }, -- completion for LuaSnip
						-- { "dmitmel/cmp-digraphs" }, -- completion for digraphs
					},
					config = [[require("config.cmp")]],
				},
			},
			config = [[require("config.lspconfig")]],
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
			after = "nvim-cmp",
		})

		use({ -- buffer jumping like EasyMotion or Sneak
			"ggandor/lightspeed.nvim",
			config = [[require("config.lightspeed")]],
			event = "BufEnter",
			disable = true,
		})

		use({
			"phaazon/hop.nvim",
			branch = "v1",
			config = [[require("config.hop")]],
			event = "BufEnter",
		})

		use({ -- Show match number and index for search
			"kevinhwang91/nvim-hlslens",
			requires = "haya14busa/vim-asterisk", -- asterisk improved
			config = [[require('config.hlslens')]],
			event = "BufEnter",
		})

		use({ -- colorschemes
			{
				"rebelot/kanagawa.nvim",
				config = [[require("config.kanagawa")]],
			},
			{
				"folke/tokyonight.nvim",
				setup = function()
					vim.g.tokyonight_style = "night"
					vim.g.tokyonight_transparent = true
				end,
			},
		})

		use({ -- tab bar and buffer switching
			"romgrk/barbar.nvim",
			requires = "kyazdani42/nvim-web-devicons", -- icons, duh
			config = [[require("config.barbar")]],
		})

		use({ -- status line
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons", -- icons, duh
			config = [[require("config.lualine")]],
		})

		use({ -- indent markers
			"lukas-reineke/indent-blankline.nvim",
			event = "BufEnter",
		})

		use({ -- notification plugin
			"rcarriga/nvim-notify",
			config = [[require("config.notify")]],
		})

		use({ -- escape insert quickly with "jj" or "jk" or whatever
			"jdhao/better-escape.vim",
			setup = function() -- settings here for easy removal
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
			{ -- git command
				"tpope/vim-fugitive",
				cmd = "Git",
			},
			{ -- git log
				"rbong/vim-flog",
				wants = "vim-fugitive",
				cmd = "Flog",
			},
		})

		use({ -- show keybindings and registers and marks and more
			"folke/which-key.nvim",
			config = [[require("config.which-key")]],
			event = "VimEnter",
			disable = true,
		})

		use({ -- Fixes scroll in middle of page (works poorly with soft wrapping)
			"vim-scripts/scrollfix",
			event = "BufEnter",
			disable = true,
		})

		use({ -- automatic window sizing
			"dm1try/golden_size",
			event = "VimEnter",
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
			},
			config = [[require("config.telescope")]],
			event = "BufEnter", -- necessary for mapping to work?
		})

		use({ -- cheatsheet that displays using telescope, if available
			"sudormrfbin/cheatsheet.nvim",
			cmd = "Cheatsheet",
		})

		use({ -- better quickfix window
			"kevinhwang91/nvim-bqf",
			config = [[require("config.bqf")]],
			ft = "qf",
		})

		use({ "jdhao/whitespace.nvim", event = "BufEnter" }) -- show and trim trailing whitespaces

		use({ -- creates missing directories when saving a new file
			"jghauser/mkdir.nvim",
			event = "CmdLineEnter",
		})
	end,
	config = {
		max_jobs = 16,
		compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
		autoremove = true,
	},
})

local status, _ = pcall(require, "packer_compiled")
if not status then
	vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
