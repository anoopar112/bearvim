-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
	return
end
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ""
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
		end
		return str
	end
end

lualine.setup({
	options = {
		globalstatus = false, -- enable global statusline (have a single statusline
		theme = "everforest",
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icons_enabled = true,
				fmt = trunc(400, 1, nil, true),
			},
		},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				path = 0, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
			},
		},
		lualine_x = {
			{ "filetype" },
		},
	},
})
