#!/bin/bash

git config --global user.name "Toshiyuki HIRANO"
git config --global user.email "hiracchi@gmail.com"

git config --global core.editor vim
git config --global core.pager 'less -R'
git config --global color.ui auto
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.status.changed yellow
git config --global color.status.added green
git config --global color.status.untracked red

# use --no-ff option on 'git merge' after v1.7.6
git config --global --add merge.ff false
# master 上で git pull するときは常に rebase
git config branch.master.rebase true
# git pull するときは常に rebase(1.7.9以降)
git config --global pull.rebase true

# Verify git settings
git config --list
