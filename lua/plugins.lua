local fn = vim.fn

-- Install packer
local packer_install_dir = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(packer_install_dir)) > 0 then
	fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_install_dir)
end

local plug_url_format = ""
-- if vim.g.is_linux > 0 then
-- plug_url_format = "https://hub.fastgit.org/%s"
-- else
plug_url_format = "https://github.com/%s"
-- end

local packer_repo = string.format(plug_url_format, "wbthomason/packer.nvim")
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
	vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
	vim.cmd(install_cmd)
	vim.cmd("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup({
	function(use)
		use({
			"wbthomason/packer.nvim",
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			require = "nvim-treesitter/nvim-treesitter-textobjects",
			config = [[require("config.treesitter")]],
			run = ":TSUpdate",
		})

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
		-- use({ "Raimondi/delimitMate", event = "InsertEnter" })

		use({
			"windwp/nvim-autopairs",
			config = [[require("config.nvim-autopairs")]],
		})

		-- -- Python indent (follows the PEP8 style)
		-- use({
		-- "Vimjas/vim-python-pep8-indent",
		-- ft = "python",
		-- })

		-- use({
		-- "numirias/semshi",
		-- ft = "python",
		-- config = "vim.cmd [[UpdateRemotePlugins]]",
		-- })

		-- -- Python-related text object
		-- use({
		-- "jeetsukumaran/vim-pythonsense",
		-- ft = "python",
		-- })

		-- -- Another markdown plugin
		-- use({ "plasticboy/vim-markdown", ft = { "markdown" } })

		-- -- Faster footnote generation
		-- use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })

		-- -- Vim tabular plugin for manipulate tabular, required by markdown plugins
		-- use({ "godlygeek/tabular", cmd = { "Tabularize" } })

		-- -- Markdown JSON header highlight plugin
		-- use({ "elzr/vim-json", ft = { "json", "markdown" } })

		-- Super fast buffer jump
		use({
			"phaazon/hop.nvim",
			config = [[require('config.hop')]],
		})

		-- show keybindings
		-- use({
		-- "folke/which-key.nvim",
		-- config = [[require('config.which-key')]],
		-- })

		-- Show current search term in different color
		use({
			"PeterRincker/vim-searchlight",
		})

		-- Clear highlight search automatically for you
		use({
			"romainl/vim-cool",
		})

		-- Colorschemes
		use({ "sainnhe/edge" })

		use({ "sainnhe/sonokai" })

		use({
			"NTBBloodbath/doom-one.nvim",
			config = function()
				require("doom-one").setup({
					cursor_coloring = true,
					terminal_colors = true,
					italic_comments = true,
					enable_treesitter = true,
					transparent_background = true,
					pumblend = {
						enable = true,
						transparency_amount = 20,
					},
					plugins_integrations = {
						neorg = true,
						barbar = true,
						bufferline = false,
						gitgutter = false,
						gitsigns = true,
						telescope = true,
						neogit = false,
						nvim_tree = true,
						dashboard = false,
						startify = false,
						whichkey = false,
						indent_blankline = true,
						vim_illuminate = false,
						lspsaga = false,
					},
				})
			end,
		})

		use({ "sainnhe/everforest" })

		use({ "EdenEast/nightfox.nvim" })

		use({ "Mofiqul/dracula.nvim" })

		use({ "mhartington/oceanic-next" })

		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = [[require("config.lualine")]],
		})

		-- Indent markers
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = [[require("config.indent-blankline")]],
		})

		use("tversteeg/registers.nvim")

		-- notification plugin
		-- use({
		-- "rcarriga/nvim-notify",
		-- config = [[require("config.nvim-notify")]],
		-- })

		-- Escape faster with "jj" or "jk" or whatever
		use({
			"jdhao/better-escape.vim",
		})

		-- Syntax check and make
		use("neomake/neomake")

		-- Auto format tools
		use({
			"sbdchd/neoformat",
			cmd = "Neoformat",
		})

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
		use({ "rbong/vim-flog", requires = "tpope/vim-fugitive" })

		-- Additional powerful text object for vim, this plugin should be studied
		-- carefully to use its full power
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
		})

		-- Latex stuff
		use({
			"lervag/vimtex",
			ft = { "tex", "bib" },
		})

		-- Modern matchit implementation
		use({
			"andymass/vim-matchup",
		})

		-- Asynchronous command execution
		use({
			"skywind3000/asyncrun.vim",
			opt = true,
			cmd = "AsyncRun",
		})

		-- Calculate statistics for visual selection
		-- use({
		-- "wgurecky/vimSum",
		-- })

		-- REPL for nvim
		-- use({
		-- "hkupty/iron.nvim",
		-- config = [[require("config.iron")]],
		-- })

		-- The missing auto-completion for cmdline!
		use({
			"gelguy/wilder.nvim",
			requires = {
				"nixprime/cpsm",
				"romgrk/fzy-lua-native",
				"kyazdani42/nvim-web-devicons",
			},
			config = [[require("config.wilder")]],
		})

		-- File Explorer
		use({
			"kyazdani42/nvim-tree.lua",
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

		-- use({
		-- "easymotion/vim-easymotion",
		-- config = [[require("config.easymotion")]],
		-- })

		-- Better Quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			config = [[require("config.bqf")]],
		})

		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("config.barbar")]],
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "VimEnter" })
		-- -- puts list of buffers on top
		-- use({
		-- "akinsho/bufferline.nvim",
		-- config = [[require("config.bufferline")]],
		-- })
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
