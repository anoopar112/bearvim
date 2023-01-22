-- settings for dashboard/startup screen.

vim.cmd([[

let g:bearvim_header = [
\	"",
\	"██████╗ ███████╗ █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
\	"██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║██║████╗ ████║",
\	"██████╔╝█████╗  ███████║██████╔╝██║   ██║██║██╔████╔██║",
\	"██╔══██╗██╔══╝  ██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
\	"██████╔╝███████╗██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
\	"╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
\	"                                                       ",
\ ]
let g:startify_custom_header = 'startify#center(g:bearvim_header)'
let g:startify_lists = [
    \ { 'type': 'files',     'header': startify#center(['MRU']) },
    \ ]

let g:startify_padding_left = 10 " Hard coded padding for lists

]])
