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

local status, _ = pcall(vim.cmd, "colorscheme nightfox")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
-- vim.cmd([[ highlight Normal guibg=None ]])
vim.api.nvim_set_hl(0, "Comment", { italic = true })
