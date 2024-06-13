-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
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
local builtin = require 'telescope.builtin'
km.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
km.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
km.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
km.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
km.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
km.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
km.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
km.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
km.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
km.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
km.set('n', '<leader>/', function()
-- You can pass additional configuration to Telescope to change the theme, layout, etc.
builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  winblend = 10,
  previewer = false,
})
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
km.set('n', '<leader>s/', function()
builtin.live_grep {
  grep_open_files = true,
  prompt_title = 'Live Grep in Open Files',
}
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
km.set('n', '<leader>sn', function()
builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })


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
