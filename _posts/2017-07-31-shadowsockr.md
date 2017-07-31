---
layout: post
title:  "Shadowsocksr "
date:   2017-07-31 07:45:33 +0800
categories: life update
---


## 服务端


```
apt-get install git
apt-get install python
git clone -b manyuser  https://github.com/shadowsocksrr/shadowsocksr.git
vim ~/shadowsocksr/user-config.json
```

单用户设置

```
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": ,#修改
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "",#修改
    "timeout": 600,
    "method": "none",#可以修改成其他加密
    "protocol": "auth_chain_a",#可以修改成auth_chain_b
    "protocol_param": "",
    "obfs": "tls1.2_ticket_auth",
    "obfs_param": "",#可以修改
    "redirect": "",
    "dns_ipv6": false,
    "fast_open": false,
    "workers": 1
}
```

运行

```
python ~/shadowsocksr/shadowsocks/server.py -d start
```


## 客户端


```
git clone -b manyuser  https://github.com/shadowsocksrr/shadowsocksr.git
sudo vim /etc/younameit.json
```

younameit.json 设置

```
{
    "server":"",#查服务器ip，填上
    "server_ipv6": "::",
    "server_port":"",#同服务端单用户设置
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"",#同服务端单用户设置
    "timeout":600,
    "udp_timeout": 600,
    "method":"none",#同服务端单用户设置
    "protocol": "auth_chain_a",#同服务端单用户设置
    "obfs":"tls1.2_ticket_auth",#同服务端单用户设置
    "obfs_param": ""#同服务端单用户设置
}
```

保存之后。设置启动脚本

```
vim younameit.sh
```

younameit.sh 只有一行代码

```
#! /bin/sh

sudo python ~/shadowsocksr/shadowsocks/local.py -c /etc/younameit.json -d start
```


至此服务端与客户端都已设置完毕。

## 启动与关闭

开机后客户端启动

```
sh younameit.sh
```

关闭则再运行一次上述命令，得到已经在运行的报错信息，再根据信息中的pid，关闭客户端。

```
sudo kill pid
```



