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
	"nvim-lua/plenary.nvim", -- lua functions that many plugins
	"mhinz/vim-startify", -- for the startup dashboard
	-- ("anoopar112/deus-colorscheme",
	-- ("navarasu/onedark.nvim",
	-- ("EdenEast/nightfox.nvim", -- current colorscheme. can change in core/colorscheme
	{ "catppuccin/nvim", as = "catppuccin" },
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	-- essential plugins
	"tpope/vim-surround", -- add, delete, change surroundings it's awesome,
	"Shatur/neovim-session-manager",
	-- commenting with gc
	"numToStr/Comment.nvim",
	-- show keycombinations like spacemacs
	"folke/which-key.nvim",
	"folke/todo-comments.nvim",
	-- file explorer
	"nvim-tree/nvim-tree.lua",
	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",
	-- statusline & tabline
	"nvim-lualine/lualine.nvim",
	-- using packer.nvim
	{ "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	-- fuzzy finding w/ telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
	},
	-- autocompletion
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- source for text in buffer
	"hrsh7th/cmp-path", -- source for file system paths
	"hrsh7th/cmp-omni", -- omnifunction source
	"quangnguyen30192/cmp-nvim-tags",
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		-- install jsregexp optional!:,.
		build = "make install_jsregexp",
	},
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	-- managing & installing lsp servers, linters & formatters
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
	},
	-- configuring lsp servers
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
	"jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server e.g. rename file & update imports,
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
	{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose tags
	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side
	"tpope/vim-fugitive",
	-- python utilities
	"lukas-reineke/indent-blankline.nvim",
	-- vimwiki
	"vimwiki/vimwiki",
	"MattesGroeger/vim-bookmarks",
	"anoopar112/vim-tasks",
	"NvChad/nvim-colorizer.lua",
	--octodown markdown preview
	"skywind3000/asyncrun.vim", -- for mac
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	"lervag/vimtex",
	-- project management
	{
		"ahmedkhalf/project.nvim",
	},
	"elkowar/yuck.vim",
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{ -- Autoformat
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
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
			},
			-- If this is set, Conform will run the formatter asynchronously after save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_after_save = {
				lsp_fallback = true,
			},
		},
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
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

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					-- ["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					-- ["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
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

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "path" },
					{
						name = "buffer",
						priority = 10,
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "nvim_lsp", priority = 9 },
					{ name = "tags", priority = 8 },
					{ name = "treesitter", priority = 7 },
					{ name = "luasnip", priority = 6 },
					{ name = "path" },
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
})
