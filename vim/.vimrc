syntax on

" Machine-local settings (not tracked)
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
