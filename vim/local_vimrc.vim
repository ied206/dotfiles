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
function! SourceIfExistsRoot(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" =========================================================
" [VIM] Load Template Settings
" =========================================================
" [*] Source template settings
call SourceIfExistsRoot("~/.joveler/vim/vimrc.vim")
