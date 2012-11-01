#!/bin/bash

PACKAGES="\
sysv-rc-conf \
zsh tcsh ksh \
build-essential gfortran automake autoconf libtool \
libcppunit-dev electric-fence ddd \
google-perftools libgoogle-perftools-dev \
git subversion doxygen graphviz \
vim emacs vnc4server \
python-dev python-setuptools \
python-sphinx python-numpy python-matplotlib msgpack-python pep8 \
gnuplot pymol octave maxima \
emacs-goodies-el emacs-goodies-extra-el \
magit git-flow tig \
"
sudo aptitude -y install ${PACKAGES}

# unset overlay scrollbar
sudo aptitude remove overlay-scrollbar liboverlay-scrollbar-0.2-0 liboverlay-scrollbar3-0.2-0

# for latex
#sudo jisftconfig add

