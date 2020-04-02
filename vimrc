" most settings from https://raw.githubusercontent.com/mhinz/vim-galore/master/static/minimal-vimrc.vim
if has('syntax')
    syntax on                  " Enable syntax highlighting.
endif

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
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set modeline                " Turn on :vim settings in comments

set helplang=ru

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:·'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.,eol:$,trail:·'
endif

"Enable mouse support
if has("mouse")
    set mouse=a
endif
set mousehide       " Hide mouse pointer on insert mode."

"show number at every line
set number

if has('keymap')
    " установить keymap, чтобы по Ctrl+^ переключался на русский и обратно
    set keymap=russian-jcukenwin
    " по умолчанию - латинская раскладка
    set iminsert=0
    " по умолчанию - латинская раскладка при поиске
    set imsearch=0
endif

if has('multi_byte')
    set encoding=utf-8                                  " set charset translation encoding
    set termencoding=utf-8                              " set terminal encoding
    set fileencoding=utf-8                              " set save encoding
    set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок,
                                                        " в порядке предпочтения
endif

if has('wildmenu')
    set wildmenu
    set wcm=<Tab>
    menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
    menu Encoding.cp1251  :e ++enc=cp1251<CR>
    menu Encoding.cp866   :e ++enc=cp866<CR>
    menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
    menu Encoding.utf-8   :e ++enc=utf-8<CR>
    map <F12> :emenu Encoding.<Tab>
endif

:nnoremap <F5> "=strftime("%b %Y")<CR>p
:nnoremap <S-F5> "=strftime("%Y-%m-%d %H:%M")<CR>p
:inoremap <S-F5> <C-R>"=strftime("%Y-%m-%d %H:%M")<CR>
:inoremap <F5> <C-R>=strftime("%b %Y")<CR>
:nnoremap <F4> :echo strftime("%F %T",expand("<cword>"))<CR>

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

" start with template if create new file with extension

"Packages
if has('packadd')
    "minpac
    silent! packadd minpac
endif
if exists('*minpac#init')
  " minpac is available.
  " init with verbosity 3 to see minpac work
  call minpac#init({'verbose': 3})
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  call minpac#add('nvie/vim-flake8')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('lifepillar/vim-cheat40', {'type': 'opt'})

  " minpac utility commands
  command! PackUpdate call minpac#update()
  command! PackClean call minpac#clean()
  command! PackStatus call minpac#status()

  " Plugin settings here.
  " ...
endif

if has("autocmd")
    if !exists('*minpac#init')
      " minpac is not available.
        autocmd VimEnter *  echohl WarningMsg |
            \ echom "minpac plugin not found"|
            \ echom "try 'git clone https://github.com/k-takata/minpac.git
            \ ~/.vim/pack/minpac/opt/minpac'" |
            \ echohl None
    endif

    let templates_dir = $HOME . '/.vim/templates'
    let templates = {
        \ 'src.json'     : 'skeleton.src.json',
        \ '*.yar'        : 'skeleton.yar',
        \ '*.py'         : 'skeleton.py',
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
    if exists('##TerminalOpen')
        autocmd TerminalOpen * setlocal nonumber
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
filetype plugin indent on " Load plugins according to detected filetype.
" Yara Syntax
autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara

" Add :Man functionality
runtime ftplugin/man.vim
