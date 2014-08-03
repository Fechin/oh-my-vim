"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
" oh-my-vim .vimrc 私人订制
"
" Author : Fechin
" E-mail : lihuoqingfly@163.com
" URL    : https://github.com/Fechin/oh-my-vim.git
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


"--> 系统检测
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:osName = ''
let g:osDictionary = {'Linux':'linux','Darwin':'mac'}
if has('unix')
    let s:uname = system('echo -n $(uname)')
    let g:osName = !v:shell_error ? g:osDictionary[s:uname] : ''
endif


"--> 基本设置
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
syntax on                       " 打开语法高亮
filetype plugin indent on       " 启用自动补全
set nocompatible                " 关闭兼容模式
set backspace=2                 " 设置退格键可用
set autoindent                  " 自动对齐
set tabstop=4                   " 设置Tab为4个空格
set shiftwidth=4                " 自动缩减空格长度
set ai!                         " 设置自动缩进
set smartindent                 " 智能自动缩进
set smarttab                    " 智能Tab
set mousemodel=popup            " 允许鼠标右键
set ruler                       " 右下角显示光标位置的状态行
set incsearch                   " 开启实时搜索功能
set hlsearch                    " 开启高亮显示结果
set ignorecase                  " 搜索忽略大小写
set nowrapscan                  " 搜索到文件两端时不重新搜索
set hidden                      " 允许在有未保存的修改时切换缓冲区
set laststatus=2                " 开启状态栏信息
set cmdheight=1                 " 命令行的高度
set writebackup                 " 设置无备份文件
set nobackup                    " 不生成备份文件
set noswapfile                  " 不生成交换文件
set expandtab                   " 将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set showmatch                   " 显示括号配对情况
set showcmd                     " 显示命令
set noerrorbells                " 关闭提示音
set wildmenu                    " 在状态栏显示匹配命令
autocmd InsertEnter * se cul    " 浅色高亮当前行
let g:rehash256 = 1             " 配色高亮
colorscheme molokai             " 设置主题配色
set background=dark             " 试图使用深色背景上看起来舒服的颜色

" 设置文件编码和文件格式
set encoding      =utf-8
set termencoding  =utf-8
set fileencoding  =utf-8
set fileencodings =ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


"--> PowerLine
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
set t_Co=256
let g:Powerline_symbols = 'compatible'


"--> YouCompleteMe
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:ycm_global_ycm_extra_conf                    = '$VIM/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf                       = 0 " 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_collect_identifiers_from_tag_files       = 1 " 使用ctags生成的tags文件
let g:syntastic_always_populate_loc_list           = 1

"--> UltiSnips模板生成
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']

" 自动调用 UltiSnipsAddFileTypes filetype
if has("autocmd")
    autocmd FileType * call UltiSnips#FileTypeChanged()
    autocmd BufNewFile,BufRead *.snippets setf snippets
endif

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
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"--> 语法检查
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:syntastic_check_on_open          = 1
let g:syntastic_enable_signs           = 1
let g:syntastic_javascript_checkers    = ['jshint']
let g:syntastic_python_checkers        = ['pyflakes']
let g:syntastic_html_checkers          = ['jshint']
let g:syntastic_error_symbol           = "✗"
let g:syntastic_warning_symbol         = '!'


"--> NERDCommenter
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let NERDSpaceDelims = 1                " 自动添加前置空格
let g:mapleader     = ','              " NERD Commenter 按键


"--> TagList
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let Tlist_GainFocus_On_ToggleOpen = 1  " 自动获取焦点
let Tlist_Enable_Fold_Column      = 0  " 不显示左侧折叠树
let Tlist_Show_One_File           = 1  " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow         = 1  " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window        = 1  " 在右侧窗口中显示

" Ctags for Taglist
if g:osName == 'mac'
    let Tlist_Ctags_Cmd = '/usr/bin/.ctags'
endif

"--> vim-template
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let g:username                    = 'Fechin'
let g:email                       = 'lihuoqingfly@163.com'
let g:template_dir                = '~/.vim/templates'


