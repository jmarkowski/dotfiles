"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set expandtab           " Convert tabs to spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set incsearch           " Search details
set hlsearch
set nowrapscan          " Do not wrap searching
set t_Co=256            " To aid the color scheme...
set number              " Show line numbers
set numberwidth=6
set tw=80               " Text wrapping at 80 columns
set smartindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldenable          " Enable folding
set foldcolumn=1        " Show fold columns
set foldmethod=syntax   " Set the fold syntax according to braces
let c_no_comment_fold=1 " Prevent folding of C comment blocks
set foldlevelstart=8    " Open a file with all folds open

" Set J,K for navigating between fold positions
map J zj
map K zk

" Set O,C for opening/closing folds.
"map O zO
"map C zC

" Toggle between fold methods (type \ff)
nmap <Leader>ff :call <SID>ToggleFold()<CR>
function! s:ToggleFold()
    if &foldmethod == 'manual'
        let &l:foldmethod = 'syntax'
    else
        let &l:foldmethod = 'manual'
    endif
    echo 'foldmethod is now ' . &l:foldmethod
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window splitting
nnoremap <C-v> :vsp<CR>
nnoremap <C-h> :sp<CR>

" <enter> scrolls to place cursor at top
nnoremap <CR> jz<CR>2<C-y>

" Get ctags for all dependent directories
nmap tt :!ctags

" Auto completion
"imap <tab> <C-p>

" Align text centered
map mid :center 80<CR>
"Insert comment lines and right justify text
map com I/* <ESC>A */<ESC>:ri<CR>

" Insert note and center justify text
nnoremap <C-n> I/** <ESC>A **/<ESC>:center<CR>
" Purge all inserted notes
nnoremap <C-p> :g/\/\*\* [\:A-Za-z0-9 \n\r\*\\\/]* \*\*\//d<CR><C-o>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UNDO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MOUSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow the mouse to be used for selecting
" :set mouse=""     Disable all mouse behaviour.
" :set mouse=a      Enable all mouse behaviour (the default).
" :set mouse+=v     Enable visual mode (v)
" :set mouse-=c     Disable mouse in command mode.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Folded       ctermbg=8   ctermfg=7
highlight FoldColumn   ctermbg=8   ctermfg=7
highlight Search       ctermfg=16  ctermbg=11
highlight VertSplit    ctermfg=8   ctermbg=0
highlight StatusLine   ctermfg=8   ctermbg=2
highlight StatusLineNC ctermfg=8   ctermbg=1
highlight LineNr       ctermfg=60


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.c syntax match pointer /\*[a-z,A-Z,0-9]*++/
autocmd BufRead,BufNewFile *.c highlight pointer term = NONE ctermfg=Yellow
autocmd BufRead,BufNewFile *.c syntax match annotate /\/\*\* [\:A-Za-z0-9 \n\r\*\\\/]* \*\*\//
autocmd BufRead,BufNewFile *.c highlight annotate term=NONE ctermfg=8 ctermbg=2 cterm=bold
autocmd BufRead,BufNewFile *.c highlight unimportant term=NONE ctermfg=15
autocmd BufRead,BufNewFile *.c syntax match this /this/
autocmd BufRead,BufNewFile *.c highlight this term=NONE ctermfg=3
autocmd BufRead,BufNewFile *.c syntax match Identifier /\w\+_t\ze\W/
autocmd BufRead,BufNewFile *.c,*.h syntax keyword cSpecial TRUE FALSE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
" autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
" autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
" autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
" autocmd BufRead,BufNewFile *.[ch] endif

" Remove trailing whitepsaces for each line on save.
" Highlight text that goes past the 80 line limit.
"augroup vimrc_autocmds
" autocmd BufReadPre * setlocal foldmethod=syntax
" autocmd BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
"  autocmd BufEnter * highlight OverLength ctermbg=12 guibg=#707070
"  autocmd BufEnter * match OverLength /\%81v.*/
"augroup END

if has("autocmd")
" autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
" autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
" autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
" autocmd BufRead,BufNewFile *.[ch] endif
" Remove trailing whitepsaces for each line on save.
  autocmd BufWritePre * :%s/\s\+$//e
endif

augroup cprog
  " Remove all cprog autocommands
  au!

  " For *.c and *.h files set formatting of comments and set C-indenting on.
  " For other files switch it off.
  " Don't change the order, it's important that the line with * comes first.
    autocmd BufRead,BufNewFile *       set formatoptions=tcql nocindent comments&
    autocmd BufRead,BufNewFile *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
    set cino=:0,(0,c1
  augroup END

  autocmd BufWritePre * :%s/\s\+$//e
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git Fugitive
"set statusline=%{fugitive#statusline()}

" Mark.vim
" Map these keys to search Marked items (from mark.vim plugin)
map <C-j> \*
map <C-k> \#
