"""""""""""""""""""""""""""""""""""""
"--> Vundle 插件管理
"""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle.git'
Plugin 'Lokaltog/vim-powerline.git'
Plugin 'vim-scripts/The-NERD-tree.git'
Plugin 'mattn/emmet-vim.git'

filetype plugin indent on



"""""""""""""""""""""""""""""""""""""
"--> 基本设置
"""""""""""""""""""""""""""""""""""""
"syntax on
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
set magic

autocmd InsertEnter * se cul
let g:rehash256 = 1
colorscheme molokai
set guifont=Droid\ Sans\ Mono\ 11

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
let g:Powerline_symbols = 'unicode'
set encoding=utf8


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
func SetTitle() 
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
        exec "!firefox % &"
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



""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""
"--> 图形界面配置
"""""""""""""""""""""""""""""""""""""
if has('gui_running')
	set guioptions-=T " 隐藏工具栏
	set guioptions-=m " 隐藏菜单栏
	set guioptions-=L " 隐藏左侧滚动条
	set showtabline=2 " 显示Tab栏
	set guioptions+=r	"显示gui右边滚动条
	
	if has("gui_macvim")
		set imdisable	"Set input method off
		set autochdir	"自动切换到文件当前目录

	endif
else
	set ambiwidth=single
	syntax enable
endif
