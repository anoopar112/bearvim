-- set colorscheme to dues with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme deus")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
-- vim.cmd([[ highlight Normal guibg=None ]])
vim.api.nvim_set_hl(0, "Comment", { italic = true })
