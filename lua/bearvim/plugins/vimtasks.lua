-- vimtasks configuration
vim.cmd([[
let g:TasksDateFormat = '%Y-%m-%d %H:%M'
autocmd BufNewFile,BufReadPost *.tasks.md set filetype=tasks
]])
