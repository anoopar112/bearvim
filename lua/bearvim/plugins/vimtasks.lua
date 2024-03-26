-- vimtasks configuration
vim.cmd([[
let g:TasksDateFormat = '%Y-%m-%d %H:%M'
autocmd BufNewFile,BufReadPost *.md set filetype=tasks.vimwiki
autocmd BufWritePost todo.md,doing.md,done.md !mvTodos && upwiki
autocmd BufWritePost *.md !upwiki 
]])
