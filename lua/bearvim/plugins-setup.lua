-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- add list of plugins to install
require("lazy").setup({
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"mhinz/vim-startify", -- for the startup dashboard
	"anoopar112/deus-colorscheme",
	"navarasu/onedark.nvim",
	"sainnhe/everforest",
	"EdenEast/nightfox.nvim", -- current colorscheme. can change in core/colorscheme
	{ "catppuccin/nvim", name = "catppuccin" }, -- Fixed: changed 'as' to 'name'
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	-- essential plugins
	"tpope/vim-surround", -- add, delete, change surroundings it's awesome,
	"Shatur/neovim-session-manager",
	-- commenting with gc
	"numToStr/Comment.nvim",
	-- show keycombinations like spacemacs
	"folke/which-key.nvim",
	"folke/todo-comments.nvim",

	-- Zen Mode
	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle [Z]en Mode" },
		},
		opts = {
			window = {
				backdrop = 1,
				width = 1,
				height = 1,
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
					wrap = true, -- NEW: Enable text wrapping
					linebreak = true, -- NEW: Wrap cleanly at word boundaries instead of mid-word
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					laststatus = 0, -- turn off the statusline in zen mode
				},
				twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				tmux = { enabled = false }, -- disables the tmux statusline
				todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
				alacritty = {
					enabled = false,
					font = "10", -- font size
				},
			},
		}, -- Fixed: Added missing closing brace for opts
	},

	-- file explorer
	"nvim-tree/nvim-tree.lua",
	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",
	-- statusline & tabline
	"nvim-lualine/lualine.nvim",
	{
		"nanozuki/tabby.nvim",
		event = "VimEnter", -- if you want lazy load, see below
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	-- fuzzy finding w/ telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
	},

	-- managing & installing lsp servers, linters & formatters
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
	},

	-- configuring lsp servers
	{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	-- formatting & linting
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
	{ "windwp/nvim-ts-autotag", dependencies = "nvim-treesitter/nvim-treesitter" }, -- Fixed: changed 'after' to 'dependencies'

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side
	"tpope/vim-fugitive",

	-- utilities
	"lukas-reineke/indent-blankline.nvim",
	"vimwiki/vimwiki",
	"tomasky/bookmarks.nvim",
	"anoopar112/vim-tasks",
	"NvChad/nvim-colorizer.lua",
	"skywind3000/asyncrun.vim", -- for mac

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("markview").setup({
				modes = { "n", "no", "c" },
				hybrid_modes = { "n" },
				callbacks = {
					on_enable = function(_, win)
						vim.wo[win].conceallevel = 2
						vim.wo[win].concealcursor = "c"
					end,
				},
			})
		end,
	},
	"lervag/vimtex",

	-- project management
	{
		"ahmedkhalf/project.nvim",
	},
	"elkowar/yuck.vim",

	-- Autoformat
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>fc",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				vue = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				yaml = { "prettierd", "prettier" },
				json = { "prettierd", "prettier" },
			},
			format_after_save = {
				lsp_fallback = true,
			},
		},
	},

	-- Autocompletion (Consolidated all cmp plugins here to remove duplicates)
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-omni",
			"quangnguyen30192/cmp-nvim-tags",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "luasnip", priority = 10 },
					{ name = "nvim_lsp" },
					{ name = "path" }, -- Removed the two duplicate path sources here
					{
						name = "buffer",
						priority = 10,
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "tags", priority = 8 },
					{ name = "treesitter", priority = 7 },
					{
						name = "omni",
						option = {
							disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
						},
					},
				},
			})
		end,
	},

	-- Minuet AI
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("minuet").setup({
				provider = "gemini",
				context_window = 512,
				provider_options = {
					gemini = {
						model = "gemini-2.5-flash",
						system = {
							prompt = "You are a senior developer providing intelligent code completions. Output only the code.",
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = {},
					keymap = {
						accept = "<A-y>",
						accept_line = "<A-a>",
						dismiss = "<A-e>",
						next = "<A-i>",
						prev = "<A-S-i>",
					},
				},
			})
		end,
	},
})
