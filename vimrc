call pathogen#infect()
call pathogen#helptags()

" Set to your current project's root directory
set path=PATH/**

set encoding=utf-8
behave xterm
set nocompatible       " no compatibility with vi
filetype on            " recognize syntax by file extension
filetype plugin on     " Look at .vim/ftplugin
filetype indent on     " check for indent file
syntax enable          " syntax highlighting
set t_Co=16
colorscheme solarized
set background=dark

set hlsearch

" Open file for class name under cursor
nnoremap <C-i> yiw:find <C-R>".php<CR>

nnoremap <silent> <C-o> :call FindFile()<CR>

function! FindFile()
   " Get the word under cursor.
   let cursorWord = expand("<cword>")
   " Get the current file name and keep only the extension.
   let currentFile = expand("%")
   let extPos = stridx(currentFile, ".")

   " Append an extension only if the current file has an extension.
   if extPos != -1
      let extension = strpart(currentFile, extPos)
   else
      let extension = ""
   endif

   " Construct the file name.
   let fileName = cursorWord.extension

   " Open the file in the current buffer.
   call lose#lose(fileName)
endfunc

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
