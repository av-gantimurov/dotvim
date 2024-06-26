" most settings from https://raw.githubusercontent.com/mhinz/vim-galore/master/static/minimal-vimrc.vim

" set term=kitty
set background=dark
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set autoread                " Reload buffer if detected changes via external
                            " command. Used with checktime
set backspace   =indent,eol,start  " Make backspace work as you would expect
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
if has('colorcolumn')
    set colorcolumn=+1,+2,+3  "Highlight columns after 'textwidth' column
endif

if has('statusline')
    set statusline =
    " Date of the last time the file was saved
    set statusline +=%{strftime(\"[%d/%m/%y\ %T]\",getftime(expand(\"%:p\")))}
    " https://stackoverflow.com/questions/5983906/vim-conditionally-use-fugitivestatusline-function-in-vimrc
    set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
    " File description
    set statusline +=\ %f\ %h%m%r%w
    " Filetype
    set statusline +=%y
    " Name of the current function (needs taglist.vim)
    " set statusline +=\ [Fun(%{Tlist_Get_Tagname_By_Line()})]
    " Buffer number
    " Total number of lines in the file
    set statusline +=%=BN:%n
    " Line, column and percentage
    set statusline +=\ %=%-(%L/%l,%c%V%)\ %P
endif

set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
" set ttyfast                " Faster redrawing.
" set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set modeline                " Turn on :vim settings in comments

set helplang=ru

"Enable mouse support
if has("mouse")
    set mouse=a
endif
set mousehide       " Hide mouse pointer on insert mode."

"show number at every line
set number

if has('multi_byte')
    set encoding=utf-8                                  " set charset translation encoding
    set termencoding=utf-8                              " set terminal encoding
    set fileencoding=utf-8                              " set save encoding
    set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок,
                                                        " в порядке предпочтения
endif

set list                   " Show non-printable characters.

if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:·'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.,eol:$,trail:·'
endif

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
if isdirectory($HOME . '/.vim/files/backup') == 0
    call mkdir($HOME . '/.vim/files/backup', 'p')
endif
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
" Change swap directory.
if isdirectory($HOME . '/.vim/files/swap') == 0
    call mkdir($HOME . '/.vim/files/swap', 'p')
endif
set directory   =$HOME/.vim/files/swap//
set updatecount =100

" set undo settings
" from book "Modern.Vim.2018" tip 24
set undofile
if !has('nvim')
    if isdirectory($HOME . '/.vim/files/undo') == 0
        call mkdir($HOME . '/.vim/files/undo', 'p')
    endif
    set undodir=$HOME/.vim/files/undo
endif


if has('eval')
    silent! packadd minpac
    " minpac is available.
    " init with verbosity 3 to see minpac work
    silent! call minpac#init({'verbose': 3})
endif

if exists('*minpac#init')
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Additional plugins here.
    call minpac#add('nvie/vim-flake8')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('chrisbra/csv.vim')
    call minpac#add('dense-analysis/ale')
    call minpac#add('ConradIrwin/vim-bracketed-paste')
    call minpac#add('sunaku/vim-dasht')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('lyokha/vim-xkbswitch')

    " minpac utility commands
    command! PackUpdate call minpac#update()
    command! PackClean call minpac#clean()
    command! PackStatus call minpac#status()

    " Plugin settings here.
    " ...
else
    if has('autocmd')
        autocmd VimEnter *  echohl WarningMsg |
            \ echom "minpac loading fault." |
            \ echom "try 'git clone https://github.com/k-takata/minpac.git
            \ ~/.vim/pack/minpac/opt/minpac' if not installed" |
            \ echohl None
    endif
endif

if has('eval')
    let g:csv_delim_test=';,|'
endif

if has("autocmd")

" start with template if create new file with extension
    let templates_dir = $HOME . '/.vim/templates'
    let templates = {
        \ 'src.json'     : 'skeleton.src.json',
        \ 'src.yaml'     : 'skeleton.src.yaml',
        \ '*.yar'        : 'skeleton.yar',
        \ '*.py'         : 'skeleton.py',
        \ 'ida*.py'      : 'skeleton.ida.py',
        \}

    augroup templates
        for [extension, filename] in items(templates)
            let template_filename = templates_dir . "/" . filename
            if filereadable(template_filename)
                " echo extension template_filename
                execute "autocmd BufNewFile " extension "0r" template_filename
            endif
        endfor
        " autocmd BufNewFile *.yar 0r ~/.vim/templates/skeleton.yar
        " autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        " autocmd BufNewFile src.json 0r ~/.vim/templates/skeleton.src.json
    augroup end

    " nowrite undofile if buffer from /tmp directory
    " in case editing password, shadow, sudoers etc.
    augroup vimrc
        autocmd!
        autocmd BufWritePre /tmp/* setlocal noundofile
    augroup END

    " Disables number in terminal window in Vim
    " https://vi.stackexchange.com/questions/17368/how-could-i-turn-off-the-terminal-line-number-while-keep-the-editor-line-number
    if has('terminal') && exists('##TerminalOpen')
        autocmd TerminalOpen * if &buftype == 'terminal' |
                                \ setlocal nonumber |
                                \ setlocal bufhidden=hide |
                                \ endif
    endif

    "https://vim.fandom.com/wiki/Faster_loading_of_large_files
    " file is large from 10mb
    let g:LargeFile = 1024 * 1024 * 10
    augroup LargeFile
        autocmd BufReadPre * let f=getfsize(expand("<afile>")) |
            \ if f > g:LargeFile || f == -2 | call LargeFile() | endif
    augroup END

    function LargeFile()
        " no syntax highlighting etc
        set eventignore+=FileType
        " save memory when other file is viewed
        setlocal bufhidden=unload
        " is read-only (write with :w new_filename)
        setlocal buftype=nowrite
        " no undo possible
        setlocal undolevels=-1
        " display message
        autocmd VimEnter *  echohl WarningMsg |
            \ echo "The file is larger than " .
            \ (g:LargeFile / 1024 / 1024) . " MB, so some options are changed " .
            \ "(see .vimrc for details)." | echohl None
    endfunction

endif

" Syntax

if has('eval')
    filetype plugin indent on " Load plugins according to detected filetype.
    " Add :Man functionality
    " Yara Syntax
    autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara
endif

if has('eval')
    runtime ftplugin/man.vim
endif

if has('syntax')
    syntax on                  " Enable syntax highlighting.
endif

if has('eval')
    " My private rules here
    let priv_vimrc = $MYVIMRC . ".private"
    exec "source " . priv_vimrc

    " hotkeys in separate file
    let hotkeys_rc = $MYVIMRC . ".hotkeys"
    exec "source " . hotkeys_rc
endif


" Netrw settings
"
let g:netrw_winsize = 30

let g:ale_linters = {
\   'rust': ['cargo', 'rls']
\}

let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1


let g:XkbSwitchEnabled = 1
" let g:XkbSwitchNLayout = 'us'
let g:XkbSwitchKeymapNames = {'Russian' : 'ru'}

let $BASH_ENV = "~/.bash_aliases"


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.colnr = ' ㏇:'
" let g:airline_symbols.colnr = ' ℅:'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = ' ␊:'
" let g:airline_symbols.linenr = ' ␤:'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
" let g:airline#extensions#keymap#enabled = 0 "Не показывать текущий маппинг
" let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
let g:Powerline_symbols='unicode' "Поддержка unicode
" let g:airline#extensions#xkblayout#enabled = 0 "Про это позже расскажу
let g:airline#extensions#xkblayout#short_codes = {
\ 'English (US)': 'US',
\ 'Russian': 'RU',
\}

let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }
