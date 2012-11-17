set shortmess+=I

" tab
"set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" for putty
"set mouse=a
" for screen
"set ttymouse=xterm2

set notitle
set nonumber
set showcmd
set laststatus=2
set showmatch
set matchtime=2
set hlsearch
set wildmenu

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
"set fileencodings+=,ucs-2le,ucs-2,utf-8


" syntax
if &t_Co > 1
    syntax enable
endif

" color theme
"colorscheme torte

" status line
" set statusline=%<%f¥ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v¥ %l/%L
:set statusline=%f%m%=%3l,%3c

