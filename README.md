vim-fibo-indent
===============

Vim plugin that increases the spacing for each successive indentation according
to the Fibonacci sequence.

![vim-fibo-indent](https://github.com/dodie/vim-fibo-indent/blob/master/tty.gif "vim-fibo-indent")

Great for mathematicians and for people who like to avoid deep indentations.
Supports 15 indentation levels, which should be more than enough even if you have
a really wide display (though it can be increased for the extra brave).


## Installation

You can easily install this Plugin with
[Pathogen](https://github.com/tpope/vim-pathogen) or
[Vundle](https://github.com/gmarik/vundle).


## Configuration

Add this line to your `.vimrc` to disable this plugin:

```
let g:FiboIndentDisable=1
```

If for some reason you need more than 15 levels of indentation its depth can be set with:

```
let g:FiboMaxDepth=20
```

To disable Fibonacci formatting for a given filetype, use the following:

```
autocmd FileType SOME_FILETYPE let g:gFiboIndentDisable=1
```


## Inspiration
The idea came from a [Tweet](https://twitter.com/RichardWestenra/status/765488378951376896)
made by [@RichardWestenra](https://twitter.com/RichardWestenra).


## How it works

This plugin wraps the original formatter defined for a filetype and modifies its indentation
levels to match the Fibbonacci sequence. It also sets `tabstop=1` to use a single space for
the basis of the indentation levels.

