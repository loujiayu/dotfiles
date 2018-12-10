#!/usr/bin/env bash

for var in .functions .aliases .zshrc .vimrc .gitconfig .vim
do
  ln -sf $PWD/$var ~
done

zsh