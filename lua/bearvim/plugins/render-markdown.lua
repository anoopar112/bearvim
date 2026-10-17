local status, render_markdown = pcall(require, "render-markdown")
if not status then
	return
end

render_markdown.setup({
	-- Enable rendering for markdown, vimwiki, and tasks
	file_types = { "markdown", "vimwiki", "tasks" },

	-- Normal, command, terminal, and insert modes
	render_modes = { "n", "c", "t", "i" },

	heading = {
		enabled = true,
		sign = false,
		position = "overlay",
		icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
		signs = { "󰫎 " },
		width = "full",
		left_pad = 0,
		right_pad = 0,
		min_width = 0,
		border = false,
		border_virtual = false,
		border_prefix = false,
		above = "▄",
		below = "▀",
		backgrounds = {
			"RenderMarkdownH1Bg",
			"RenderMarkdownH2Bg",
			"RenderMarkdownH3Bg",
			"RenderMarkdownH4Bg",
			"RenderMarkdownH5Bg",
			"RenderMarkdownH6Bg",
		},
		foregrounds = {
			"RenderMarkdownH1",
			"RenderMarkdownH2",
			"RenderMarkdownH3",
			"RenderMarkdownH4",
			"RenderMarkdownH5",
			"RenderMarkdownH6",
		},
	},

	code = {
		enabled = true,
		sign = false,
		style = "full",
		position = "left",
		language_pad = 0,
		language_name = true,
		disable_background = { "diff" },
		width = "full",
		left_pad = 1,
		right_pad = 1,
		min_width = 0,
		border = "thin",
		above = "▄",
		below = "▀",
		highlight = "RenderMarkdownCode",
		highlight_inline = "RenderMarkdownCodeInline",
	},

	dash = {
		enabled = true,
		icon = "─",
		width = "full",
		highlight = "RenderMarkdownDash",
	},

	bullet = {
		enabled = true,
		icons = { "●", "○", "◆", "◇" },
		left_pad = 0,
		right_pad = 0,
		highlight = "RenderMarkdownBullet",
	},

	checkbox = {
		enabled = true,
		position = "inline",
		unchecked = {
			icon = "󰄱 ",
			highlight = "RenderMarkdownUnchecked",
			scope_highlight = nil,
		},
		checked = {
			icon = "󰄬 ",
			highlight = "RenderMarkdownChecked",
			scope_highlight = nil,
		},
		custom = {
			todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
		},
	},

	pipe_table = {
		enabled = true,
		preset = "round",
		style = "full",
		cell = "padded",
		padding = 1,
		min_width = 0,
		border = {
			"╭", "┬", "╮",
			"├", "┼", "┤",
			"╰", "┴", "╯",
			"│", "─",
		},
		alignment_indicator = "━",
		head = "RenderMarkdownTableHead",
		row = "RenderMarkdownTableRow",
		filler = "RenderMarkdownTableFill",
	},

	callout = {
		-- GitHub and Obsidian callouts
		note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
		tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
		important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
		warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
		caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
		todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
		abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
		summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
		tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
		info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
		hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
		success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
		question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
		failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
		danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
		bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
		example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
		quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
	},

	link = {
		enabled = true,
		image = "󰥶 ",
		email = "󰀓 ",
		hyperlink = "󰌹 ",
		highlight = "RenderMarkdownLink",
		wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
		custom = {
			web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
		},
	},

	sign = {
		enabled = false,
	},

	-- Anti-conceal allows editing the raw line seamlessly when the cursor is on it
	anti_conceal = {
		enabled = true,
		disabled_modes = false,
		above = 0,
		below = 0,
	},

	-- Auto-completion for checkboxes and callouts via nvim-cmp
	completions = {
		lsp = { enabled = true },
	},
})
