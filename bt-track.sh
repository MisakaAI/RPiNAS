#!/bin/bash
wget -O /tmp/trackers_best.txt https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt
sed -i "/^$/d" /tmp/trackers_best.txt
sed -i ":a;N;s/\n/,/g;ta" /tmp/trackers_best.txt
sed -i '$d' /etc/aria2/aria2.conf
echo "bt-tracker=`cat /tmp/trackers_best.txt`" >> /etc/aria2/aria2.conf
rm -r /tmp/trackers_best.txt
systemctl restart aria2.service

# cp ./bt-track.sh /usr/local/bin/update-bt-track
# chmod +x /usr/local/bin/update-bt-track
# echo "0 0 * * * root /usr/local/bin/update-bt-track" >> /etc/crontab