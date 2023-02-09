#!/bin/bash

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc

if [ -d ~/.oh-my-zsh/themes ]; then
    ln -sf ~/dotfiles/zsh/themes/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
fi
