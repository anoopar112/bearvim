vim.opt.list = false
vim.opt.listchars:append("eol:↴")
-- import indent blankline safely
local indent_blankline_setup, indent_blankline = pcall(require, "ibl")
if not indent_blankline_setup then
	return
end
indent_blankline.setup({
	exclude = { filetypes = { "startify" } },
})
