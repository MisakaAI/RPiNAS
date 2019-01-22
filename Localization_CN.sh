#!/bin/bash
# Localization of China

# Apt Sources
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "# Tuna
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main non-free contrib" > /etc/apt/sources.list
mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
echo "# Tuna
deb https://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ stretch main ui" > /etc/apt/sources.list.d/raspi.list

apt clean && apt update && apt upgrade -y && apt autoremove -y && apt autoclean

# Pypi Sources
apt install -y python3-pip
pip3 install pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Locale LANG 
export LANG=zh_CN.UTF-8
locale-gen zh_CN.UTF-8

# Hosts
wgte -O /etc/hosts https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts
echo "127.0.1.1       raspberrypi" >> /etc/hosts

# Oh My Zsh
apt -y install git zsh zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> /etc/zsh/zshrc
echo "zstyle ':completion:*' rehash true" >> /etc/zsh/zshrc
echo "setopt no_nomatch" >> /etc/zsh/zshrc
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"af-magic\"/g" ~/.zshrc