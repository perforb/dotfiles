scriptencoding utf-8

"
" dein settings

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('arcticicestudio/nord-vim')
  call dein#add('nanotech/jellybeans.vim')

  call dein#end()
  call dein#save_state()
endif

"
" common settings

filetype plugin indent on
syntax enable
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
set belloff=all

set t_Co=256
colorscheme jellybeans

set cursorline
hi CursorLineNr term=bold cterm=none ctermfg=226 ctermbg=none

