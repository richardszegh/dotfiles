#!/bin/zsh

echo "[macos.sh](info) let's get your Mac set up 🔥"

# ask for the administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until `macos.sh` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# check if 'dotfiles' was cloned into the correct directory
if [ ! -d "${HOME}/Workspace/dotfiles" ]; then
  echo "[macos.sh](error) 'dotfiles' must be cloned into the '${HOME}/Workspace' directory"
  exit 1
fi

# (1/9) install homebrew
if command -v brew &>/dev/null; then
  echo "[macos.sh](info) homebrew is already installed, skipping..."
else
  echo "[macos.sh](info) installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "[macos.sh](info) finished installing homebrew"
fi

# (2/9) install brew packages
echo "[macos.sh](info) installing brew packages..."
brew install autojump bat coreutils diff-so-fancy ffmpeg fd git gh glow gnupg httpie jq nmap ranger \
  restic ripgrep rsync spek tldr thefuck wifi-password yt-dlp pipenv pyenv
echo "[macos.sh](info) finished installing brew packages"

# (3/9) install brew casks
echo "[macos.sh](info) installing brew casks..."
brew install --cask --no-quarantine alacritty
brew install --cask google-chrome brave-browser firefox 1password \
  sunsama slack loom zoom \
  figma exifcleaner audacity handbrake losslesscut \
  visual-studio-code zed orbstack insomnia wireshark fork linear-linear typora \
  the-unarchiver transmission veracrypt flux rectangle cleanshot keepingyouawake raycast pika cold-turkey-blocker \
  balance-lock maccy istat-menus jordanbaird-ice bettertouchtool appcleaner \
  soulseek xld musicbrainz-picard meta \
  telegram pocket-casts \
echo "[macos.sh](info) finished installing brew casks"

# (4/9) install oh-my-zsh
if [ -d "${HOME}/.oh-my-zsh" ]; then
  echo "[macos.sh](info) oh-my-zsh is already installed, skipping..."
else
  echo "[macos.sh](info) installing oh-my-zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "[macos.sh](info) finished installing oh-my-zsh"
  echo "[macos.sh](info) installing oh-my-zsh plugins..."
  echo "[macos.sh](info) installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo "[macos.sh](info) finished installing zsh-autosuggestions"
  echo "[macos.sh](info) installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo "[macos.sh](info) finished installing zsh-syntax-highlighting"
fi

# (5/9) install NVM
if [ -d "${HOME}/.nvm" ]; then
  echo "[macos.sh](info) NVM is already installed, skipping..."
else
  echo "[macos.sh](info) installing NVM..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh)"
  echo "[macos.sh](info) finished installing NVM"
fi

# (6/9) remove default dotfiles
if [ -e "${HOME}/.zshrc" ]; then
  rm "${HOME}/.zshrc"
  echo "[macos.sh](info) removed default '.zshrc'"
fi

if [ -e "${HOME}/.vimrc" ]; then
  rm "${HOME}/.vimrc"
  echo "[macos.sh](info) removed default '.vimrc'"
fi

if [ ! -d "${HOME}/.vim/autoload" ]; then
  mkdir -p "${HOME}/.vim/autoload"
  echo "[macos.sh](info) created '~/.vim/autoload' folder, because it did not exist"
else
  if [ -e "${HOME}/.vim/autoload/plug.vim" ]; then
    rm "${HOME}/.vim/autoload/plug.vim"
    echo "[macos.sh](info) removed default '~/.vim/autoload/plug.vim'"
  fi
fi

if [ -e "${HOME}/.gitconfig" ]; then
  rm "${HOME}/.gitconfig"
  echo "[macos.sh](info) removed default '.gitconfig'"
fi

if [ ! -d "${HOME}/atg" ]; then
  mkdir -p "${HOME}/atg"
  echo "[macos.sh](info) created '~/atg' folder, because it did not exist"
else
  if [ -e "${HOME}/atg/.gitconfig" ]; then
    rm "${HOME}/atg/.gitconfig"
    echo "[macos.sh](info) removed default '~/atg/.gitconfig'"
  fi
fi

if [ ! -d "${HOME}/.ssh" ]; then
  mkdir -p "${HOME}/.ssh"
  echo "[macos.sh](info) created '~/.ssh' folder, because it did not exist"
