#!/bin/bash

set -e

echo "Installing dotfiles..."
pushd `dirname $0` >> /dev/null
DOTFILES_DIR=`pwd -P`

cd $DOTFILES_DIR
pwd

echo "Installing submodules..."
git submodule update --init --recursive

cd "$DOTFILES_DIR/scripts/bin/"
pwd

./install-homebrew

echo "Installing gnu stow (dotfile deploy tool)..."
brew install stow

echo "Symlinking in dot files..."
stow --ignore="\.DS_Store" -d $DOTFILES_DIR -t $HOME -v 1 -S zsh -S vim -S git -S ctags -S scripts

cd "$DOTFILES_DIR/scripts/bin/"
pwd

./install-homebrew-formulas
./install-monaco-font
./install-vim-plugins
./osx-set-defaults
./zsh-set-as-default
./zsh-cache-nuke

echo "All done. You should restart your terminal for new shell to take effect!"