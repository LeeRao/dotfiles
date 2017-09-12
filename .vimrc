execute pathogen#infect()

" Taken largely from https://dougblack.io/words/a-good-vimrc.html
syntax on
filetype plugin indent on
syntax enable
set background=dark
" colorscheme molokai
colorscheme industry
set tabstop=4
set softtabstop=4
set expandtab
set number
set showcmd
filetype indent on
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set shiftwidth=4

nnoremap <leader><space> :nohlsearch<CR>

nnoremap j gj
nnoremap k gk

nnoremap B ^
nnoremap E $

nnoremap ^ <nop>
nnoremap $ <nop>

imap jk <Esc>
set term=screen-256color

" Now from http://www.integralist.co.uk/posts/bash-vim-configuration.html
set history=100
set encoding=utf-8
set clipboard+=unnamed

" Now for my own additions
set mouse=a " mouse enabled in all modes

" easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" more natural split opening
set splitbelow
set splitright

" highlight column 100
highlight ColorColumn ctermbg=gray
set colorcolumn=100

" autocreate braces
" inoremap {<CR> {<CR>}<Esc>ko
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
