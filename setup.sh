#!/bin/sh

SRC_DIR=$(cd $(dirname $0); pwd)
echo $SRC_DIR

ln -snf ${SRC_DIR}/dot.zshenv ${HOME}/.zshenv

ln -snf ${SRC_DIR}/zsh ${HOME}/.zsh

# setup zaw
if [ -d ${HOME}/.zsh/zaw ]; then
    (cd ${HOME}/.zsh/zaw; git pull)
else 
    (cd ${HOME}/.zsh; git clone git://github.com/nakamuray/zaw.git)
fi

# setup zsh-completions for git
if [ -d ${HOME}/.zsh/zsh-completions ]; then
    (cd ${HOME}/.zsh/zsh-completions; git pull)
else 
    (cd ${HOME}/.zsh; git clone git://github.com/zsh-users/zsh-completions.git)
fi

# set git-flow-completions
if [ -d ${HOME}/.zsh/git-flow-completion ]; then
    (cd ${HOME}/.zsh/git-flow-completion; git pull)
else
    (cd ${HOME}/.zsh; git clone git://github.com/bobthecow/git-flow-completion.git)
fi

ln -snf ${SRC_DIR}/dot.zshrc ${HOME}/.zshrc
ln -snf ${SRC_DIR}/dot.zshrc ${HOME}/.zshrc
ln -snf ${SRC_DIR}/dot.zlogin ${HOME}/.zlogin
ln -snf ${SRC_DIR}/dot.emacs.d ${HOME}/.emacs.d
ln -snf ${SRC_DIR}/dot.vimrc ${HOME}/.vimrc

ln -snf ${SRC_DIR}/dot.tmux.conf ${HOME}/.tmux.conf
ln -snf ${SRC_DIR}/dot.screenrc ${HOME}/.screenrc

ln -snf ${SRC_DIR}/dot.fd2rc ${HOME}/.fd2rc

