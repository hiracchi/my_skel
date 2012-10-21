#!/bin/bash

PACKAGES="\
sysv-rc-conf \
zsh tcsh ksh \
build-essential gfortran automake autoconf libtool \
libcppunit-dev electric-fence ddd \
google-perftools libgoogle-perftools-dev \
git subversion doxygen graphviz \
vim emacs vnc4server \
python-sphinx python-numpy python-matplotlib \
gnuplot pymol \
"
sudo aptitude -y install ${PACKAGES}

