
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

set incsearch
set hlsearch
set autoindent
set ignorecase
set smartcase

set makeprg=card-report\ --strict\ --no-color\ -sO/tmp/report\ %
set errorformat^=%*[^:]:\ %f:\ %m
set errorformat^=%*[^:]:\ %f:%l\ %m
set errorformat^=%*[^:]:\ %f:%l:%c\ %m
set errorformat^=%*[^:]:\ %f>\ %m
set errorformat^=%*[^:]:\ при\ валидации\ %f>\ %m
set errorformat^=%*[^:]:\ %f>\ найдены\ %m


noremap <F9> :write<CR>:!card-report -D % <CR><CR>
