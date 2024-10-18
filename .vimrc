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
set shiftwidth=4
autocmd FileType r,rmd set tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile *.wdl setlocal tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile Jenkinsfile,*.nf set syntax=groovy
autocmd BufNewFile,BufRead Snakefile,*.snake,*.smk set syntax=snakemake

set expandtab
autocmd BufRead,BufNewFile *.tsv,*.txt setlocal noexpandtab

set number
set showcmd
filetype indent on
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch

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
set clipboard=unnamedplus

"""""""""""""""
" Added by me "
"""""""""""""""

" better indent behavior
set autoindent

" Code folds
set foldmethod=indent
set nofoldenable
nnoremap <space> za
vnoremap <space> zf

" linting
let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'
let g:ale_python_flake8_options = '--max-line-length=100'
let g:ale_enabled = 1
map <F2> :ALEToggle<CR>

set mouse=a " mouse enabled in all modes

" easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" toggle for normal copy-paste behavior
set pastetoggle=<F3>

" more natural split opening
set splitbelow
set splitright

" search for visually selected text
vnoremap // y/<C-R>"<CR>

" highlight column
" 'highlight ColorColumn ctermbg=gray
" set colorcolumn=100
augroup columnLimit
    autocmd!
    autocmd BufEnter,WinEnter,FileType scala,java,python,c,*.cc,*.cpp,*.R
        \ highlight ColumnLimit ctermbg=DarkGrey guibg=DarkGrey
    let columnLimit = 99 " python recommends 79, 99 if want to be more lenient
    let pattern =
        \ '\%<' . (columnLimit+1) . 'v.\%>' . columnLimit . 'v'
    autocmd BufEnter,WinEnter,FileType scala,java,python,c,*.cc,*.cpp,*.R
        \ let w:m1=matchadd('ColumnLimit', pattern, -1)
augroup END

" autocreate braces, taken from http://vim.wikia.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier
" Also allows you to overlap closing character

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>

" sublime-like, ensures that typing over second of corresponding pair does nothing
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>

inoremap } <c-r>=ClosePair('}')<CR>
"autocmd FileType *.c, *.cpp, *.cc, *.R, *.Rmd, *.java inoremap } <c-r>=CloseBracket()<CR>

"inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>

" Change behavior of paste to no longer copy replaced text to buffer
" https://superuser.com/questions/321547/how-do-i-replace-paste-yanked-text-in-vim-without-yanking-the-deleted-lines
" NOTE: In VIM 9.0, this is no longer an issue, as P will produce the desired behavior.
" vnoremap p "0p
" vnoremap P "0P
" vnoremap y "0y
" vnoremap d "0d

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
highlight Pmenu ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
highlight PmenuSel ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple
