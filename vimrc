" Plugin config.
call pathogen#infect()
call pathogen#helptags()

" Don't show the branch name because it's super long.
let g:airline#extensions#branch#enabled = 0

" Set the leader to <Space>.
let mapleader = " "

" d and u make the window vertically smaller and bigger, respectively.
nmap <Leader>d 1000<C-W>-
nmap <Leader>u 20<C-W>+
" Toggle paste mode.
nmap <Leader>p :set invpaste<CR>:set paste?<CR>
" Open the current buffer in a new tab.
nmap <Leader>t :tabe %<CR>
nmap <C-n> :NERDTreeToggle<CR>
" Move to the next tab.
nmap <silent> <C-t> :tabn<CR>
" Move to the next error from ALE.
nmap <silent> <C-m> <Plug>(ale_next_wrap)

" Easier to get out of insert mode with 'kj'.
imap kj <Esc>
" Automatically insert the closing brace.
imap {<CR> {<CR>}<Esc>O

" General Vim settings.
set encoding=utf-8
behave xterm
" Don't try to preserve compatibility with vi.
set nocompatible

" Live dangerously (disable all back up files).
set nobackup
set nowritebackup
set noswapfile

" Reopen all changed files with :EA.
command! EA :checktime
" Automatically load changed files.
set autoread

" Enable automatic file type goodness.
filetype on
filetype plugin on
filetype indent on

" Highlight all search matches.
set hlsearch
" Immediately highlight search matches.
set incsearch
" Ignore case in search patterns by default.
set ignorecase
" Searches are case-sensitive if caps used.
set smartcase

" Show dollar sign at end of text to be changed.
set cpoptions+=$
" Allow backspacing without limits (in particular past the beginning of insert).
set backspace=2

" Enable syntax highlighting and all colors.
syntax enable
set t_Co=256
" Use the solarized light color scheme.
colorscheme solarized
set background=light
" Disable error bells.
set noerrorbells

" Always show the status line.
set laststatus=2
" Enable modeline.
set modeline
" Powerline already displays the mode.
set noshowmode

" Set to current directory.
set path=./**
" Don't complete these files.
set wildignore=*.class,*.sw?,*.pyc

" Enable sane indent settings. Note: These can get overridden by EditorConfig.
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Display some whitespace characters.
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list

" Highlight the current line.
set cursorline
" Don't always redraw (in macros, etc. in particular).
set lazyredraw
" Don't automatically resize windows when splitting.
set noequalalways
" Display row, column and % of document.
set ruler
" Keep 5 lines of context at the top and bottom of the cursor.
set scrolloff=5
" Display matching parens, brackets, etc.
set showmatch
" Show a better menu for autocompleting commands.
set wildmenu
" Soft wrap lines.
set wrap

" Display a line at 80 columns.
if exists('+colorcolumn')
   set colorcolumn=80
   highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
endif

" Basic auto completion settings.
set complete=.,w,b,u,t
set dictionary=/usr/share/dict/words

" Set filetypes for some patterns that it doesn't match by default.
autocmd BufNewFile,BufRead *.gradle setlocal filetype=groovy
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

" Enable dictionary completion and spell mode for prose files.
autocmd FileType markdown,gitcommit,text setlocal complete+=k spell
