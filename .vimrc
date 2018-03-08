scriptencoding utf-8

"
" Neobundle Settings

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Write the Vim plugins, here
NeoBundle 'nanotech/jellybeans.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"
" Common Settings

syntax on

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,iso-2022-jp-2,euc-jp,sjis

set clipboard+=unnamed
set autoread
set hidden
set noswapfile
set nobackup
autocmd BufWritePre * :%s/\s\+$//ge

set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
set mouse=
set nohlsearch
set laststatus=2
set statusline=%F%r%h%=
set number
set incsearch
set ignorecase
set wildmenu wildmode=list:full
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

set noerrorbells
set visualbell

set t_Co=256
colorscheme jellybeans

set cursorline
hi CursorLineNr term=bold cterm=none ctermfg=226 ctermbg=none
