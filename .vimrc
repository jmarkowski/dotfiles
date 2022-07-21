"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle : Vim Plugin Manager
"
" git@github.com:VundleVim/Vundle.vim.git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            " be iMproved, required
filetype off                " required

" Set the runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim

" Initialize vundle and specify the path where Vundle should install plugins
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are various plugins. They must be included between
" vundle#begin/end
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'alvan/vim-closetag'
Plugin 'justinmk/vim-sneak'
Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'

call vundle#end()           " required

" Plug plugins (https://github.com/junegunn/vim-plug)
call plug#begin()
call plug#end()

filetype plugin indent on   " required (file type detection)

" Installation of Plugins:
"   Launch `vim` and run `:PluginInstall`
"   or from the CLI: `vim +PluginInstall +qall`
"
" Documentation:
"   `:h vundle`


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN MAPPING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mark.vim
" Map these keys to search Marked items (from mark.vim plugin)
map <C-j> ,*
map <C-k> ,#

" See all buffers when there's only one tab open
"let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let mapleader = ","     " Map <leader> to ','
syntax enable           " Enable syntax processing
set nowrapscan          " Do not wrap searching
set t_Co=256            " To aid the color scheme...
set number              " Show line numbers
set numberwidth=6
set textwidth=80        " Text wrapping at 80 columns
set smartindent         " Indent to the tab position when you cross the 80 line
set wildmenu            " Visual autocomplete for command menu
set lazyredraw          " Redraw only when we need to
set showmatch           " Highlight matching [{()}]

" Look for tags in the directory of the current file, in the current directory
" and up until $HOME, stopping at the first hit of the tags file.
set tags=./tags,tags;$HOME


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off search highlight by typing `, `
noremap <leader><space> :nohlsearch<CR>
set incsearch           " Search details
set hlsearch            " Highlight matches


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TABS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4        " Number of spaces in manual indent (>>, <<).
set softtabstop=4       " Number of spaces in tab when editing
set tabstop=4           " Number of visual spaces in a tab.
set expandtab           " Convert tabs to spaces

if has("autocmd")
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType sh setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2
endif

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
if has("persistent_undo")
set undodir=$HOME/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000
endif


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
" Options: soft, medium, hard
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox
set background=dark

"colorscheme jan

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOGROUPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")

" Remove trailing whitespaces when saving
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

augroup cprog
    " Clear autocmd's fro the current cprog group
    autocmd!
    " For *.c and *.h files set formatting of comments and set C-indenting on.
    " For other files switch it off.
    " Don't change the order, it's important that the line with * comes first.
    autocmd BufRead,BufNewFile *       set formatoptions=tcql nocindent comments&
    autocmd BufRead,BufNewFile *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
    set cino=:0,(0,c1
augroup END

endif
