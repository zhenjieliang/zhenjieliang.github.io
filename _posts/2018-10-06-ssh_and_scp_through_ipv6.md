---
layout: post
title:  "使用 ipv6 地址设置 ssh 连接和 scp 传输"
date:   2018-10-06 10：08：18 +0800
categories: cs network
---

因为私人没有公网的 ipv4 ip 地址，而且家庭网络可能会因各种运营商的奇葩服务导致网络环境异常复杂，从而使得通过 noip 域名绑定动态 ip - 端口转发 这条路走不通。

为了解决远程连接指定电脑的问题，有两种思路：（1）构建家庭 VPN。这种方法优点是速度快，缺点是需要有特定功能的路由器（必须满足 DD-WRT）。（2）通过 ipv6 地址连接。优点是无需硬件支持，缺点则是速度较慢。

下面在 linux 环境下介绍通过 ipv6 地址联接远程服务器的办法。

首先，如果运营商提供了 ipv6 服务，通过 test-ipv6.com 这个网站就可以测试是否有提供，或者在命令行中输入

```shell
ping6 ipv6.google.com
```

如果 ping 得通，说明有 ipv6 的公网地址。此时只要再输入 `ifconfig` 即可查看到 ipv6 的地址。注意，公网的 ipv6 的地址是以 2001 为开头的。

在没有 ping 通时，linux 系统下可以安装 miredo 进行 ipv4 转 ipv6，进而得到 ipv6 公网地址。相关的命令如下。

```shell
sudo apt install miredo
sudo miredo
systemctl status miredo.service
sudo vim /etc/miredo.conf
```

安装成功即可通过 `ifconfig` 看到 ipv6 公网地址。注意即使 miredo 的 status 显示为 fail，只要使用 `ping6 ipv6.google.com` 可以发送接收包，即可。

如若 ping 不通，则可以修改 miredo.conf 的 teredo 公共服务器地址列表。可以参考 [网址](https://wiki.klniu.com/zh-hans/Teredo) 来修改。



使用 ssh 和 scp 连接 ipv6 地址的命令有

```shell
ssh -p port_num -v user@ipv6
scp -p port_num -v user@ipv6:~/ ~/Downloads/files
```

注意可以在. zshrc 里修改 alias，将 `ssh -p port_num -v` 等缩写为 `sshr`。此外，ipv6 的地址很长，可以通过 `sudo vim /etc/hosts` 将地址加入。

scp 时需要注意，由于 IPv6 地址中的冒号和指定路径之前的冒号有冲突，需要用中括号加转义字符的方式把 IPv6 的地址括起来。（不过在修改 /etc/hosts 以后，则使用和 ssh 中的 host 相同的代号即可。）

https://beanocean.github.io/tech/2014/10/17/scp_ipv6/


当远程服务器重启之后，则 miredo 不会自动重启，不再有 ipv6 地址。解决方法分为两个步骤：（1）将需要 sudo 权限才能启动的 miredo 放入 `/etc/rc.local` 执行，开机自启动；（2）在 `/etc/network/if-up.d/` 建立脚本 `iplog`，用 `ifconfig > iplog.txt` 来生成 ip 记录；（3）使用定时任务，每分钟定时向中继的有公网 ip 的 vps 发送该 ip 记录文件。

`/etc/rc.local` 文件如下：

```shell
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

sh /home/liangzhenjie/miredoAutoStart.sh &
 exit 0
```

而其中的 `miredoAutoStart.sh` 如下：

```shell
#!/bin/sh

miredo

sleep 5

ifconfig > /home/liangzhenjie/ip6.txt
```

使用 `chmod +x miredoAutoStart.sh` 来赋予权限。

第一个步骤至此完成。每次重启都会启动 miredo，并将 ip 记录添加到指定文件中。

第二个步骤是在网络环境稳定后，将 ip 记录添加到指定文件中。之所以需要这样做，是因为将这个功能整合进第一个步骤时容易造成生成的 iplog 不准确，因为第一步中的网络环境还未准备好。具体做法:

```shell
sudo vim /etc/network/if-up.d/iplog
```

`/etc/network/if-up.d/iplog` 具体如下：

```shell
#!/bin/sh

ifconfig > /home/liangzhenjie/ip6.txt
```

使用 `sudo chmod +x /etc/network/if-up.d/iplog` 对其赋予权限。


第三个步骤则是将指定文件发送给指定的中继 vps 添加到定时任务，每分钟发送一次。

```shell
crontab -e

* * * * * /path/to/uploadip.sh
```

uploadip.sh 如下：

```shell
#!/bin/sh

scp /home/liangzhenjie/ip6.txt root@ip:/root
```

使用 `chmod +x uploadip.sh` 来赋予权限。

注意，远程服务器应该能够无密码 ssh 连接到中继 vps 才可。具体做法请参考 [shadowsocksr](https://zhenjieliang.me/network/linux/2017/07/30/shadowsockr.html) 一文。

![Don't fall](/assets/cat1.gif)
