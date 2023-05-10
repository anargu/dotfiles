#!/bin/sh

# echo ".cfg" >> .gitignore

git clone --bare https://github.com/anargu/dotfiles.git $HOME/.cfg

alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

config config --local status.showUntrackedFiles no

config checkout
