---
layout: post
title:  "使用 jekyll 编写 Github 博客"
date:   2017-06-23 17:40:33 +0800
categories: jekyll update
---
前提：了解 Git 命令。
操作系统：Ubuntu 16.04 LTS, Git, jekyll 3.1.6

要点：

* 使用 `jekyll 3.5.0` 来生成新博客模板时会报错，而 `jekyll 3.1.6` 则不会。
* `git push` 时应该只在 `master` 下，不应该到其他的 branch。
* 记得修改文件 `_config.yml` 中的 url。
* 每次修改后应该在本地使用 `jekyll serve` 再 `commit`，然后再上传到 Github 上。否则网页无法更新。
* 最好使用 ssh 密钥来传送文件到 Github，不然每次输入密码是很麻烦的事情。

未完成的工作：

* 域名绑定
* jekyll 的默认网址问题
* 主题和格式细节需要修改

参考资料如下：

[用 Jekyll 搭建的 Github Pages 个人博客](http://www.jianshu.com/p/88c9e72978b4)

[Quick-start guide](https://jekyllrb.com/docs/quickstart/)

[github 设置添加 SSH](https://www.cnblogs.com/ayseeing/p/3572582.html)

[域名绑定](https://help.github.com/articles/setting-up-an-apex-domain/)


