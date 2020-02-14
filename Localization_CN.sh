#!/bin/bash
# Localization of China

# Apt source of Tuna
## Backup origon file
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
## Add new source.list file
echo "deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib" > /etc/apt/sources.list
echo "deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui" > /etc/apt/sources.list.d/raspi.list
apt clean && apt update && apt upgrade -y && apt autoremove -y && apt autoclean

# Pypi Sources
apt install -y python3-pip
pip3 install pip -U
pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Locale LANG 
export LANG=zh_CN.UTF-8
locale-gen zh_CN.UTF-8