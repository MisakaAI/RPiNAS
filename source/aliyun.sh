# Aliyun (https://developer.aliyun.com/mirror/)

## Backup origon file
cp /etc/apt/sources.list /etc/apt/sources.list.bak

## Add new source.list file
echo "deb https://mirrors.aliyun.com/raspbian/raspbian/ buster main non-free contrib
deb-src https://mirrors.aliyun.com/raspbian/raspbian/ buster main non-free contrib" > /etc/apt/sources.list