" Joveler's vimrc
"
" Authors:
"   Hajin Jang
"

" =========================================================
" [VIM] Helper Functions
" =========================================================
" [*] Source external vimrc if exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

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

" [*] Register plugins
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Awesome status bar
Plugin 'itchyny/lightline.vim'
" Theme
Plugin 'peaksea'
" Secure Modeline
Plugin 'ciaranm/securemodelines'
" vim-ployglot
Plugin 'sheerun/vim-polyglot'
" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" [*] Source custom plugins
call SourceIfExists("~/.joveler/vim/custom_plugin.vim")

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
" [ColorScheme] 
" =========================================================
set background=dark
colorscheme peaksea

" =========================================================
" [Plugin] lightline
" =========================================================
" Enable lightline status bar
set laststatus=2
" Use wombat theme
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
" Hide vim's default --INSERT--
set noshowmode

" =========================================================
" [Plugin] securemodelines
" =========================================================
" Disable built-in modeline
set nomodeline
" Use secure version instead!
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 5

" =========================================================
" [VIM] General
" =========================================================
" [*] Print line numbers
set number
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" [*] Toggle paste mode with F2
set pastetoggle=<F2>

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

" [*] Tags
set tags=tags
set tags+=/usr/include/**/tags

" [*] Wildcard
" Ignore compiled files on wildcard (from amix vimrc)
set wildignore=*.o,*~,*.pyc,*.obj,*.dll,*.pdb
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*,*\.DS_Store
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" [*] Persistent Undo
try
    set undodir=~/.joveler/vim/undodir
    set undofile
catch
endtry

" =========================================================
" [VIM] Custom Settings
" =========================================================
" [*] Source custom settings
call SourceIfExists("~/.joveler/vim/custom_rc.vim")

