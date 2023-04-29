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
Plugin 'dense-analysis/ale'
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()           " required

" Plug plugins (https://github.com/junegunn/vim-plug)
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
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
let mapleader = ","     " Map <leader> to ','
set timeoutlen=200      " Timeout after <leader> is pressed to get next key.

syntax enable           " Enable syntax processing
set nowrapscan          " Do not wrap searching
set t_Co=256            " To aid the color scheme...
set number              " Show line numbers
set numberwidth=6
set textwidth=80        " Text wrapping at 80 columns
"set smartindent         " Indent to the tab position when you cross the 80 line
set wildmenu            " Visual autocomplete for command menu
set lazyredraw          " Redraw only when we need to
set showmatch           " Highlight matching [{()}]

" Look for tags in the directory of the current file, in the current directory
" and up until $HOME, stopping at the first hit of the tags file.
set tags=./tags,tags;$HOME

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP - full fuzzy file, buffer, mru, tag, ... finder for Vim
" Use by typing <C-p>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" Exclude files and directories using Vim's wildignore.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Custom file listing command
let g:ctrlp_user_command = 'find %s -type f'

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MACOSX Support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('macunix')
    " Fix backspace behaviour
    set backspace=indent,eol,start

    " Fix forward delete behaviour
    inoremap <C-d> <Del>

    " Allow the mouse scroll to be used in VIM
    set mouse=a
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCHING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In Normal Mode, cancel search highlighting by hitting backspace
nmap <silent> <BS> :nohlsearch<CR>
set incsearch           " Search details
set hlsearch            " Highlight matches

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OMNICOMPLETION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In insert mode, map ',,' to trigger omnicompletion.
inoremap <leader>, <C-x><C-o>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw - FILE EXPLORER
"   :Explore
"   :Sexplore (or just :Sex)
"   :Vexplore
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-b> :Vexplore<CR>
let g:netrw_banner = 0 "1=show banner
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4 "1=new hz split, 2=new vr split, 3=new tab, 4=prev window
let g:netrw_altv = 1
let g:netrw_winsize = 30 "percent of window
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

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

autocmd BufEnter *.ejs :setlocal filetype=html
autocmd BufEnter *.jsx :setlocal filetype=javascript
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BRACKET BEHAVIOUR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
" When you are opening a parenthesis and hit enter, close it and indent properly
autocmd FileType javascript inoremap <buffer> {<CR> {<CR>}<Esc>O
autocmd Filetype javascript setlocal cino+=(s,U1
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

" Get ctags for all dependent directories
nmap tt :!ctags

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
" ALE Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ALEErrorSign ctermbg=NONE ctermfg=red
let g:ale_sign_error = '●' "'✘'

highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_sign_warning = '●' "'⚠'

let g:ale_completion_enabled = 1

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_change = 'normal'

let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_javascript_eslint_use_global = 1

" Type ":ALEFix" to fix formatting issues
let b:ale_linters = ['eslint']
let b:ale_fixers = ['prettier', 'eslint']

" Type \af to fix all lines
nnoremap <leader>af :ALEFix<CR>

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
