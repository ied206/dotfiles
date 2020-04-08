" Joveler's vimrc

" =========================================================
" [Plugin] Vundle
" =========================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Awesome status bar
Plugin 'vim-airline/vim-airline'
" Theme
Plugin 'tomasiser/vim-code-dark'
" Secure Modeline
Plugin 'ciaranm/securemodelines'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" =========================================================
" [Plugin] vim-airline
" =========================================================
let g:airline#extensions#tabline#enabled = 1

" =========================================================
" [Plugin] securemodelines
" =========================================================
" Disable built-in modeline
set nomodeline
" Use secure version instead!
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 5

" =========================================================
" [ColorScheme] codedark & airline
" =========================================================
colorscheme codedark
let g:airline_theme = 'codedark'

" =========================================================
" [VIM] General
" =========================================================
" [*] Print line numbers
set nu

" [*] Toggle paste mode with F2
set pastetoggle=<F2>

" [*] Enable filetype
filetype on
filetype plugin on
filetype indent on

" [*] Autoread
set autoread

" [*] Case insensitive search
set ignorecase
set smartcase

" [*] Mouse support
set mousemodel=extend
set mouse=a

" [*] Indentation
" Use 4 space for \t
set tabstop=4
" < or > key indents 4 space
set shiftwidth=4
" Insert 4 space for tab key
set expandtab
" For files written by others
set smarttab

" [*] Beep
set noerrorbells
set novisualbell
set t_vb=

" [*] Wildcard
" Ignore compiled files on wildcard (from amix vimrc)
set wildignore=*.o,*~,*.pyc,*.obj,*.dll,*.pdb
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*,*\.DS_Store
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


