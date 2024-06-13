-- set colorscheme  with protected call
-- in case it isn't installed

-- onedark colorscheme options
-- vim.cmd([[
-- " let g:onedark_hide_endofbuffer = 1
-- " let g:onedark_termcolors = 256
-- " let g:onedark_terminal_italics = 1
-- " let g:onedark_config = {
-- " \ 'style':'darker',
-- " \}
-- ]])

-- require("nightfox").setup({
-- 	options = {
-- 		transparent = false,
-- 		styles = {
-- 			comments = "italic",
-- 			keywords = "bold",
-- 			types = "italic,bold",
-- 		},
-- 	},
-- })
-- local status, _ = pcall(vim.cmd, "colorscheme nightfox")
-- if not status then
-- 	print("Colorscheme not found!") -- print error if colorscheme not installed
-- 	return
-- end
-- vim.cmd([[ highlight Normal guibg=None ]])
-- vim.api.nvim_set_hl(0, "Comment", { italic = true })
-- ==========================================================================
-- setup for catppuccin theme
require("catppuccin").setup({
	flavour = "auto", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = true, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {},
	custom_highlights = {},
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
