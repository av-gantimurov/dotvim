
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

set incsearch
set hlsearch
set autoindent
set ignorecase
set smartcase

set makeprg=card-report\ --strict\ --no-color\ --mitre\ en\ --overwrite\ -sO/tmp/report\ %
set errorformat^=%*[^:]:\ %f:\ %m
set errorformat^=%*[^:]:\ %f:%l\ %m
set errorformat^=%*[^:]:\ %f:%l:%c\ %m
set errorformat^=%*[^:]:\ %f>\ %m
set errorformat^=%*[^:]:\ при\ валидации\ %f>\ %m
set errorformat^=%*[^:]:\ при\ создании\ отчёта\ %f>\ %m
set errorformat^=%*[^:]:\ %f>\ найдены\ %m

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'


noremap <F9> :write<CR>:!card-report % --overwrite -O/tmp/repo<CR><CR>:!xdg-open /tmp/repo.docx<CR>
