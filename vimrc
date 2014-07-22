set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


filetype plugin indent on

let s:running_windows = has("win16") || has("win32") || has("win64")
let s:running_macvim = has('gui_macvim')


"""""""""""""""""""""""""""""""""""""
"--> 基本设置
"""""""""""""""""""""""""""""""""""""
syntax on
set hlsearch
set incsearch
set sw=4
set ts=4
set et
set smarttab
set smartindent
set lbr
set fo+=mB
set sm
set selection=inclusive
set wildmenu
set mousemodel=popup
set shortmess=atI
set cul
set history=500
set showcmd
set magic
set backspace=indent,eol,start

autocmd InsertEnter * se cul
let g:rehash256 = 1
colorscheme molokai256

" 设置文件编码和文件格式
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"""""""""""""""""""""""""""""""""""""
"--> PowerLine
"""""""""""""""""""""""""""""""""""""
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'compatible'


"""""""""""""""""""""""""""""""""""""
"--> NERDTree
"""""""""""""""""""""""""""""""""""""
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
let NERDTreeShowBookmarks=1
let NERDChristmasTree=1 " 让树更好看,我是没看出来
let NERDTreeCaseSensitiveSort=1 " 让文件排列更有序
let NERDTreeChDirMode=1 " 改变tree目录的同时改变工程的目录
let NERDTreeHijackNetrw=1 " 当输入 [:e filename]不再显示netrw,而是显示nerdtree
nnoremap f :NERDTreeToggle


"""""""""""""""""""""""""""""""""""""
"--> 新文件头
"""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.sh,*.java,*.py exec ":call SetTitle()" 
func! SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
		call append(line(".")+1, "") 
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: Fechin") 
		call append(line(".")+2, "	> Mail: lihuoqingfly@163.com ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
endfunc 
autocmd BufNewFile * normal G



"""""""""""""""""""""""""""""""""""""
"--> 按键映射
"""""""""""""""""""""""""""""""""""""
map <C-w> <C-w>w

"列出当前目录文件  
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>


"""""""""""""""""""""""""""""""""""""
"--> 按按F5编译运
"""""""""""""""""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!google-chrome %.html &"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc



"""""""""""""""""""""""""""""""""""""
"--> 偏好设置
"""""""""""""""""""""""""""""""""""""
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 在处理未保存或只读文件的时候，弹出确认
set confirm
"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase"
" 高亮显示匹配的括号"
set showmatch

let NERDTreeIgnore=['\.pyc']
set matchpairs=(:),{:},[:],<:>

"""""""""""""""""""""""""""""""""""""
"--> 图形界面配置
"""""""""""""""""""""""""""""""""""""
if has('gui_running')
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=t " 隐藏菜单栏中的撕下此菜单
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
	
	if has("gui_macvim")
		set imdisable	"Set input method off
		set autochdir	"自动切换到文件当前目录

	endif
else
	set ambiwidth=single
endif



if exists("&guifont")
  if has("mac")
    set guifont=Monaco:h12
  elseif has("unix")
    if &guifont == ""
      set guifont=Droid\ Sans\ Mono\ 13
    endif
  elseif has("win32")
   set guifont=Consolas:h11,Courier\ New:h10
  endif
endif


augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END


"""""""""""""""""""""""""""""""""""""
"--> Vundle 标签样式
"""""""""""""""""""""""""""""""""""""
hi TabLineFill term=none
hi TabLineFill ctermfg=DarkGrey
hi TabLineFill guifg=#777777

hi TabLineSel term=inverse
hi TabLineSel cterm=none ctermfg=yellow ctermbg=Black
hi TabLineSel gui=none guifg=yellow guibg=Black

set tabline=%!MyTabLine()
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " 选择高亮
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " 设置标签页号 (用于鼠标点击)
    let s .= '%' . (i + 1) . 'T'
    " MyTabLabel() 提供完整路径标签 MyShortTabLabel 提供文件名标签
    let s .= ' %{MyShortTabLabel(' . (i + 1) . ')} '
  endfor
  " 最后一个标签页之后用 TabLineFill 填充并复位标签页号
  let s .= '%#TabLineFill#%T'
  " 右对齐用于关闭当前标签页的标签
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif
  return s
endfunction
" 文件名标签
function! MyShortTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let label = bufname (buflist[tabpagewinnr (a:n) -1])
  let filename = fnamemodify (label, ':t')
  return filename
endfunction
"完整路径标签
function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

"""""""""""""""""""""""""""""""""""""
"--> Vundle 插件管理
"""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/vundle'               " -- 插件管理工具
Plugin 'Lokaltog/vim-powerline'      " -- 状态栏 
Plugin 'vim-scripts/The-NERD-tree'   " -- 文件目录树
Plugin 'mattn/emmet-vim'             " -- HTML/CSS代码快速生成神器
Plugin 'kien/ctrlp.vim'              " -- 快速搜索文件
