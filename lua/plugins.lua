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
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "BufEnter",
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			event = "BufEnter",
			after = "nvim-treesitter-textobjects",
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
		use({
			"windwp/nvim-autopairs",
			config = [[require("config.nvim-autopairs")]],
		})

		-- Super fast buffer jump
		use({
			"phaazon/hop.nvim",
			event = "VimEnter",
			config = [[require('config.hop')]],
		})

		-- Show current search term in different color
		use({
			"PeterRincker/vim-searchlight",
			event = "VimEnter",
		})

		-- Clear highlight search automatically for you
		use({
			"romainl/vim-cool",
			event = "VimEnter",
		})

		-- Colorschemes
		use({ "sainnhe/everforest", opt = true })

		use({ "Mofiqul/dracula.nvim", opt = true })

		use({ "mhartington/oceanic-next", opt = true })

		-- icons
		use({ "kyazdani42/nvim-web-devicons" })

		-- status line
		use({
			"hoob3rt/lualine.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = [[require("config.lualine")]],
		})

		-- Indent markers
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "VimEnter",
		})

		-- Better register. Use " in Normal or <c-r> in insert
		use({ "tversteeg/registers.nvim", event = "BufEnter" })

		-- notification plugin
		use({
			"rcarriga/nvim-notify",
			config = [[require("config.nvim-notify")]],
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

		-- The missing auto-completion for cmdline!
		use({
			"gelguy/wilder.nvim",
			setup = [[vim.cmd('packadd wilder.nvim')]],
			requires = {
				"romgrk/fzy-lua-native",
				"kyazdani42/nvim-web-devicons",
			},
			run = ":UpdateRemotePlugsin",
			config = [[require("config.wilder")]],
		})

		-- File Explorer
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

		-- use({
		-- "easymotion/vim-easymotion",
		-- config = [[require("config.easymotion")]],
		-- })

		-- Better Quickfix window
		use({
			"kevinhwang91/nvim-bqf",
			event = "VimEnter",
			config = [[require("config.bqf")]],
		})

		use({
			"romgrk/barbar.nvim",
			event = "VimEnter",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("config.barbar")]],
		})

		-- show and trim trailing whitespaces
		use({ "jdhao/whitespace.nvim", event = "VimEnter" })
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
