" hotkey to view documentation pydok by <S-H>
" nnoremap <buffer> H :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

" let b:ale_fixers = ['isort', 'yapf', 'black']
let b:ale_fixers = g:ale_fixers['*'] + ['ruff', 'ruff_format']
let b:ale_linters = ['ruff']

" add isort warning, but disable it fix automatically (F401)
let b:ale_python_ruff_options = '--extend-select I --unfixable F401'

set textwidth=79 " PEP-8 Friendly