else
  if [ -e "${HOME}/.ssh/config" ]; then
    rm "${HOME}/.ssh/config"
    echo "[macos.sh](info) removed default '~/.ssh/config'"
  fi
fi

if [ ! -d "${HOME}/.config/zed" ]; then
  mkdir -p "${HOME}/.config/zed"
  echo "[macos.sh](info) created '~/.config/zed' folder, because it did not exist"
else
  if [ -e "${HOME}/.config/zed/settings.json" ]; then
    rm "${HOME}/.config/zed/settings.json"
    echo "[macos.sh](info) removed default '~/.config/zed/settings.json'"
  fi
  if [ -e "${HOME}/.config/zed/keymap.json" ]; then
    rm "${HOME}/.config/zed/keymap.json"
    echo "[macos.sh](info) removed default '~/.config/zed/keymap.json'"
  fi
fi

if [ ! -d "${HOME}/.config/alacritty" ]; then
  mkdir -p "${HOME}/.config/alacritty"
  echo "[macos.sh](info) created '~/.config/alacritty' folder, because it did not exist"
else
  if [ -e "${HOME}/.config/alacritty/alacritty.toml" ]; then
    rm "${HOME}/.config/alacritty/alacritty.toml"
    echo "[macos.sh](info) removed default '~/.config/alacritty/alacritty.toml'"
  fi
fi

# (7/9) alias dotfiles
echo "[macos.sh](info) creating aliases for all dotfiles..."
ln -s "${HOME}/Workspace/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/Workspace/dotfiles/.vimrc" "${HOME}/.vimrc"
ln -s "${HOME}/Workspace/dotfiles/.vim/autoload/plug.vim" "${HOME}/.vim/autoload/plug.vim"
ln -s "${HOME}/Workspace/dotfiles/.gitconfig" "${HOME}/.gitconfig"
ln -s "${HOME}/Workspace/dotfiles/atg/.gitconfig" "${HOME}/atg/.gitconfig"
ln -s "${HOME}/Workspace/dotfiles/.ssh/config" "${HOME}/.ssh/config"
ln -s "${HOME}/Workspace/dotfiles/.config/zed/settings.json" "${HOME}/.config/zed/settings.json"
ln -s "${HOME}/Workspace/dotfiles/.config/zed/keymap.json" "${HOME}/.config/zed/keymap.json"
ln -s "${HOME}/Workspace/dotfiles/.config/alacritty/alacritty.toml" "${HOME}/.config/alacritty/alacritty.toml"
echo "[macos.sh](info) finished creating aliases for all dotfiles"

# (8/9) clone and alias scripts
echo "[macos.sh](info) cloning and aliasing user scripts..."
git clone https://github.com/richardszegh/scripts ${HOME}/Workspace/scripts
chmod +x ${HOME}/Workspace/scripts/*
echo "[macos.sh](info) finished cloning and aliasing user scripts"

# (9/9) misc.
echo "[macos.sh](info) installing fonts..."
brew tap homebrew/cask-fonts
brew install font-hack
echo "[macos.sh](info) finished installing fonts"

echo "[macos.sh](info) installing vim plugins..."
vim +PlugInstall +qall
echo "[macos.sh](info) finished installing vim plugins"

# reload .zshrc
source ${HOME}/.zshrc

echo "[macos.sh](info) successfully set up your Mac 🚀"
echo "-"
echo "[macos.sh](warn) Note: the following apps must be installed manually:"
echo "[macos.sh](warn)   - Xcode Command Line Tools ($(xcode-select --install))"
echo "[macos.sh](warn)   - DaVinci Resolve"
echo "[macos.sh](warn)   - Infuse"
echo "[macos.sh](warn)   - Drivers (Logitech etc.)"
echo "[macos.sh](warn)   - Kindle, Send to Kindle, GoToMeeting"
echo "[macos.sh](warn)   - VPN, Jellyfin, Synergy, REW"
echo "[macos.sh](warn)   - Ledger Live, Electrum, TradingView"
echo "-"
echo "[macos.sh](warn) Optional:"
echo "[macos.sh](warn)   - install apps & tools from Gumroad (https://app.gumroad.com/library)"
echo "-"
echo "[macos.sh](warn) please restart your computer!"
