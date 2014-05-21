"        _                    
" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
"

" No backward compatibility to vi
set nocompatible

"Pathogen
execute pathogen#infect()

"
" Indentation
"
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"
" Syntax
"
syntax on

"
" Filetype settings
"
filetype plugin on
filetype indent on

"
" Search
"
set incsearch
set hlsearch

"
" Statusline
"
set laststatus=2
set statusline=%<%f\ %(\ [%M%R%H%Y]%)%=%-14.(%l,%c%V%)\ %P

"
" Autoreload
"
autocmd! bufwritepost .vimrc source %

let g:syntastic_puppet_puppetlint_args = '--no-80chars-check'
