---
layout: post
title:  "zathura tabbed"
date:   2018-05-18 15：18：38 +0800
categories: cs tools
---

zathura-tabbed 分为分为两个步骤：安装、系统设置。其中主要脚本和说明可见于 [Github guide](https://github.com/mtikekar/zathura-tabbed)。

需要安装的程序有 zathura, zathura-pdf-mupdf, libgirara-dev, mupdf, tabbed。这些均可从 apt repository 或者源码编译安装，并不需要设置任何路径。

需要安装的脚本是 [zathura-tabbed](https://raw.githubusercontent.com/mtikekar/zathura-tabbed/master/zathura-tabbed) ，将无后缀名的该文件保存于 "/usr/bin" 文件夹，并使用 `sudo chmod 777 zathura-tabbed` 来赋予权限。至此，在 zsh 中使用 `zathura-tabbed 1.pdf 2.pdf 3.pdf` 即可同时打开三个 pdf 文件，并且都以 tabbed 的形式在一个 zathura 中。需要切换 tab 和搜索选择 tab 可以使用诸如 "ctrl+shift-H","ctrl+t" 或者 "ctrl+[0,1,...,9]" 的快捷键来做到。除了原有的 zathura 操作以外，更多快捷键操作可见于 `man tabbed`。

设置 zathura-tabbed 为 pdf 在 xdg 下的默认打开程序的方法是，编辑出一个 zathura-tabbed 的 desktop，将其保存于 "/usr/share/applications" 路径下。注意需要使用 `sudo chmod +x zathura-tabbed` 命令来赋权。然后使用命令行 `xdg-mime default zathura-tabbed.desktop application/pdf` 来将其设置为 pdf 的默认打开文件。至此，在打开多个 pdf 的情况下，打开其他任意一个 pdf，该 pdf 文件仍将在 zathura-tabbed 中显示。

美中不足：打开相同的 pdf 文件两次，则在 zathura-tabbed 中有两个 tab，仍不具备 filter duplicate files 的功能。根据 [Avoid duplicate tabs](https://github.com/mtikekar/zathura-tabbed/issues/1) 的说明，改动 zathura-tabbed，但并未能如该帖子所述实现该功能。
