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
		})

		-- packer itself, can be optional
		use({
			"wbthomason/packer.nvim",
			opt = true,
		})

		-- additional powerful text object for vim, this plugin should be studied carefully to use its full power
		use({ "wellle/targets.vim", event = "BufEnter" })

		-- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
		use({ "chaoren/vim-wordmotion", event = "BufEnter" })

		-- syntax highlighting, folding, and more
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = "andymass/vim-matchup", -- highlights matching brackets
			config = [[require("config.treesitter")]],
			run = ":TSUpdateSync",
			event = "BufEnter",
		})

		-- interface for easy LSP configs
		use({
			"neovim/nvim-lspconfig",
			requires = {
				-- easy LSP commands
				{
					"tami5/lspsaga.nvim",
					config = [[require("config.lspsaga")]],
				},
				-- completion engine
				{
					"hrsh7th/nvim-cmp",
					requires = {
						-- snippets
						{
							"L3MON4D3/LuaSnip",
							requires = "rafamadriz/friendly-snippets",
							config = [[require("config.luasnip")]],
						},
						{ "onsails/lspkind-nvim" }, -- vscode pictograms
						{ "hrsh7th/cmp-nvim-lsp" }, -- completion for LSP
						{ "hrsh7th/cmp-nvim-lua" }, -- completion for neovim lua
						{ "hrsh7th/cmp-path" }, -- completion for path
						{ "lukas-reineke/cmp-rg" }, -- completion for ripgrep
						{ "hrsh7th/cmp-buffer" }, -- completion for buffer contents
						{ "hrsh7th/cmp-cmdline" }, -- completion for cmdline
						{ "f3fora/cmp-spell" }, -- completion for spell
						{ "saadparwaiz1/cmp_luasnip" }, -- completion for LuaSnip
						{ "dmitmel/cmp-digraphs" }, -- completion for digraphs
						-- automatically creates pairs, like ""{}[]()''
						{
							"ZhiyuanLck/smart-pairs",
							config = function()
								require("pairs"):setup({
									enter = {
										enable_mapping = false,
									},
									pairs = {
										tex = {
											{ "'", "'", { ignore_pre = "\\a" } },
										},
										markdown = {
											{ "'", "'", { ignore_pre = "\\a" } },
										},
									},
									mapping = {
										jump_left_in_any = "<m-{>",
										jump_right_in_any = "<m-}>",
										jump_left_out_any = "<m-[>",
										jump_right_out_any = "<m-]>",
									},
								})
							end,
						},
					},
					config = [[require("config.nvim-cmp")]],
				},
			},
			config = [[require("config.lsp")]],
			event = "BufEnter",
		})

		-- buffer jumping like EasyMotion or Sneak
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
			disable = false,
		})

		-- Show match number and index for search
		use({
			"kevinhwang91/nvim-hlslens",
			requires = "haya14busa/vim-asterisk", -- asterisk improved
			config = [[require('config.hlslens')]],
			event = "BufEnter",
		})

		-- colorschemes
		use({
			{
				"rebelot/kanagawa.nvim",
				config = [[require("config.kanagawa")]],
			},
			{
				"folke/tokyonight.nvim",
			},
		})

		-- tab bar and buffer switching
		use({
			"romgrk/barbar.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require("config.barbar")]],
		})

		-- status line
		use({
			"nvim-lualine/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require("config.lualine")]],
		})

		-- indent markers
		use({
			"lukas-reineke/indent-blankline.nvim",
			ft = { "lua", "python" },
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
			requires = "nvim-lua/plenary.nvim", -- extra neovim functions
			config = function()
				require("gitsigns").setup()
			end,
			event = "BufEnter",
		})

		-- git command inside vim
		use({ "tpope/vim-fugitive", cmd = "Git" })

		-- git and git log inside (neo)vim
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
		use({
			"machakann/vim-sandwich",
			event = "BufEnter",
			disable = true,
		})

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

		-- Fixes scroll in middle of page (works poorly with soft wrapping)
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

		-- very nice fuzzy search utilizing fzf
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" }, -- api for popups
				{ "nvim-lua/plenary.nvim" }, -- extra neovim functions
				-- fuzzy search
				{
					"junegunn/fzf",
					run = function()
						fn["fzf#install"]()
					end,
				},
				-- interface for fzf
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
			},
			config = [[require("config.telescope")]],
			event = "BufEnter",
		})

		-- cheatsheet that displays using telescope, if available
		use({
			"sudormrfbin/cheatsheet.nvim",
			cmd = "Cheatsheet",
		})

		-- better quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			config = [[require("config.bqf")]],
			ft = "qf",
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "BufRead" })

		-- creates missing directories when saving a new file
		use({
			"jghauser/mkdir.nvim",
			config = function()
				require("mkdir")
			end,
		})
	end,
	config = {
		max_jobs = 16,
		compile_path = util.join_paths(fn.stdpath("config"), "lua", "packer_compiled.lua"),
		git = {
			default_url_format = plug_url_format,
		},
		-- display = {
		-- open_fn = function()
		-- return require("packer.util").float({ border = "none" })
		-- end,
		-- },
	},
})

local status, _ = pcall(require, "packer_compiled")
if not status then
	vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
