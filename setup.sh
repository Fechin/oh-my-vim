#!/usr/bin/env bash

# setup.sh [vim]
#     参数：启动vim的命令，默认为“vim”
# Copyright (C) 2014 Fechin <mr.fechin@gmail.com>
#
# Distributed under terms of the MIT license.

set -o errexit

# 系统检测
OS=$(uname)

if [ ${OS} != "Darwin" ] && [ ${OS} != "Linux" ]; then
    echo -e "暂时不支持${OS}系统环境!"
    exit 1
fi

# 取第一个参数作为启动vim命令,如果为空默认“vim”
VIM_COMMAND=${1:-vim}

# 插件目录,跟vimrc中的保持一致
PLUG_DIR=${HOME}/.vim/plugged

echo -e "-----------------------------------------------------------"
echo -e "---\t视网络情况，安装过程可能比较漫长，请耐心等待!\t---"
echo -e "-----------------------------------------------------------\v"
echo -e "将为你安装依赖包："
dependsmsg() {
    echo -e "-----------------------------\t---------------------------"
    echo -e "\t[*] build-essential\tDetails of package information"
    echo -e "\t[*] cmake          \tCross-Platform Makefile Generator"
    echo -e "\t[*] python-dev     \tDevelopment tools for building Python modules"
    echo -e "\t[*] pyflakes       \tSimple Python 2 source checker"
    echo -e "\t[*] npm            \tNode package manager"
    echo -e "\t[*] markdown       \tConvert text to HTML"
    echo -e "\t[*] git            \tPerl interface to the Git version control system"
    echo -e "\t[*] easy_install   \tManage Python packages\v"
};dependsmsg

notify() {
    echo -e "\e[30;48;5;82m Message: \e[0m \e[40;38;5;82m $1 \e[0m "
    if hash notify-send 2>/dev/null; then
        notify-send -i "notification-message-im" "Oh-my-vim 提示" "$1"
    fi
}

# Linux 系统安装
if hash apt-get 2>/dev/null; then
    sudo apt-get install -y build-essential cmake python-dev pyflakes npm markdown git
elif hash yum 2>/dev/null; then
    sudo yum install -y build-essential cmake python-dev pyflakes npm markdown git
fi

# Mac 系统安装
if hash brew 2>/dev/null; then
    sudo easy_install pyflakes
    brew install cmake npm markdown
fi

# 安装JS语法检查工具
JSHINT=/usr/local/bin/jshint
hash jshint 2>/dev/null || {
    sudo npm install jshint -g
    if [ -e $JSHINT ]; then
        sed -i "/env /s/node$/nodejs/g" $JSHINT
    fi
}

PLUGINSTALL="PlugInstall"

if hash ${VIM_COMMAND} 2>/dev/null; then
    ${VIM_COMMAND} -c "PlugUpgrade" -c "${PLUGINSTALL}"  -c "q" -c "q"
else
    notify "没找到命令: ${VIM_COMMAND},请检查参数"
    exit 1
fi

# 定时检测vim是否退出
if [ $? -eq 0 ]; then
    while true; do
        ps -ef | grep -v grep | grep -v "setup.sh" | grep "${PLUGINSTALL}" > /dev/null || break
        echo -ne "正在安装插件:[>>>>>                  ]\r"
        sleep 0.5
        echo -ne "正在安装插件:[>>>>>>>>>>>>>          ]\r"
        sleep 0.5
        echo -ne "正在安装插件:[>>>>>>>>>>>>>>>>>>>>>>>]\r"
        sleep 0.5
    done
else
    notify "command [${VIM_COMMAND}] exception!"
    exit 1
fi

# do something
if [ -d "${PLUG_DIR}/YouCompleteMe/" ]; then
    YCM_DIR=${PLUG_DIR}/YouCompleteMe/third_party/ycmd
    if [ ! -e "${YCM_DIR}/build.sh" ]; then
        cd ${YCM_DIR}
        git submodule update --init --recursive
    fi

    cd ${PLUG_DIR}/YouCompleteMe
    ./install.sh
    #./install.sh --clang-completer
else
    notify "YouCompleteMe 安装失败，请尝试重新执行 install.sh"
    exit 1
fi
notify "Successfully，Never stop the beat, Enjoy it please :-)"
