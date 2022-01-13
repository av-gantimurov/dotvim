
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
set errorformat^=%*[^:]:\ %f:%l:%c\ %m
set errorformat^=%*[^:]:\ %f:%l\ %m
set errorformat^=%*[^:]:\ %f:\ %m
set errorformat^=%*[^:]:\ %f>\ %m
set errorformat^=%*[^:]:\ %f>\ %s:\ %m
