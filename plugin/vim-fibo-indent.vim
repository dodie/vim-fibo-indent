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
    if !exists("g:FiboMaxDepth")
        let g:FiboMaxDepth = 15
    endif

    let s:fiboIndent = []

    let s:f1 = 0
    let s:f2 = 1
    let s:total= 0

    let s:i = 0
    while s:i < g:FiboMaxDepth
        let s:i += 1
        let s:fiboIndent = add(s:fiboIndent, [s:f1, s:total])
        let s:total += s:f1

        let s:temp = s:f1
        let s:f1 = s:f2
        let s:f2 += s:temp
    endwhile

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
