
" open current file in Firefox new window 
" using for markdown file 
noremap <F9> :write<CR>:!okular %:p &<CR><CR>
inoremap <F9> <ESC>:write<CR>:!okular %:p & <CR><CR>

