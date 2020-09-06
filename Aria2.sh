# Aria2 + AriaNg

## https://github.com/aria2/aria2
## https://github.com/mayswind/AriaNg/

AriaNG_Version=1.1.7
AriaNG_Download="https://github.com/mayswind/AriaNg/releases/download/$AriaNG_Version/AriaNg-$AriaNG_Version.zip"

mkdir /var/download

apt install -y aria2 unzip
mkdir /etc/aria2
cp aria2.conf /etc/aria2/aria2.conf
touch /etc/aria2/aria2.session
chmod 644 /etc/aria2/*

echo "[Unit]
Description=Aria2
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/aria2c --conf-path=/etc/aria2/aria2.conf
ExecStop=/bin/kill -s STOP \$MAINPID
ExecReload=/bin/kill -s HUP \$MAINPID

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/aria2.service

systemctl enable aria2.service
systemctl start aria2.service