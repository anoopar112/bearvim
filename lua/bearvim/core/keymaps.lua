-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

local km = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------
km.set("n", "<leader>wj", "<C-W><C-J>")
km.set("n", "<leader>wk", "<C-W><C-K>")
km.set("n", "<leader>wl", "<C-W><C-L>")
km.set("n", "<leader>wh", "<C-W><C-H>")
km.set("n", "<leader>w=", "<C-W><C-=>")

km.set("i", "jj", "<Esc>")
km.set("n", "<leader>jj", "<Esc>:silent! w<CR>")

km.set("n", "<leader>ff", ":NvimTreeFindFileToggle<CR>")
-- telescope
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")

km.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
km.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
km.set("n", "<leader><leader>", builtin.find_files, { desc = "[S]earch [F]iles" })
km.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
km.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
km.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
km.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
km.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
km.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
km.set("n", "<leader>bb", builtin.buffers, { desc = "[ ] Find existing buffers" })
km.set("n", "<leader>sb", ":Telescope bookmarks list<CR>", { desc = "[ ] Find existing bookmarks" })

-- Slightly advanced example of overriding default behavior and theme
km.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
km.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
km.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- buffer and tab management
km.set("n", "<leader>wq", ":wq<CR>")
km.set("n", "<leader>wc", ":q<CR>")
km.set("n", "<leader>bd", ":bd<CR>")
km.set("n", "<leader>tc", ":tabclose<CR>")
km.set("n", "<leader>bn", ":bn<CR>")
km.set("n", "<leader>bp", ":bp<CR>")

km.set("n", "<leader>nh", ":noh<CR>")
-- octodown preview
km.set("n", "<leader>mp", ":AsyncRun octodown --style=github -l %<CR>")
-- tasks keybindings
km.set("n", "<leader>tt", "<Plug>(TasksToggleTask)") -- toggle tasks
km.set("n", "<leader>tr", "<Plug>(TasksToggleAndClearTask)") -- remove task
km.set("n", "<leader>td", "<Plug>(TasksCompleteTask)") -- mark as done/complete
km.set("n", "<leader>tc", "<Plug>(TasksCancelTask)") -- cancel a task.
km.set("n", "<leader>ts", "<Plug>(TasksSortTasks)") -- sort all tasks.
km.set("n", "<leader>ta", "<Plug>(TasksArchiveTasks)") -- archive a task.
km.set("n", "<leader>tb", "<Plug>(TasksBeginTask)") -- mark progress of a task.

km.set("n", "<leader>vt", ":put=strftime('# %d.%m.%Y TASKS:')<CR>")
-- ====================================================================
-- ADVANCED TIME-TRACKING TASK MANAGEMENT
-- ====================================================================

-- 1. START / RESUME TASK (Work in Progress)
km.set("n", "<leader>btp", function()
	local line = vim.api.nvim_get_current_line()

	-- Change square icon (☐) to double chevron (») if not already active
	if line:match("☐") then
		line = line:gsub("☐", "»", 1)
		vim.api.nvim_set_current_line(line)
	end

	-- Create a next line with @start(<date>)
	local date_str = vim.fn.strftime("%Y-%m-%d %H:%M")
	local current_row = vim.api.nvim_win_get_cursor(0)[1]

	vim.api.nvim_buf_set_lines(0, current_row, current_row, false, { "    @start(" .. date_str .. ")" })
end, { desc = "Task: Start/Resume WIP" })

-- 2. PAUSE TASK (Suspend and save intermediate time)
km.set("n", "<leader>bts", function()
	local line = vim.api.nvim_get_current_line()

	-- Only pause if it's currently active
	if line:match("»") then
		line = line:gsub("»", "☐", 1)
	else
		vim.notify("Task is not currently running!", vim.log.levels.WARN)
		return
	end

	local current_row = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)

	if current_row < total_lines then
		local next_line = vim.api.nvim_buf_get_lines(0, current_row, current_row + 1, false)[1]
		local start_str = next_line:match("@start%((%d%d%d%d%-%d%d%-%d%d %d%d:%d%d)%)")

		if start_str then
			-- Calculate current session minutes
			local year, month, day, hour, min = start_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+)")
			local start_time = os.time({
				year = tonumber(year),
				month = tonumber(month),
				day = tonumber(day),
				hour = tonumber(hour),
				min = tonumber(min),
			})
			local diff_mins = math.floor(os.difftime(os.time(), start_time) / 60)

			-- Look for existing accumulated time to add up
			local existing_h, existing_m = line:match("@worked%((%d+)h(%d+)min%)")
			if existing_h and existing_m then
				diff_mins = diff_mins + (tonumber(existing_h) * 60) + tonumber(existing_m)
				line = line:gsub("%s*@worked%([0-9hmin]+%)", "") -- strip old tag
			end

			-- Append updated tracking
			local hours = math.floor(diff_mins / 60)
			local mins = diff_mins % 60
			line = line .. string.format(" @worked(%dh%dmin)", hours, mins)

			-- Remove the @start helper line
			vim.api.nvim_buf_set_lines(0, current_row, current_row + 1, false, {})
		end
	end

	vim.api.nvim_set_current_line(line)
end, { desc = "Task: Pause active session" })

-- 3. COMPLETE TASK (Mark Done & close out all accumulated time)
km.set("n", "<leader>btd", function()
	local line = vim.api.nvim_get_current_line()

	-- Change icon to checkmark
	line = line:gsub("☐", "✔", 1):gsub("»", "✔", 1)

	local current_row = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)
	local diff_mins = 0
	local has_active_session = false

	-- Grab final session time if it was running when completed
	if current_row < total_lines then
		local next_line = vim.api.nvim_buf_get_lines(0, current_row, current_row + 1, false)[1]
		local start_str = next_line:match("@start%((%d%d%d%d%-%d%d%-%d%d %d%d:%d%d)%)")

		if start_str then
			has_active_session = true
			local year, month, day, hour, min = start_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+)")
			local start_time = os.time({
				year = tonumber(year),
				month = tonumber(month),
				day = tonumber(day),
				hour = tonumber(hour),
				min = tonumber(min),
			})
			diff_mins = math.floor(os.difftime(os.time(), start_time) / 60)
			vim.api.nvim_buf_set_lines(0, current_row, current_row + 1, false, {})
		end
	end

	-- Accumulate any past paused history
	local existing_h, existing_m = line:match("@worked%((%d+)h(%d+)min%)")
	if existing_h and existing_m then
		diff_mins = diff_mins + (tonumber(existing_h) * 60) + tonumber(existing_m)
		line = line:gsub("%s*@worked%([0-9hmin]+%)", "")
	end

	local worked_str = ""
	if has_active_session or (existing_h and existing_m) then
		local hours = math.floor(diff_mins / 60)
		local mins = diff_mins % 60
		worked_str = string.format(" @worked(%dh%dmin)", hours, mins)
	end

	local date_str = vim.fn.strftime("%Y-%m-%d %H:%M")
	line = line .. "  @done(" .. date_str .. ")" .. worked_str
	vim.api.nvim_set_current_line(line)
end, { desc = "Task: Complete and close tracking" })

-- Expand snippet
km.set("i", "<C-j>", "<Plug>luasnip-expand-or-jump")

km.set(
	"n",
	"#",
	":let save_cursor=getcurpos()|let @/ = expand('<cword>')|set hlsearch<CR>w?<CR>:%s///gn<CR>:call setpos('.', save_cursor)<CR>"
)

km.set("n", "J", "J0")

-- Diagnostic keymaps
km.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
km.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
km.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
km.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
