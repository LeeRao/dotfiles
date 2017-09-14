"execute pathogen#infect()

" Taken largely from https://dougblack.io/words/a-good-vimrc.html
syntax on
filetype plugin indent on
syntax enable
set background=dark
" colorscheme molokai
" colorscheme industry
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

nnoremap gj j
nnoremap gk k

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

" highlight column 79
" 'highlight ColorColumn ctermbg=gray
" set colorcolumn=100
augroup columnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType scala,java,python,c,*.cc,*.cpp
        \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
    let columnLimit = 79 " feel free to customize
    let pattern =
        \ '\%<' . (columnLimit+1) . 'v.\%>' . columnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType scala,java,python,c,*.cc,*.cpp
        \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END

" autocreate braces, taken from http://vim.wikia.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier
" Also allows you to overlap closing character
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
"inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>

function! ConditionalPairMap(open, close)
    let line = getline('.')
    let col = col('.')
    if col < col('$') || stridx(line, a:close, col + 1) != -1
        return a:open
    else
        return a:open . a:close . repeat("\<left>", len(a:close))
    endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

