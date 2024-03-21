-- vimtasks configuration
vim.cmd([[
let g:TasksDateFormat = '%Y-%m-%d %H:%M'
autocmd BufNewFile,BufReadPost todo.md,doing.md,done.md set filetype=tasks
autocmd BufWritePost todo.md,doing.md,done.md !mvTodos
]])
