" Joveler's vimrc
"
" Authors:
"   Hajin Jang
"

" =========================================================
" [VIM] Init
" =========================================================
set nocompatible

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
" [Plugin] Plug (BEGIN)
" =========================================================
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" [*] Register plugins
" Awesome status bar
Plug 'itchyny/lightline.vim'
" Theme (custom peaksea & wombat)
Plug '~/.joveler/vim/colorschemes'
" Secure Modeline
Plug 'ciaranm/securemodelines'
" vim-ployglot
Plug 'sheerun/vim-polyglot'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Autodetect tab & space
Plug 'tpope/vim-sleuth'
" Enhanced C++ Highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

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
" Show current buffer settings
let g:lightline.tabline = {
    \ 'left': [ ['tabs'] ],
    \ 'right': [ ['close'] ],
    \ }

" =========================================================
" [Plugin] securemodelines
" =========================================================
" Disable built-in modeline
set nomodeline
" Use secure version instead!
let g:secure_modelines_verbose = 0
let g:secure_modelines_modelines = 5

" =========================================================
" [Plugin] vim-markdown
" =========================================================
" Disable default markdown folding
let g:vim_markdown_folding_disabled = 1

" =========================================================
" [Plugin] vim-ployglot
" =========================================================
" graphql causes problem when loading json files
let g:polyglot_disabled = ['graphql', 'log', 'csv']

" =========================================================
" [Plugin] vim-cpp-enhanced-highlight
" =========================================================
" Enable optional features
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1

" =========================================================
" [Plugin] Custom Plugin Settings
" =========================================================
call SourceIfExists("~/.joveler/vim/custom_plugin.vim")

" =========================================================
" [Plugin] Plug (END)
" =========================================================
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" =========================================================
" [ColorScheme] 
" =========================================================
set background=dark
silent! colorscheme wombat

" =========================================================
" [VIM] General
" =========================================================
" [*] Print line numbers
set number
"set relativenumber
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>
noremap <F4> :set relativenumber!<CR>
inoremap <F4> <C-O>:set relativenumber!<CR>

" [*] Toggle paste mode with F2
set pastetoggle=<F2>

" [*] Syntax Highlighting
syntax on

" [*] Autoread
set autoread

" [*] Case insensitive search
" To force case sensitivity on search command,
" append '\C' for case-sensitive or '\c' for case-insensitive.
set ignorecase
set smartcase

" [*] Mouse support
set mousemodel=extend
set mouse=a

" [*] Cursorline
set cursorline

" [*] Indentation
" Use 4 space for \t
set tabstop=4
" < or > key indents 4 space
set shiftwidth=4
" Insert 4 space for tab key
set expandtab
" For files written by others
set smarttab
set autoindent
set smartindent

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

" [*] Use Home key like ^ (or 0w)
noremap <Home> ^
inoremap <Home> <Esc>^i

" =========================================================
" [VIM] Custom Settings
" =========================================================
" [*] Source custom settings
call SourceIfExists("~/.joveler/vim/custom_rc.vim")

