" Vim plugin that increases the spacing for each successive indentation
" according to the Fibonacci sequence.
" Maintainer:           David Csakvari
" URL:                  https://github.com/dodie/vim-fibo-indent
" License:              MIT
" ----------------------------------------------------------------------------
scriptencoding utf-8

function! GetFiboIndent()
    set tabstop=1
    set shiftwidth=1
    set expandtab
    set softtabstop=1

    exe "let ind = ".s:origindentexpr

    if has_key(s:toFibo, ind)
      return s:toFibo[ind]
    endif

    if has_key(s:fromFibo, ind)
      return ind
    endif

    let closestIndent = [0, 0]
    for item in s:fiboIndent
      if item[0] < ind
        let closestIndent = item
      endif
    endfor

    return closestIndent[1] + (ind - closestIndent[0])
endfunction

" Plugin setup
if !exists('g:FiboIndentDisable')
    let s:fiboIndent = [[0, 0], [1, 1], [2, 2], [3, 4], [5, 7], [8, 12], [13, 20], [21, 33], [34, 54], [55, 88], [89, 143], [144, 232], [233, 376], [377, 609], [610, 975]]

    let s:toFibo = {}
    let s:fromFibo = {}
    for item in s:fiboIndent
        let s:toFibo[item[0]] = item[1]
        let s:fromFibo[item[1]] = item[0]
    endfor

    " Wrap original indent expr with fibo-indent
    function! s:InitFiboIndent()
        let s:origindentexpr = &indentexpr
        setlocal indentexpr=GetFiboIndent()
    endfunction
    autocmd FileType * call s:InitFiboIndent()
endif
