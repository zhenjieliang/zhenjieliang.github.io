---
layout: post
title:  "Shadowsocksr"
date:   2017-07-31 07:45:33 +0800
categories: life update
---

## 安装 serverspeeder

选择 ubuntu 14.04 的镜像

```shell
apt-get install linux-image-4.2.0-35-generic
uname -r
update-grub
reboot
wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh
```



## 服务端


```shell
apt-get install git
apt-get install python
apt-get install vim
git clone -b manyuser  https://github.com/shadowsocksrr/shadowsocksr.git
cd shadowsocksr
bash initcfg.sh
vim ~/shadowsocksr/user-config.json
```

单用户设置

```json
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": ,# 修改
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "",# 修改
    "timeout": 600,"method":"none",#可以修改成其他加密
    "protocol":"auth_chain_a",# 可以修改成 auth_chain_b
    "protocol_param":"",
    "obfs": "tls1.2_ticket_auth",
    "obfs_param": "",# 可以修改
    "redirect":"",
    "dns_ipv6": false,
    "fast_open": false,
    "workers": 1
}
```

运行

```shell
cd ~/shadowsocksr/shadowsocks
python server.py -d start
```


## 客户端


```shell
git clone -b manyuser  https://github.com/shadowsocksrr/shadowsocksr.git
sudo vim /etc/younameit.json
```

younameit.json 设置

```json
{
"server":"",#查服务器 ip，填上
"server_ipv6":"::",
"server_port":"",# 同服务端单用户设置
"local_address": "127.0.0.1",
"local_port":1080,
"password":"",# 同服务端单用户设置
"timeout":600,
"udp_timeout": 600,
"method":"none",#同服务端单用户设置
"protocol":"auth_chain_a",#同服务端单用户设置
"obfs":"tls1.2_ticket_auth",#同服务端单用户设置
"obfs_param":""# 同服务端单用户设置
}
```

保存之后。设置启动脚本

```shell
vim younameit.sh
```

younameit.sh 只有一行代码

```bash
#! /bin/sh

sudo python ~/shadowsocksr/shadowsocks/local.py \
-c /etc/younameit.json -d start
```


至此服务端与客户端都已设置完毕。

## 启动与关闭

开机后客户端启动

```shell
sh younameit.sh
```

关闭则再运行一次上述命令，得到已经在运行的报错信息，再根据信息中的 pid，关闭客户端。

```shell
sudo kill pid
```



