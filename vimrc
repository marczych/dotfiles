call pathogen#infect()
call pathogen#helptags()

" Enable syntastic by default but disable it for java because it is really
" slow and doesn't find imports.
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['java'] }

let mapleader = " "
" Set to current directory.
set path=./**

set encoding=utf-8
behave xterm
set nocompatible       " no compatibility with vi
filetype on            " recognize syntax by file extension
filetype plugin on     " Look at .vim/ftplugin
filetype indent on     " check for indent file
syntax enable          " syntax highlighting
set t_Co=256
colorscheme solarized
set background=dark

set keywordprg=pman

set hlsearch

command! EA :checktime " Reopen all changed files with EA.
set autoread           " Automatically load changed files.

" Open file for class name under cursor
nnoremap <C-i> yiw:find <C-R>".php<CR>

nmap <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <C-o> :call FindFile()<CR>

function! FindFile()
   " Get the word under cursor.
   let cursorWord = expand("<cword>")
   " Get the current file name and keep only the extension.
   let currentFile = expand("%")
   let extPos = strridx(currentFile, ".")

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

" Live dangerously
set nobackup
set nowritebackup
set noswapfile

set backspace=2        " allow <BS> to go past last insert
set gdefault           " assume :s uses /g
set ignorecase         " ignore case in search patterns
set smartcase          " searches are case-sensitive if caps used
set incsearch          " immediately highlight search matches
set noerrorbells       " no beeps on errors
set nomodeline         " prevent others from overriding this .vimrc
set ruler              " display row, column and % of document
set showmatch          " show matching () {} etc.
set noshowmode         " don't show the current mode

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
set wildignore=*.class,*.sw?

" Various remaps
imap kj <Esc>
inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>];<Esc><<O
inoremap ({<CR> ({<CR>});<Esc>O
inoremap <<<<CR> <<<EOT<CR>EOT;<Esc>O<C-TAB><C-TAB><C-TAB>
nmap <Leader>p :set invpaste<CR>:set paste?<CR>
nmap <Leader>t :tabe %<CR>
set cpoptions+=$ "show dollar sign at end of text to be changed

let $VIM = "~/.vim"

" colorcolumn
if exists('+colorcolumn')
   set cc=80
   hi ColorColumn ctermbg=red guibg=red
else
   au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Display some whitespace characters.
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list

au BufNewFile,BufRead *.gradle setf groovy

" Set up dictionary completion.
set dictionary+=~/.vim/dictionary/english-freq
set complete+=k

" Don't scan included files, it's slow!!!!
set complete-=i

" d and u make the window vertically smaller and bigger, respectively.
nmap <Leader>d 1000<C-W>-
nmap <Leader>u 20<C-W>+

" Don't automatically resize windows when splitting.
set noequalalways
