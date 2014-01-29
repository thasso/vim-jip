" Copyright (c) 2014 Thasso Griebel
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" Load once stuff
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" enable syntax and load sh as default
syntax on
" store current setting if exists
if exists('b:current_syntax')
    let s:bcs = b:current_syntax
    unlet b:current_syntax
endif
" load sh as default and unset current syntax
runtime! syntax/sh.vim syntax/sh/*.vim
unlet b:current_syntax

syntax include @PYTHON syntax/python.vim syntax/python/*.vim
unlet b:current_syntax
syntax include @PERL syntax/perl.vim syntax/perl/*.vim
unlet b:current_syntax
syntax include @SHELL syntax/sh.vim syntax/sh/*.vim
unlet b:current_syntax
syntax include @R syntax/r.vim syntax/r/*.vim
unlet b:current_syntax
syntax include @OCAML syntax/ocaml.vim syntax/ocaml/*.vim
unlet b:current_syntax

" detect bash function call
syntax region JipBashBlock matchgroup=JipBashBlock start=/\v.*bash\(\s*\n*\s*'''/ end="'''" contained contains=@SHELL keepend
syntax region JipBashBlock matchgroup=JipBashBlock start=/\v.*bash\(\s*\n*\s*"""/ end=/"""/ contained contains=@SHELL keepend
" match general marker
syntax region JipBlock matchgroup=JipInvalid start="^#%begin.*$" end="^#%end.*$"
" match python groups
syntax region JipPipeline matchgroup=Jip start="^#%begin\s\+\(pipeline\|init\|setup\|validate\).*$" end="^#%end.*$" contains=@PYTHON,JipBashBlock keepend
" match perl command
syntax region JipCommandPerl matchgroup=Jip start="^#%begin\s\+command\s\+perl.*$" end="^#%end.*$" contains=@PERL
" match shell command
syntax region JipCommandShell matchgroup=Jip start="^#%begin\s\+command\s\+shell.*$" end="^#%end.*$" contains=@SHELL
syntax region JipCommandBash matchgroup=Jip start="^#%begin\s\+command\s\+bash.*$" end="^#%end.*$" contains=@SHELL
syntax region JipCommand matchgroup=Jip start="^#%begin\s\+command$" end="^#%end.*$" contains=@SHELL
" match python command
syntax region JipCommandPython matchgroup=Jip start="^#%begin\s\+command\s\+python.*$" end="^#%end.*$" contains=@PYTHON
" match Rscript command
syntax region JipCommandR matchgroup=Jip start="^#%begin\s\+command\s\+Rscript.*$" end="^#%end.*$" contains=@R
" match ocaml command
syntax region JipCommandOcaml matchgroup=Jip start="^#%begin\s\+command\s\+ocaml.*$" end="^#%end.*$" contains=@OCAML


" enbale group highlights
hi link Jip SpecialComment
hi link JipInvalid Error

" reset syntax
if exists('s:bcs')
    let b:current_syntax = s:bcs
endif

