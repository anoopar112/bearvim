-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Force composite filetype when Vimwiki tries to set it
vim.api.nvim_create_autocmd("FileType", {
	pattern = "vimwiki",
	desc = "Force composite filetype for Vimwiki files",
	group = vim.api.nvim_create_augroup("VimwikiCompositeFiletype", { clear = true }),
	callback = function(event)
		-- vim.schedule defers our change for a fraction of a millisecond,
		-- allowing Vimwiki to finish its internal link-following setup first.
		vim.schedule(function()
			local buf_name = vim.api.nvim_buf_get_name(event.buf)
			-- Verify the file is actually inside your vimwiki folder
			if buf_name:find("vimwiki") and vim.bo[event.buf].filetype == "vimwiki" then
				vim.bo[event.buf].filetype = "tasks.vimwiki.markdown"
			end
		end)
	end,
})
