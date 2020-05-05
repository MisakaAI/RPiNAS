#!/bin/bash
if [ "$UID" != "0" ]; then
	echo "请使用 root 账户执行本程序."
	exit 0
fi

git clone --depth=1 https://github.com/googlehosts/hosts
cp ./hosts/hosts-files/hosts /etc/hosts
echo "127.0.0.1    `cat /etc/hostname`" >> /etc/hosts
rm -rf ./hosts

# cp ./update-hosts.sh /usr/local/bin/update-hosts
# chmod +x /usr/bin/update-hosts
# echo "0 0 * * * root /usr/bin/update-hosts" >> /etc/crontab