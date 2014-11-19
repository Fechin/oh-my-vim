#! /bin/sh
#
# setup.sh [vim]
#     参数：启动vim的命令，默认为“vim”
# Copyright (C) 2014 Fechin <lihuoqingfly@163.com>
#
# Distributed under terms of the MIT license.

# 系统检测
OS=$(uname)

if [ ${OS} != "Darwin" ] && [ ${OS} != "Linux" ]; then
    echo "暂时不支持${OS}系统!"
    exit 1
fi

# 取第一个参数作为启动vim命令
VIM_COMMAND_NAME="vim"
if [ $1 ]; then
    VIM_COMMAND_NAME=$1
fi

echo "好东西在后头，你需要的只是等待..."

# 插件目录,跟vimrc保持一致
PLUG_DIR=$HOME/.vim/plugged

# 清空插件目录
if [ -d $PLUG_DIR ]; then
    echo "干掉插件目录：" $PLUG_DIR
    sudo rm -rf $PLUG_DIR
fi

# Linux 系统安装
if hash apt-get 2>/dev/null; then
    sudo apt-get install -y build-essential cmake python-dev pyflakes npm markdown
elif hash yum 2>/dev/null; then
    sudo yum install -y build-essential cmake python-dev pyflakes npm markdown
fi

# Mac 系统安装
if hash brew 2>/dev/null; then
    sudo easy_install pyflakes
    brew install cmake npm
fi

# 安装JS语法检查工具
JSHINT=/usr/local/bin/jshint
hash jshint 2>/dev/null || {
    sudo npm install jshint -g
    if [ -e $JSHINT ]; then
        sed -i '/env /s/node$/nodejs/g' $JSHINT
    fi
}

VIM_COMMAND="PlugInstall"
ERROR_PREFIX="\033[31m Error:\033[0m "

$VIM_COMMAND_NAME -c "PlugUpgrade" -c "$VIM_COMMAND"  -c "q" -c "q"

# 定时检测vim是否退出
if [ $? -eq 0 ]; then
    while true; do
        ps -ef | grep -v grep | grep -v "setup.sh" | grep "$VIM_COMMAND" > /dev/null || break
        echo ">\c"
        sleep 3
    done
else
    echo "\n$ERROR_PREFIX 命令[$VIM_COMMAND_NAME]执行异常，烦请瞄一眼参数!"
    exit 1
fi

# do something
if [ -d "$PLUG_DIR/YouCompleteMe/" ]; then
    YCMD_DIR=$PLUG_DIR/YouCompleteMe/third_party/ycmd
    if [ ! -e "$YCMD_DIR/build.sh" ]; then
        cd $YCMD_DIR
        git submodule update --init --recursive
    fi

    cd $PLUG_DIR/YouCompleteMe
    ./install.sh --clang-completer
else
    echo "\n$ERROR_PREFIX YouCompleteMe安装失败，参考：https://github.com/Valloric/YouCompleteMe"
    exit 1
fi

echo "久等，现在你能做的不止是煮咖啡！！"
