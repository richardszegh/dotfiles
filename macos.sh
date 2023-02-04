#!/bin/zsh

brew install autojump bat ffmpeg git gnupg jq neofetch nmap ranger ripgrep wifi-password yt-dlp

brew install --cask kitty macvim

# alias dotfiles
ln -s "${HOME}/Workspace/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/Workspace/dotfiles/.vimrc" "${HOME}/.vimrc"
ln -s "${HOME}/Workspace/dotfiles/.gitconfig" "${HOME}/.gitconfig"
ln -s "${HOME}/Workspace/dotfiles/.ssh/config" "${HOME}/.ssh/config"
