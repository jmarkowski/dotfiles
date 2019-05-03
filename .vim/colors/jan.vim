" Vim color file
" Maintainer:	Jan Markowski <>
" Last Change:	2019-05-03

highlight Folded       ctermbg=8   ctermfg=7
highlight FoldColumn   ctermbg=8   ctermfg=7
highlight Search       ctermfg=16  ctermbg=11
highlight VertSplit    ctermfg=8   ctermbg=0
highlight StatusLine   ctermfg=8   ctermbg=2
highlight StatusLineNC ctermfg=8   ctermbg=1
highlight LineNr       ctermfg=60

if has("autocmd")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup highlighting
    " Clear autocmd's for the current highlighting group
    autocmd!
    autocmd BufRead,BufNewFile *.c syntax match pointer /\*[a-z,A-Z,0-9]*++/
    autocmd BufRead,BufNewFile *.c highlight pointer term = NONE ctermfg=Yellow
    autocmd BufRead,BufNewFile *.c syntax match annotate /\/\*\* [\:A-Za-z0-9 \n\r\*\\\/]* \*\*\//
    autocmd BufRead,BufNewFile *.c highlight annotate term=NONE ctermfg=8 ctermbg=2 cterm=bold
    autocmd BufRead,BufNewFile *.c highlight unimportant term=NONE ctermfg=15
    autocmd BufRead,BufNewFile *.c syntax match this /this/
    autocmd BufRead,BufNewFile *.c highlight this term=NONE ctermfg=3
    autocmd BufRead,BufNewFile *.c syntax match Identifier /\w\+_t\ze\W/
    autocmd BufRead,BufNewFile *.c,*.h syntax keyword cSpecial TRUE FALSE
augroup END
endif
