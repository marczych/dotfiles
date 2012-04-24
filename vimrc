
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc -- the way it ought to be: Ha. It rhymes!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

set ai " Auto indent
set si " smart indenting

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
set number

" Settings for autoindentation, comments, and what-have-you

set expandtab          " expand tabs with spaces
set tabstop=3          " <Tab> move three characters
set shiftwidth=3       " >> and << shift 3 spaces
"set textwidth=79       " hard wrap at 79 characters
set modeline           " check for a modeline
set softtabstop=3      " see spaces as tabs
set scrolloff=5        " start scrolling when cursor is N lines from edge

" whoa... wtf?
set nowrap             " don't soft wrap
set wrap               " linewrap

" turns status line always on and configures it
set laststatus=2
set statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L

" sets path to Code dir
set path=~/Code/**

imap jj <Esc>
inoremap {<CR> {<CR>}<Esc>O
inoremap ({<CR> ({<CR>});<Esc>O
inoremap <<<<CR> <<<EOT<CR>EOT;<Esc>O<C-TAB><C-TAB><C-TAB>
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>
set cpoptions+=$ "show dollar sign at end of text to be changed

"Highlights lines that are greater than 80 columns
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength '\%80v.\+'
"set colorcolumn=80

let g:EasyMotion_leader_key = ',m'
let $VIM = "~/.vim"

" Look at your diff
function! SvnDiff()
   let text = system("svn di")
   let tempName = tempname()

   exec "redir! > " . tempName
   silent echon text
   redir END
   execute "vs " . tempName
   redraw!
endfunction
command! SD :call SvnDiff()


" Call 'svn blame' on the current file and grab the output for the current line
" plus the surrounding context. Display the result via echo and redraw the
" screen after input.
function! SvnBlame(linesOfContext)
   let pos = line(".")
   let text = system("svn blame " . expand("%:p"))
   let tempName = tempname()

   exec "redir! > " . tempName
   silent echon text
   redir END
   execute "botr " . (a:linesOfContext * 2 + 1) . "split " . tempName
   exec pos
   norm zz
   redraw!
endfunction
command! SB :call SvnBlame(6)

:source ~/.vim/matchit/plugin/matchit.vim
:source ~/.vim/easymotion/plugin/EasyMotion.vim
:source ~/.vim/NERD_tree/plugin/NERD_tree.vim

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

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"
