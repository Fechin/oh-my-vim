vim
===
vim 配置，私人订制，停止更新， 已转spaceVim

### 说明
兼容Linux、Mac

为了更好的支持airline状态栏插件，请安装字体 [powerline-fonts](https://github.com/Lokaltog/powerline-fonts)

### 安装

```
  git clone https://github.com/Fechin/oh-my-vim.git ~/.vim
```

```
  ./setup.sh
```
  可选参数：启动vim的命令，默认为“vim”,如./setup.sh gvim 或 ./setup.sh MacVim

#### 快捷键
```
nnoremap <leader>w :w!<CR>
inoremap <leader>w <esc>:w!<CR>
" ,W
nnoremap <leader>W :w !sudo tee > /dev/null %<CR>
inoremap <leader>W :w !sudo tee > /dev/null %<CR>
" ,r 运行
nnoremap <leader>r :call CompileAndRun()<CR>
inoremap <leader>r <esc>:call CompileAndRun()<CR>
" ,e 文件浏览器
nnoremap <leader>e :NERDTreeToggle<CR>
" ,s 使vimrc生效 
nnoremap <leader>ss :source ~/.vim/vimrc<CR>
" ,p 切换粘贴模式
nnoremap <leader>p :set invpaste paste?<CR>
" ,m/,M 切换Buffer
nnoremap <leader>m :bNext<CR>
nnoremap <leader>M :bprevious<CR>
" ,a 全选
nnoremap <Leader>a ggVG"

" J/K 移动选中内容
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

map <silent> tn :tabnext<CR>
map <silent> tp :tabprevious<CR>

```

#### 插件
---
```
" 状态栏 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
" 华丽的代码截图Web版
Plug 'mattr555/vim-instacode'
" 神级跳转
Plug 'easymotion/vim-easymotion'
" 优雅的光标
Plug 'terryma/vim-multiple-cursors'
" 优雅的格式化
Plug 'maksimr/vim-jsbeautify'
" 优雅的Git管理
Plug 'tpope/vim-fugitive'
```
