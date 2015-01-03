" oh-my-vim .vimrc 私人订制
"
" Date   : 2014-07-09
" Author : Fechin
" E-mail : lihuoqingfly@163.com
" URL    : https://github.com/Fechin/oh-my-vim.git
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

"--> 系统检测
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:osName = ""
let g:osDictionary = {"Linux":"linux","Darwin":"mac"}
if has("unix")
    let s:uname = system("echo -n $(uname)")
    let g:osName = !v:shell_error ? g:osDictionary[s:uname] : ""
endif

"--> 基本设置
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
syntax enable                   " 打开语法高亮
syntax on                       " 允许按指定主题进行语法高亮，而非默认高亮主题
filetype plugin indent on       " 不同文件类型加载对应的插件,使用对应的缩进
set nocompatible                " 关闭Vi兼容模式
set autoindent                  " 自动对齐
set tabstop=4                   " 设置Tab为4个空格
set shiftwidth=4                " 自动缩减空格长度
set smartindent                 " 智能自动缩进
set smarttab                    " 智能Tab
set mousemodel=popup            " 允许鼠标右键
set ruler                       " 右下角显示光标位置的状态行
set incsearch                   " 开启实时搜索功能
set hlsearch                    " 开启高亮显示结果
set ignorecase                  " 搜索忽略大小写
set shortmess=atI               " 不显示乌干达儿童捐助提示
set nowrapscan                  " 搜索到文件两端时不重新搜索
set hidden                      " 有未保存的更改时可以切换缓冲区
set laststatus=2                " 开启状态栏信息
set cmdheight=1                 " 命令行栏的高度
set nobackup                    " 不生成备份文件
set noswapfile                  " 不生成交换文件
set expandtab                   " 将Tab转换成空格[需输入真正的tab时，使用Ctrl+V, Tab]
set showmatch                   " 显示括号配对情况
set showcmd                     " 显示命令
set noerrorbells                " 关闭提示音
set wildmenu                    " 在状态栏显示匹配命令
set iskeyword+=_,$,@,%,#,-      " 关键字不换行
let g:rehash256 = 1             " 配色高亮
set t_Co=256                    " 开启终端256色
colorscheme molokai             " 指定配色方案

" 设置文件编码和文件格式
set encoding      =utf-8
set termencoding  =utf-8
set fileencoding  =utf-8
set fileencodings =ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 全局忽略文件
set wildignore+=*.png,*.jpg,*.bmp,*.gif  " Binary images  
set wildignore+=*.pyc                    " Python byte code  
set wildignore+=*.sw?                    " Vim swap files
set wildignore+=*.git,*.svn              " Version control tool
set wildignore+=*.DS_Store               " OSX bullshit
set wildignore+=*.tar.gz,*.zip,*.rar     " Compressed file

" 全局忽略目录
set wildignore+=classes
set wildignore+=lib

"--> AirLine
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:airline_theme                          = "badwolf"
let g:airline_powerline_fonts                = 1
let g:Powerline_symbols                      = "fancy"
let g:airline#extensions#whitespace#enabled  = 0
let g:airline#extensions#tabline#enabled     = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline_section_b                      = "NEVER STOP THE BEAT"

"--> YouCompleteMe
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:ycm_confirm_extra_conf              = 0 " 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_cache_omnifunc                  = 0 " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax    = 1 " 开启语义补全
let g:ycm_complete_in_comments            = 1 " 在注释中也可以补全
let g:ycm_min_num_of_chars_for_completion = 1 " 输入第一个字符就开始补全

"--> UltiSnips模板生成
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction
autocmd BufNewFile,BufRead *.snippets setf snippets
" 自动调用 UltiSnipsAddFileTypes filetype
autocmd FileType * call UltiSnips#FileTypeChanged()
autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"--> 自动执行
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
augroup defaults
    " Clear augroup
    autocmd!
	" 离开插入模式后自动关闭预览窗口
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    " 浅色高亮当前行
    autocmd InsertEnter * se cul
    autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown
    " 打开文件时，自动跳转到光标最后所在的位置
    if has("autocmd")
      autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    endif
augroup END

"--> 语法检查
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_enable_signs             = 1
let g:syntastic_javascript_checkers      = ["jshint"]
let g:syntastic_python_checkers          = ["pyflakes"]
let g:syntastic_html_checkers            = ["jshint"]
let g:syntastic_error_symbol             = "✗"
let g:syntastic_warning_symbol           = "⚠"

"--> Tcomment
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"--> vim-template
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:username     = "Fechin"
let g:email        = "lihuoqingfly@163.com"

