local fn = vim.fn

-- install packer
local packer_install_dir = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(packer_install_dir)) > 0 then
	fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_install_dir)
end

-- allows faster downloading if on linux
local plug_url_format = ""
if vim.g.is_linux then
	plug_url_format = "https://hub.fastgit.org/%s"
else
	plug_url_format = "https://github.com/%s"
end

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- automatically install packer on first start up
if fn.glob(packer_install_dir) == "" then
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
	vim.cmd(install_cmd)
	vim.cmd("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup({
	function(use)
		-- packer itself
		use({
			"wbthomason/packer.nvim",
		})

		-- divides words into smaller chunks e.g. camelCase becomes camel+Case when using w motion
		use({ "chaoren/vim-wordmotion", event = "BufEnter" })

		-- treesitter for syntax highlighting and folding and more
		use({
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "BufEnter",
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			after = "nvim-treesitter-textobjects",
			config = [[require("config.treesitter")]],
			run = ":TSUpdateSync",
		})

		-- lsp stuff
		use({ "onsails/lspkind-nvim", event = "BufEnter" })

		use({
			"hrsh7th/nvim-cmp",
			after = "lspkind-nvim",
			config = [[require('config.nvim-cmp')]],
		})

		-- nvim-cmp completion sources
		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })

		-- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
		use({
			"neovim/nvim-lspconfig",
			after = "cmp-nvim-lsp",
			config = [[require('config.lsp')]],
		})

		use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
		-- use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
		use({
			"quangnguyen30192/cmp-nvim-ultisnips",
			after = { "nvim-cmp", "ultisnips" },
		})

		-- Snippet engine and snippet template
		use({
			"SirVer/ultisnips",
			event = "InsertEnter",
		})
		use({ "honza/vim-snippets", after = "ultisnips" })

		-- Automatic insertion and deletion of a pair of characters
		use({
			"windwp/nvim-autopairs",
			config = [[require("config.nvim-autopairs")]],
		})

		-- Buffer jumping like EasyMotion
		use({
			"phaazon/hop.nvim",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("config.hop")
				end, 2000)
			end,
		})

		-- Clear highlight search automatically for you
		use({
			"romainl/vim-cool",
			event = "VimEnter",
		})

		-- Show match number for search
		use({ "kevinhwang91/nvim-hlslens", event = "VimEnter" })

		-- colorscheme
		use({ "rebelot/kanagawa.nvim" })

		-- status line
		use({
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = [[require("config.lualine")]],
		})

		-- Indent markers
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
		})

		-- Better register. Use " in Normal or <c-r> in insert
		-- use({ "tversteeg/registers.nvim", event = "VimEnter" })

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			event = "BufEnter",
			config = function()
				vim.defer_fn(function()
					require("config.nvim-notify")
				end, 2000)
			end,
		})

		-- Escape faster with "jj" or "jk" or whatever
		use({
			"jdhao/better-escape.vim",
			event = "insertEnter",
		})

		-- Syntax check and make
		use({ "neomake/neomake", cmd = "Neomake" })

		-- Auto format tools
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
		})

		-- Git command inside vim
		use({ "tpope/vim-fugitive" })

		-- Better git log display
		use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "flog" } })

		-- Another markdown plugin
		use({ "plasticboy/vim-markdown", ft = { "markdown" } })

		-- Faster footnote generation
		-- use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })

		-- Vim tabular plugin for manipulate tabular, required by markdown plugins
		use({ "godlygeek/tabular", cmd = { "Tabularize" } })

		-- Additional powerful text object for vim, this plugin should be studied carefully to use its full power
		use({
			"wellle/targets.vim",
		})

		-- manipulate surrounds ()""{}
		use({
			"blackCauldron7/surround.nvim",
			config = function()
				require("surround").setup({
					context_offset = 100,
					load_autogroups = false,
					mappings_style = "sandwich",
					map_insert_mode = true,
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
					prefix = "s",
				})
			end,
		})

		-- Add indent object for vim (useful for languages like Python)
		use({
			"michaeljsmith/vim-indent-object",
			event = "VimEnter",
		})

		-- Latex stuff
		use({
			"lervag/vimtex",
			ft = { "tex", "bib" },
		})

		-- Modern matchit implementation
		use({
			"andymass/vim-matchup",
			event = "VimEnter",
		})

		-- Asynchronous command execution
		use({
			"skywind3000/asyncrun.vim",
			opt = true,
			cmd = "AsyncRun",
		})

		-- The missing auto-completion for cmdline!
		use({ "gelguy/wilder.nvim" })

		-- show keybindings
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("config.which-key")
				end, 2000)
			end,
		})

		-- file explorer
		use({
			"kyazdani42/nvim-tree.lua",
			event = "VimEnter",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require("config.nvim-tree")]],
		})

		-- Fixes scroll in middle of page
		-- use({
		-- 	"vim-scripts/scrollfix",
		-- })

		-- Window Sizer
		-- use {
		-- "dm1try/golden_size",
		-- config = [[require("config.golden_size")]]
		-- }

		-- powerful fuzzy search
		use({
			"nvim-telescope/telescope.nvim",
			event = "BufEnter",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
				{ "telescope-fzf-native.nvim" },
			},
			config = [[require("config.telescope")]],
		})

		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		use({
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		})

		-- Better Quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			event = "FileType qf",
			config = [[require("config.bqf")]],
		})

		-- nice tab bar
		use({
			"romgrk/barbar.nvim",
			event = "VimEnter",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("config.barbar")]],
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "VimEnter" })

		-- fennel language stuff
		-- add syntax
		use("bakpakin/fennel.vim")

		-- aniseed for neovim configs and REPL
		use("Olical/conjure")
	end,
	config = {
		max_jobs = nil,
		git = {
			default_url_format = plug_url_format,
		},
	},
})

-- vim.cmd([[
-- augroup packer_auto_compile
-- autocmd!
-- autocmd BufWritePost */nvim/lua/plugins.lua source <afile> | PackerCompile
-- augroup END
-- ]])
