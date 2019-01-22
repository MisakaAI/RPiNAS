# RaspberryPi-NAS
Network Attached Storage and Downloader for Raspberry Pi<br>
基于树莓派的网络附加存储和下载装置(极简低成本版NAS)

## 硬件
 * Raspberry Pi
 * Mirco SD Card（4GB以上）
 * Micro USB 数据线 & USB 充电器（为树莓派供电）
 * 超五类非屏蔽双绞线（树莓派连接路由器）
 * 硬盘（大容量存储）
 * 硬盘盒（尺寸应于硬盘一致、建议使用 Type-C 接口的硬盘盒)
 *树莓派的USB接口电压较低，可能无法带动普通的移动硬盘，因此请使用带独立供电的硬盘盒+硬盘*
 ![Sketch](Sketch.png)

## 软件
系统：[Raspbian](https://www.raspberrypi.org/downloads/raspbian/)<br>
语言：[PHP7](http://php.net/) and [Python3](https://www.python.org/)<br>
网络共享：NFS<br>
远程控制：OpenSSH<br>
NTFS磁盘读写：NTFS-3G<br>
Web服务器：[Nginx](http://nginx.org/)<br>
下载：[Aria2](https://github.com/aria2/aria2)<br>
Aria2前端：[AriaNg](http://ariang.mayswind.net/)<br>
私有云：[NextCloud](https://nextcloud.com/)<br>
数据库：[SQLite](http://www.sqlite.org)
（也可以用 Postgresql or MariaDB 等数据库，给 Nextcloud 用的）<br>
*内网穿透：[Ngrok](https://ngrok.com/)*
（移动等不给公网ip的宽带需要，有公网ip可以在路由器中设置DDNS和端口转发）<br>
*代码版本控制：[Git](https://git-scm.com/)*
（不想把代码放在Gayhub的话了）

## 端口
**（可能需要在路由器内设置 DDNS 和端口转发）**<br>
Web服务器：80/443<br>
Aria2 RPC：6800<br>
ssh：22<br>

## 安装

```
# 中文环境
# bash Localization_CN.sh
# 安装
bash ./install.sh
# 挂载硬盘
fdisk -l
mount.ntfs-3g /dev/sdx1 /rpinas
# 开机自动挂载
echo '/dev/sdx1 /rpinas ntfs-3g defaults 0 0' >> /etc/fstab
# 设置Aria2 RPC密码
nano /etc/aria2/aria2.conf
# 将 rpc-secret=<TOKEN> 取消注释并将 <TOKEN> 替换为密码
```

## 远程访问

在路由器中设置 **DDNS** 和 **端口转发** 可实现公网访问。<br>
由于路由器型号不同，在此不予说明，请根据 **路由器说明书** 或者 **Google / Baidu** 进行设置。

```
## Tp-Link 路由器

# Aria2 (远程下载)
http(s)://DOMAIN.tpddns.cn:PORT/aria2
(192.168.1.*/aria2)
# Nextcloud (私有云)
http(s)://DOMAIN.tpddns.cn:PORT/nextcloud
(192.168.1.*/nextcloud)
```
*DOMAIN*：DDNS设置的二级域名<br>
*PORT*：端口转发设置转发至内部80/443端口的外部端口

## 挂载 NFS 目录到主机
**Linux**
```
# 查看 ip 地址 有线：enp4s0f1 无线：wlp3s0
ip addr
mkdir /mnt/Raspberry
mount.nfs 192.168.1.*:/rpinas /mnt/Raspberry
# 请根据实际 ip 地址修改
echo '192.168.1.*:/rpinas   /mnt/Raspberry  nfs     defaults,user   0   0' >> /etc/fstab
```
**Windows 10**
```
1. 设置 > 查找设置 > 启用或关闭 Windows 功能 > NFS 服务 > NFS 客户端
2. 此电脑 > 计算机 > 映射网络驱动器 > 驱动器：选一个可爱的盘符 > 文件夹：\\192.168.1.*\rpinas > 完成
```