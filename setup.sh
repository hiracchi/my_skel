#!/bin/sh

SRC_DIR=$(cd $(dirname $0); pwd)
echo $SRC_DIR

# oh-my-zsh
if [ ! -d ${HOME}/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
fi

ln -sf ${SRC_DIR}/dot.zshenv ${HOME}/.zshenv
ln -sf ${SRC_DIR}/dot.zshrc ${HOME}/.zshrc
ln -sf ${SRC_DIR}/dot.zshrc_common ${HOME}/.zshrc.common
ln -sf ${SRC_DIR}/dot.zlogin ${HOME}/.zlogin
ln -sf ${SRC_DIR}/dot.emacs.d ${HOME}/.emacs.d
ln -sf ${SRC_DIR}/dot.vimrc ${HOME}/.vimrc
ln -sf ${SRC_DIR}/dot.screenrc ${HOME}/.screenrc
ln -sf ${SRC_DIR}/dot.fd2rc ${HOME}/.fd2rc

