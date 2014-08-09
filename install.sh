#! /bin/sh
#
# install.sh
# Copyright (C) 2014 Fechin <lihuoqingfly@163.com>
#
# Distributed under terms of the MIT license.

echo "安装需要花费一些时间，请等待..."

# 清空插件目录
rm -rf $HOME/.vim/plugged/

# Linux 系统安装
if which apt-get >/dev/null; then
    sudo apt-get install build-essential cmake python-dev pyflakes npm
elif which yum >/dev/null; then
    sudo yum install -y build-essential cmake python-dev pyflakes npm
fi

# Mac 系统安装
if which brew >/dev/null;then
    brew install cmake
    sudo easy_install pyflakes
    npm install jshint -g
fi

vim -c "PlugInstall" -c "q" -c "q"
cd $HOME/.vim/plugged/YouCompleteMe/
./install.sh --clang-completer

echo "恭喜，安装完成！"
