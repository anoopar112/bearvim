-- set leader key to space
vim.g.mapleader = " "

local km = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------
km.set("n", "<leader>wj", "<C-W><C-J>")
km.set("n", "<leader>wk", "<C-W><C-K>")
km.set("n", "<leader>wl", "<C-W><C-L>")
km.set("n", "<leader>wh", "<C-W><C-H>")

km.set("i", "jj", "<Esc>")
km.set("n", "<leader>jj", "<Esc>:w<CR>")

km.set("n", "<leader>ff", ":NvimTreeFindFileToggle<CR>")
-- telescope
km.set("n", "<leader>pp", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
km.set("n", "<leader>ll", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
km.set("n", "<leader>gg", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
km.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
km.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
km.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
km.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
km.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

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

km.set("n", "<leader>vt", ":put=strftime('%Y%m%d_task')<CR>")

km.set("n", "<leader>btd", ":.put=strftime('@done(%Y-%m-%d %H:%M:%S)')<CR>kJ")
km.set("n", "<leader>btp", ":.put=strftime('@wip(%Y-%m-%d %H:%M:%S)')<CR>kJ")

-- lsp saga keybindings
km.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Expand snippet
km.set("i", "<C-j>", "<Plug>luasnip-expand-or-jump")