"--> NERDTree
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
let NERDTreeAutoCenter            = 1  " 窗口居中 
let NERDTreeShowBookmarks         = 1  " 显示书签
let NERDChristmasTree             = 1  " 让树更好看
let NERDTreeMinimalUI             = 1  " 不显示帮助面板
let NERDTreeCaseSensitiveSort     = 1  " 让文件排列更有序
let NERDTreeChDirMode             = 1  " 改变tree目录的同时改变工程的目录
let NERDTreeHijackNetrw           = 1  " 当输入 [:e filename]不再显示netrw,而是显示nerdtree
let NERDTreeIgnore                = ['\.pyc','\.git','\.svn']
let NERDTreeBookmarksFile         = $VIM.'\Data\NerdBookmarks.txt'

" 当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType')
                \ && b:NERDTreeType == 'primary') | q | endif

"--> 按键映射
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
map <C-w> <C-w>w
map <C-l> :tabn<CR>               " 下一个tab
map <C-h> :tabp<CR>               " 上一个tab
map <C-n> :tabnew<CR>             " 新tab
map <C-k> :bn<CR>                 " 下一个文件
map <C-j> :bp<CR>                 " 上一个文件

nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> <F9> :TlistToggle<CR>
nnoremap <F7> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>   "按,jd 会跳转到定义


"--> 按按F5编译运
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
map <F5> :call CompileAndRun()<CR>
func! CompileAndRun()
    exec 'w'
    if     &filetype == 'java' 
        exec '!javac %:t && java %:r'
    elseif &filetype == 'c'
        exec '!gcc -Wall -std=c11 -o %:r %:t && ./%:r'
    elseif &filetype == 'cpp'
        exec '!g++ -Wall -std=c++11 -o %:r %:t && ./%:r'
    elseif &filetype == 'go'
        exec '!go build %:t && ./%:r'
    elseif &filetype == 'sh'
        exec '!bash %:t'
    elseif &filetype == 'lua'
        exec '!lua %:t'
    elseif &filetype == 'perl'
        exec '!perl %:t'
    elseif &filetype == 'php'
        exec '!php %:t'
    elseif &filetype == 'python'
        exec '!python %:t'
    elseif &filetype == 'ruby'
        exec '!ruby %:t'
    elseif &filetype == 'html'
        if g:osName == 'linux'
            exec '!gnome-open % &'
        elseif g:osName == 'mac'
            exec '!open % &'
        endif
        call feedkeys('\<CR>')
    elseif &filetype == 'mkd'
        exec '!~/.vim/markdown.pl % > %.html &'
        if g:osName == 'linux'
            exec '!gnome-open %.html &'
        elseif g:osName == 'mac'
            exec '!open %.html &'
        endif
        call feedkeys('\<CR>')
    endif
endfunc

"--> 图形界面配置
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
if has('gui_running')
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=t " 隐藏菜单栏中的撕下此菜单
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条

    if has('gui_macvim')
        set imdisable " Set input method off
        set autochdir " 自动切换到文件当前目录

    endif
else
    set ambiwidth=single
endif

if exists('&guifont')
    if g:osName == 'linux'
        set guifont =Droid\ Sans\ Mono\ 12
    elseif g:osName == 'mac' 
        set guifont =Monaco:h12
    end
endif

" VIMRC保存生效
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" 打开文件时，自动跳转到光标最后所在的位置
if has('autocmd')
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$')
    \| exe "normal! g'\"" | endif
endif

"--> 标签样式
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
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
        let s .= '%=%#TabLine#%999Xㄨ'
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

" 完整路径标签
function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

"--> Vundle 插件管理
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
Plugin 'gmarik/vundle'               " -- 插件管理工具
Plugin 'Lokaltog/vim-powerline'      " -- 状态栏 
Plugin 'vim-scripts/The-NERD-tree'   " -- 文件目录树
Plugin 'mattn/emmet-vim'             " -- HTML/CSS代码快速生成
Plugin 'kien/ctrlp.vim'              " -- 搜索文件
Plugin 'scrooloose/nerdcommenter'    " -- 代码注释
Plugin 'aperezdc/vim-template'       " -- 新建文件自动加载模板
Plugin 'tpope/vim-surround'          " -- 文本更衣
Plugin 'vim-scripts/taglist.vim'     " -- TagList
Plugin 'vim-scripts/Auto-Pairs'      " -- 括号自动补全
Plugin 'scrooloose/syntastic'        " -- 语法检查
Plugin 'Valloric/YouCompleteMe'      " -- 代码补全
Plugin 'SirVer/ultisnips'            " -- 模板生成补全
Plugin 'honza/vim-snippets'          " -- snippets
"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
