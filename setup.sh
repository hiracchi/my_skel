#!/bin/sh

SRC_DIR=$(cd $(dirname $0); pwd)
echo $SRC_DIR

ln -sf ${SRC_DIR}/dot.zshenv ${HOME}/.zshenv
ln -sf ${SRC_DIR}/dot.zshrc ${HOME}/.zshrc
ln -sf ${SRC_DIR}/dot.emacs.d ${HOME}/.emacs.d
ln -sf ${SRC_DIR}/dot.screenrc ${HOME}/.screenrc

