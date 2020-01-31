" hotkey to view documentation pydok by <S-H>
nnoremap <buffer> H :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

set textwidth=79 " PEP-8 Friendly
