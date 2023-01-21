vim.opt.list = false
vim.opt.listchars:append("eol:↴")
-- import indent blankline safely
local indent_blankline_setup, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_setup then
	return
end
indent_blankline.setup({
	show_end_of_line = false,
})
