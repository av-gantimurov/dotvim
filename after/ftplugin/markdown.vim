
" open current file in Firefox new window 
" using for markdown file 
noremap <F9> :write<CR>:!firefox --new-window %:p<CR><CR>
inoremap <F9> <ESC>:write<CR>:!firefox --new-window %:p<CR><CR>

