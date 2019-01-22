#!/usr/bin/env bash
# Raspberry Pi NAS Install
# Author : Selphia
# Email : lolisound@gmail.com
# Time : 1/22/2019
# Version : 1.3

### Detect if the user is root
if [ "$UID" != "0" ]
then
    echo "\033[31m请使用 root 用户执行\033[0m"
	exit 1
fi

## 设置变量
AriaNG_Version=1.0.0
AriaNG_Download="https://github.com/mayswind/AriaNg/releases/download/$AriaNG_Version/AriaNg-$AriaNG_Version.zip"
NextCloud_Version=15.0.2
NextCloud_Download="https://download.nextcloud.com/server/releases/nextcloud-$NextCloud_Version.zip"

env() {
    ## 系统更新
    apt update && apt upgrade -y && apt autoremove -y && apt autoclean
    ## SSH
    apt install -y ssh
    sed -i "s/#TCPKeepAlive yes/TCPKeepAlive yes\nClientAliveInterval 60\nClientAliveCountMax 120/g" /etc/ssh/sshd_config
	sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
    systemctl restart ssh.service
    ## Nginx
    apt install -y nginx
    ## Sqlite3
    apt install -y sqlite3
    ## PHP 7 
    apt install -y php-fpm \
    php-ctype \
    php-dom \
    php-gd \
    php-iconv \
    php-json \
    php-mbstring \
    php-posix \
    php-simplexml \
    php-xmlreader \
    php-xmlwriter \
    php-zip \
    php-pdo-sqlite \
    php-curl \
    php-fileinfo \
    php-bz2 \
    php-intl \
    php-mcrypt \
    php-apcu \
    php-imagick
    ## Python 3
    apt install -y python3 python3-pip
    # pip3 install uwsgi
}

aria2() {
    ## Aria2 + AriaNg
    ## https://github.com/aria2/aria2
    ## https://github.com/mayswind/AriaNg/

    apt install -y aria2 unzip
    wget $AriaNG_Download
    mkdir /var/www/html/aria2
    unzip AriaNg-$AriaNG_Version.zip -d /var/www/html/aria2
    chown www-data:www-data -R /var/www/html/aria2
    rm -rf AriaNg-$AriaNG_Version.zip

    ## Aria2 Setting
    mkdir /etc/aria2
    chown $username:$username /etc/aria2
    cp aria2.conf /etc/aria2/aria2.conf
    chown $username:$username /etc/aria2/aria2.conf
    chmod 644 /etc/aria2/aria2.conf
    touch /etc/aria2/aria2.session
    chown $username:$username /etc/aria2/aria2.session

    ## Run aria2 when computer starts
    echo "[Unit]
Description=Aria2
After=network.target

[Service]
User=$username
Group=$username
Type=simple
ExecStart=/usr/bin/aria2c --conf-path=/etc/aria2/aria2.conf
ExecStop=/bin/kill -s STOP \$MAINPID
ExecReload=/bin/kill -s HUP \$MAINPID

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/aria2.service
    systemctl enable aria2.service
    systemctl start aria2.service
}

nfs() {
    # NFS
    apt install -y nfs-common nfs-kernel-server ntfs-3g
    echo -e "/$username  *(rw,sync,all_squash)" >> /etc/exports
    /etc/init.d/nfs-kernel-server start
    systemctl enable nfs-server.service
}

nextcloud() {
    wget $NextCloud_Download
    unzip nextcloud-$NextCloud_Version.zip -d /var/www/html
    chown www-data:www-data -R /var/www/html/nextcloud
    rm -rf nextcloud-$Nextcloud_Version.zip
    cp /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bak
    cp ./default /etc/nginx/sites-enabled/default
    systemctl restart nginx.service
}

install() {
    # Creating RPiNAS user
    username="rpinas"
    useradd -d /$username -m -s /usr/sbin/nologin $username
    chmod 777 /$username
    env
    aria2
    nextcloud
    nfs
    exit 0
}
install
exit 2