"--> NERDTree
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let NERDTreeAutoCenter        = 1  " 窗口居中
let NERDTreeShowBookmarks     = 1  " 显示书签
let NERDChristmasTree         = 1  " 让树更好看
let NERDTreeMinimalUI         = 1  " 不显示帮助面板
let NERDTreeCaseSensitiveSort = 1  " 让文件排列更有序
let NERDTreeChDirMode         = 1  " 改变tree目录的同时改变工程的目录
let NERDTreeHijackNetrw       = 1  " 当输入 [:e filename]不再显示netrw,而是显示nerdtree
let NERDTreeBookmarksFile     = $VIM."\Data\NerdBookmarks.txt"

if exists("loaded_nerd_tree")
    autocmd VimEnter * NERDTree
endif
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"--> 按键映射
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:mapleader = ","
map <C-n> :tabnew<CR>       " 新tab
map <C-j> <C-W>j            " 窗口切换下
map <C-k> <C-W>k            " 窗口切换下
map <C-h> <C-W>h            " 窗口切换左
map <C-l> <C-W>l            " 窗口切换右

map <silent>        tn :tabnext<CR>
map <silent>        tp :tabprevious<CR>

map <F5> :call CompileAndRun()<CR>
set pastetoggle=<F6>         " 切换粘贴模式
nnoremap <F7> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F8> :NERDTreeToggle<CR>

nmap <leader>w :w!<cr>
imap <leader>w <esc>:w!<cr>
inoremap <leader><TAB> <C-x><C-o>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>   " 按,jd 会跳转到定义


nnoremap <space> za 
vnoremap <space> zf

"--> 按F5编译运行
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
function! CompileAndRun()
    exec "w"
    if     &filetype == "java" 
        exec "!javac %:t && java %:r"
    elseif &filetype == "c"
        exec "!gcc -Wall -std=c11 -o %:r %:t && ./%:r"
    elseif &filetype == "cpp"
        exec "!g++ -Wall -std=c++11 -o %:r %:t && ./%:r"
    elseif &filetype == "go"
        exec "!go build %:t && ./%:r"
    elseif &filetype == "sh"
        exec "!bash %:t"
    elseif &filetype == "lua"
        exec "!lua %:t"
    elseif &filetype == "perl"
        exec "!perl %:t"
    elseif &filetype == "php"
        exec "!php %:t"
    elseif &filetype == "python"
        exec "!python %:t"
    elseif &filetype == "ruby"
        exec "!ruby %:t"
    elseif &filetype == "html"
        if g:osName == "linux"
            exec "!gnome-open %  > /dev/null 2>&1"
        elseif g:osName == "mac"
            exec "!open % > /dev/null 2>&1&"
        endif
        call feedkeys("\<CR>")
    elseif &filetype == "markdown"
        if g:osName == "linux"
            exec "!markdown % > %.html && gnome-open %.html  > /dev/null 2>&1"
        elseif g:osName == "mac"
            exec "!markdown % > %.html && open %.html  > /dev/null 2>&1"
        endif
        call feedkeys("\<CR>")
    endif
endfunction

"--> 图形界面配置
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
if has("gui_running")
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条

    if has("gui_macvim")
        set imdisable " Set input method off
        set autochdir " 自动切换到文件当前目录
    endif
else
    set ambiwidth=single
endif

" 字体设置
if exists("&guifont")
    if g:osName == "linux"
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12
    elseif g:osName == "mac" 
        set guifont=Source_Code_Pro_for_Powerline:h14
    end
endif

"--> Vundle 插件管理
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
call plug#begin('~/.vim/plugged')

" 状态栏 
Plug 'bling/vim-airline'
" 文件目录树
Plug 'vim-scripts/The-NERD-tree'
" HTML/CSS代码快速生成
Plug 'mattn/emmet-vim'
" 搜索文件
Plug 'kien/ctrlp.vim'
" 新建文件自动加载模板
Plug 'aperezdc/vim-template'
" 文本更衣
Plug 'tpope/vim-surround'
" 括号自动补全
Plug 'vim-scripts/Auto-Pairs'
" 语法检查
Plug 'scrooloose/syntastic'
" 代码补全
Plug 'Valloric/YouCompleteMe'
" 模板生成补全
Plug 'SirVer/ultisnips'
" snippets
Plug 'honza/vim-snippets'
" 平滑滚动
Plug 'joeytwiddle/sexy_scroller.vim'
" 缩进对齐线
Plug 'Yggdroot/indentLine'
" 文本智能对齐
Plug 'junegunn/vim-easy-align'
" 代码注释
Plug 'tomtom/tcomment_vim'

call plug#end()
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
