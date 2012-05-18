call pathogen#infect()
call pathogen#helptags()

" Set to your current project's root directory
set path=PATH/**

colorscheme slate
set encoding=utf-8
behave xterm
set nocompatible       " no compatibility with vi
filetype on            " recognize syntax by file extension
filetype plugin on     " Look at .vim/ftplugin
filetype indent on     " check for indent file
syntax on              " syntax highlighting

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set backspace=2        " allow <BS> to go past last insert
set gdefault           " assume :s uses /g
set ignorecase         " ignore case in search patterns
set smartcase          " searches are case-sensitive if caps used
set incsearch          " immediately highlight search matches
set noerrorbells       " no beeps on errors
set nomodeline         " prevent others from overriding this .vimrc
set ruler              " display row, column and % of document
set showcmd            " show partial commands in the status line
set showmatch          " show matching () {} etc.
set showmode           " show current mode

" Settings for autoindentation, comments, and what-have-you
set ai " Auto indent
set si " smart indenting
set expandtab          " expand tabs with spaces
set tabstop=3          " <Tab> move three characters
set shiftwidth=3       " >> and << shift 3 spaces
set modeline           " check for a modeline
set softtabstop=3      " see spaces as tabs
set scrolloff=5        " start scrolling when cursor is N lines from edge
set number             " show line numbers
set wrap               " linewrap

" turns status line always on and configures it
set laststatus=2
set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L

" turn off gui stuff
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=b
set mouse-=a "disable mouse click

" don't complete .class files
set wildignore=*.class

" Various remaps
imap kj <Esc>
inoremap {<CR> {<CR>}<Esc>O
inoremap ({<CR> ({<CR>});<Esc>O
inoremap <<<<CR> <<<EOT<CR>EOT;<Esc>O<C-TAB><C-TAB><C-TAB>
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>
set cpoptions+=$ "show dollar sign at end of text to be changed

" eclim stuff
command! JIM JavaImportMissing
command! JC JavaCorrect
command! PP ProjectProblems

function! JOI()
   JavaImportMissing
   JavaImportClean
endfunction
command! JOI :call JOI()

let g:EasyMotion_leader_key = ',m'
let $VIM = "~/.vim"

" highlight trailing whitespace
highlight WhitespaceEOL ctermbg=Red guibg=Red
match WhitespaceEOL /\s\+$/

" colorcolumn
if exists('+colorcolumn')
   set cc=80
   hi ColorColumn ctermbg=red guibg=red
else
   au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
" function! Tab_Or_Complete()
"   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"     return "\<C-N>"
"   else
"     return "\<Tab>"
"   endif
" endfunction
" inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
" set dictionary="/usr/dict/words"
