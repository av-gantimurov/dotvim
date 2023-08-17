" hotkey to view documentation pydok by <S-H>
nnoremap <buffer> H :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

let b:ale_fixers = ['isort', 'yapf', 'black']
let b:ale_python_flake8_options = '--max-line-length=88 --ignore=E203'

set textwidth=79 " PEP-8 Friendly
