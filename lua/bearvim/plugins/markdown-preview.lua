-- Configuration for iamcco/markdown-preview.nvim

-- Do not auto start preview window when opening markdown buffer
vim.g.mkdp_auto_start = 0

-- Keep preview open when switching buffers
vim.g.mkdp_auto_close = 0

-- Auto refresh markdown in real-time as you edit or move the cursor
vim.g.mkdp_refresh_slow = 0

-- Enable MarkdownPreview for markdown, vimwiki, and tasks
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_filetypes = { "markdown", "vimwiki", "tasks" }

-- Server settings
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = ""
vim.g.mkdp_port = ""
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browser = ""
vim.g.mkdp_browserfunc = ""

-- Page title
vim.g.mkdp_page_title = "「${name}」"

-- Theme: "dark" to match editor colorscheme
vim.g.mkdp_theme = "dark"

-- Custom GitHub CSS stylesheet (absolute path)
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/bearvim/assets/github-markdown.css")
vim.g.mkdp_highlight_css = ""

-- Markdown render options (Math, Mermaid diagrams, KaTeX, UML, TOC)
vim.g.mkdp_preview_options = {
	mkit = {},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = 0,
	sync_scroll_type = "middle",
	hide_yaml_meta = 1,
	sequence_diagrams = {},
	flowchart_diagrams = {},
	content_editable = false,
	disable_filename = 0,
	toc = {},
}
