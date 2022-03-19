set number relativenumber
set nocompatible
set smarttab
set cindent
set tabstop=2
set shiftwidth=2

" always uses spaces instead of tab characters
set expandtab

" search
set ignorecase
set smartcase
set scrolloff=3

set backspace=indent,eol,start

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop> 

set mouse+=a

let mapleader = " "

set wildmenu

set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
