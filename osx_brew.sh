#!/bin/bash

brew install tmux ssh-copy-id mobile-shell
brew install htop-osx

brew tap homebrew/versions
brew install gcc47 --enable-all-languages
brew install globus-toolkit

brew install pyenv pyenv-virtualenv
brew install autoconf automake libtool
brew install git-flow valgrind google-perftools ddd
brew install libyaml  

# Ricty
brew tap sanemat/font
brew install ricty
cp -f /usr/local/Cellar/ricty/3.2.2/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

