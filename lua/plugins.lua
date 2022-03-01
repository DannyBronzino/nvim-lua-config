local utils = require("utils")
local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

-- github alternate
local plug_url_format = ""
if vim.g.is_linux then
	plug_url_format = "https://hub.fastgit.org/%s"
else
	plug_url_format = "https://github.com/%s"
end

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- auto-install packer in case it hasn't been installed
if fn.glob(packer_install_dir) == "" then
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
	vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")
local util = require("packer.util")

require("packer").startup({
	function(use)
		-- it is recommened to put impatient.nvim before any other plugins
		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
				require("impatient").enable_profile()
			end,
		})

		-- packer itself, can be optional
		use({
			"wbthomason/packer.nvim",
			opt = true,
		})

		-- additional powerful text object for vim, this plugin should be studied carefully to use its full power
		use({
			"wellle/targets.vim",
			event = "BufEnter",
		})

		-- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
		use({ "chaoren/vim-wordmotion", event = "BufEnter" })

		-- modern matchit implementation
		use({
			"andymass/vim-matchup",
			event = "BufEnter",
		})

		-- textobjects for treesitter
		use({
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "vim-matchup",
			disable = true,
		})

		-- syntax highlighting, folding, and more
		use({
			"nvim-treesitter/nvim-treesitter",
			config = [[require("config.treesitter")]],
			run = ":TSUpdateSync",
			-- after = "nvim-treesitter-textobjects",
			after = "vim-matchup",
		})

		-- vscode format snippets, must be loaded before LuaSnip
		use({ "rafamadriz/friendly-snippets", event = "BufEnter" })

		-- snippet engine
		use({
			"L3MON4D3/LuaSnip",
			config = [[require("config.luasnip")]],
			after = "friendly-snippets",
		})

		-- LSP icons
		use({ "onsails/lspkind-nvim", after = "LuaSnip" })

		-- automatic insertion and deletion of a pair of characters
		use({
			"windwp/nvim-autopairs",
			config = [[require("config.nvim-autopairs")]],
			after = "lspkind-nvim",
		})

		-- completion engine
		use({
			"hrsh7th/nvim-cmp",
			config = [[require("config.nvim-cmp")]],
			after = { "nvim-autopairs" },
		})

		-- nvim-cmp completion sources
		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }) -- nvim-lsp completion

		-- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
		use({
			"neovim/nvim-lspconfig",
			config = [[require("config.lsp")]],
			after = "cmp-nvim-lsp",
		})

		-- easy to use lsp commands
		use({ "tami5/lspsaga.nvim", config = [[require("config.lspsaga")]], after = "nvim-lspconfig" })

		use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }) -- completion for nvim-lua
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- completion for paths
		use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" }) -- completion using ripgrep, requires installing ripgrep
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- completion for buffer, rg is more useful
		use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }) -- completion for cmdline and search
		use({ "f3fora/cmp-spell", after = "nvim-cmp" }) -- completion for nvim spell-checker
		use({ "kdheepak/cmp-latex-symbols", after = "nvim-cmp", disable = true }) -- completion for latex symvols
		use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }) -- completion using luasnip
		use({ "dmitmel/cmp-digraphs", after = "nvim-cmp" }) -- digraph completion

		-- Buffer jumping like EasyMotion or Sneak
		use({
			"phaazon/hop.nvim",
			config = [[require("config.hop")]],
			event = "BufEnter",
			disable = true,
		})

		-- or use this for buffer jumping
		use({
			"ggandor/lightspeed.nvim",
			config = [[require("config.lightspeed")]],
			event = "BufEnter",
		})

		-- asterisk improved
		use({ "haya14busa/vim-asterisk", event = "BufEnter" })

		-- Show match number and index for search
		use({
			"kevinhwang91/nvim-hlslens",
			config = [[require('config.hlslens')]],
			after = "vim-asterisk",
		})

		-- colorschemes
		use("rebelot/kanagawa.nvim")
		use("folke/tokyonight.nvim")

		-- icons for everything
		use({ "kyazdani42/nvim-web-devicons", event = "VimEnter" })

		-- status line
		use({
			"nvim-lualine/lualine.nvim",
			config = [[require("config.lualine")]],
			after = "nvim-web-devicons",
		})

		-- indent markers
		use({
			"lukas-reineke/indent-blankline.nvim",
			ft = { "lua", "python" },
			event = "BufRead",
		})

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			config = function()
				vim.defer_fn(function()
					require("config.nvim-notify")
				end, 2000)
			end,
			event = "BufEnter",
		})

		-- escape insert quickly with "jj" or "jk" or whatever
		use({
			"jdhao/better-escape.vim",
			event = "insertEnter",
		})

		-- LSP doesn't do formatting on some languages so use this
		use({
			"sbdchd/neoformat",
			cmd = "Neoformat",
		})

		-- git in the gutter
		use({
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("gitsigns").setup()
			end,
			event = "BufRead",
		})

		-- Git command inside vim
		use({ "tpope/vim-fugitive", cmd = "Git" })

		-- Better git log display
		use({ "rbong/vim-flog", wants = "vim-fugitive", cmd = "Flog" })

		-- manipulate surrounds ()""{}
		use({
			"blackCauldron7/surround.nvim",
			config = function()
				require("surround").setup({
					context_offset = 100,
					load_autogroups = false,
					mappings_style = "sandwich",
					map_insert_mode = false,
					quotes = { "'", '"' },
					brackets = { "(", "{", "[" },
					pairs = {
						nestable = { { "(", ")" }, { "[", "]" }, { "{", "}" } },
						linear = {
							{ "'", "'" },
							{ "`", "`" },
							{ '"', '"' },
							{ "$", "$" },
						},
					},
					prefix = "<leader>s", -- I use this mapping because lightspeed uses "s"
				})
			end,
			event = "BufEnter",
		})

		-- fallback if surround.nvim never comes back
		use({ "machakann/vim-sandwich", event = "BufEnter", disable = true })

		-- latex stuff
		use({
			"lervag/vimtex",
			ft = { "tex", "bib" },
			disable = true,
		})

		-- show keybindings and registers and marks and more
		use({
			"folke/which-key.nvim",
			config = [[require("config.which-key")]],
			event = "VimEnter",
		})

		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			config = [[require("config.nvim-tree")]],
			after = "nvim-web-devicons",
			disable = true,
		})

		-- Fixes scroll in middle of page
		-- works poorly with soft wrapping
		use({
			"vim-scripts/scrollfix",
			event = "BufEnter",
			disable = true,
		})

		-- automatic window sizing
		use({
			"dm1try/golden_size",
			config = [[require("config.golden_size")]],
			event = "VimEnter",
			disable = true,
		})

		-- fuzzy search engine
		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
			event = "BufEnter",
		})

		-- needed for fzf integration
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
			after = "fzf",
		})

		-- very nice fuzzy search
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
			},
			config = [[require("config.telescope")]],
			after = "telescope-fzf-native.nvim",
		})

		-- better quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			config = [[require("config.bqf")]],
			ft = "qf",
		})

		-- nice tab bar
		use({
			"romgrk/barbar.nvim",
			config = [[require("config.barbar")]],
			after = "nvim-web-devicons",
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "BufRead" })
	end,
	config = {
		max_jobs = nil,
		compile_path = util.join_paths(vim.fn.stdpath("config"), "lua", "packer_compiled.lua"),
		git = {
			default_url_format = plug_url_format,
		},
	},
})

local status, _ = pcall(require, "packer_compiled")
if not status then
	vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
