-- ****************************************
-- *************** Packages ***************
-- ****************************************

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer manages itself
	use("wbthomason/packer.nvim")

	-- Language server setup with zero config
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/nvim-lsp-installer" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- allows non-lsp processes (prettier, eslint) to run lsp-like
	use("jose-elias-alvarez/null-ls.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("config._treesitter")
		end,
	})

	-- Dependencies for modern nvim plugins (for telescope, neo-tree, lualine etc)
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lua/popup.nvim")
	use("MunifTanjim/nui.nvim")
	use("sharkdp/fd")
	use("nvim-lua/plenary.nvim")

	-- Trouble: better quickfixlists
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				action_keys = { open_tab = "<c-q>" },
			})
		end,
	})

	-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config._telescope")
		end,
	})

	use({
		"~/WebDev/warped.nvim",
		requires = { "tjdevries/colorbuddy.nvim", "rktjmp/fwatch.nvim" },
		config = function()
			require("warped").setup({
				theme_config = function(Color, colors, Group, groups, styles)
					require("warped.default_theme_config")(Color, colors, Group, groups, styles)
					Group.new("CursorLine", colors.none, colors.none, styles.bold)
					Group.new("Folded", colors.none, colors.white)
				end,
			})
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = function()
			require("config._neotree")
		end,
	})

	-- surround selected code, mapped to shift-S
	use({
		"tpope/vim-surround",
		config = function()
			require("config._surround")
		end,
	})

	-- legendary git plugin
	use("tpope/vim-fugitive")

	-- comment plugin... lol @tpope
	use("tpope/vim-commentary")

	-- Github Copilot lua
	use("github/copilot.vim")

	-- Git signs
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config._lualine")
		end,
	})
end)
