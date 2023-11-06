" Plugin config.
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

call plug#end()

let NERDTreeShowHidden=1

" d and u make the window vertically smaller and bigger, respectively.
nmap <Leader>d 1000<C-W>-
nmap <Leader>u 20<C-W>+
" Toggle paste mode.
nmap <Leader>p :set invpaste<CR>:set paste?<CR>
" Open the current buffer in a new tab.
nmap <Leader>t :tabe %<CR>
" Start FZF with a Ctrl-F.
nmap <silent> <C-f> :FZF<CR>
" Open the current directory/folder in the current pane.
nmap <Leader>f :e %%/<CR>

" Easier to get out of insert mode with 'kj'.
imap kj <Esc>
" Automatically insert the closing brace.
imap {<CR> {<CR>}<Esc>O

" In command mode, make %% expand to the directory that the current file is
" in.
cabbr <expr> %% expand('%:p:h')

" General Vim settings.
set encoding=utf-8
behave xterm

" Live dangerously (disable all back up files).
set nobackup
set nowritebackup
set noswapfile

" Reopen all changed files with :EA.
command! EA :checktime
" Automatically load changed files.
set autoread

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

" Disable error bells.
set noerrorbells

" Always show the status line.
set laststatus=2
" Enable modeline.
set modeline
" Powerline already displays the mode.
set noshowmode

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
" Don't allow buffers to be hidden without prompting to save them.
set nohidden

" Display a line at 80 columns.
if exists('+colorcolumn')
   set colorcolumn=80
   highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
endif

" Basic auto completion settings.
set complete=.,w,b,u,t
set dictionary=/usr/share/dict/words

" Enable dictionary completion and spell mode for prose files.
autocmd FileType markdown,gitcommit,text setlocal complete+=k spell
