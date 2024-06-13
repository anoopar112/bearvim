local opt = vim.opt -- for conciseness

opt.wrap = false
opt.number = true
opt.relativenumber = true
-- remove vi compatibility
opt.compatible = false
-- Don't show the mode, since it's already in the status line
opt.showmode = false
-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word
-- opt.cmdheight = 0
opt.fillchars = "fold: "
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.report = 99999
-- opt.shortmess = { --FIX: this is not working as of now.
-- 	F = true,
-- 	W = true,
-- 	A = true,
-- 	I = true,
-- 	c = true,
-- 	S = true,
-- }
opt.autoindent = false
vim.cmd([[
set shortmess+=FAIcSW
]])
-- set the cursor to line/beam in all modes
-- opt.guicursor = { "a:ver25" }

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
