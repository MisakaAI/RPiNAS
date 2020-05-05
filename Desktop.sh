#!/bin/bash

# Git 
# Read parameters
echo "Enter your github username:"
read git_username
echo "Enter your email:"
read git_email

## Git
sudo apt-get install -y git wget curl

# Git Setting
git config --global user.name \"$git_username\"
git config --global user.email \"$git_email\"
git config --global color.ui true
git config --global push.default simple
git config --global core.autocrlf input
git config --global core.safecrlf true

# Oh My Zsh
sudo apt-get install -y git curl zsh zsh-syntax-highlighting zsh-autosuggestions
sudo sh -c 'echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /etc/zsh/zshrc'
sudo sh -c 'echo "setopt no_nomatch" >> /etc/zsh/zshrc'
sudo sh -c 'echo "zstyle \":completion:*\" rehash true" >> /etc/zsh/zshrc'
sudo sh -c 'echo "plugins=(zsh-autosuggestions)" >> /etc/zsh/zshrc'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Input method
# sudo apt-get install -y fcitx-googlepinyin fcitx-rime
# Fonts 
# sudo apt-get install -y fonts-noto fonts-inconsolata fonts-wqy-zenhei fonts-wqy-microhei
# Kodi
# sudo apt-get install -y kodi kodi-pvr-mythtv kodi-pvr-vuplus kodi-pvr-vdr-vnsi kodi-pvr-njoy kodi-pvr-nextpvr kodi-pvr-mediaportal-tvserver kodi-pvr-tvheadend-hts kodi-pvr-dvbviewer kodi-pvr-argustv kodi-pvr-iptvsimple kodi-audioencoder-vorbis kodi-audioencoder-flac kodi-audioencoder-lame glew-utils