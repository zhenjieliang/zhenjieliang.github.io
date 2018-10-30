---
layout: post
title:  "在超算上搭建 R 环境"
date:   2018-09-17 11：21：29 +0800
categories: cs R
---


在深圳超算上安装 R、R 包以及其对系统的依赖文件时，学到了一些如何在没有 sudo 权限以及没有联网的 linux 系统的安装程序和设置的经验。R 及 R 包更为具体的安装指南可见于~/Desktop/HPC 文件夹下 R 的 [pdf1](/assets/R+v3.1.3-compile-install-guide-szsc-v1.5.pdf) 和 [pdf2](/assets/R+v3.5.0-compile-install-guide-szsc_v1.4.pdf) 文档，另附上深圳超算的 [使用说明](/assets/szsc-hpc-tutorials.zip)。

## 安装 R

首先，从源码安装时，可以先使用 `./configure --prefix=/path/where/you/want/to/install/at`，避免默认安装路径下没有写入权限的问题。（在全部超算中，用户都不会有在 usr 或者 etc 等路径下写入的权限）然后再 make 或者是 make install 安装。

安装好之后需要在用户的 $HOME 路径下编辑 .bashrc 文件将这些指定的安装路径加入，例句如下：



```shell
export LD_LIBRARY_PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/zlib-
1.2.7/lib:$ LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/bzip2-

1.0.6/lib:$ LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/xz-

5.2.2/lib:$ LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/pcre-

8.38/lib:$ LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/curl-

7.47.1/lib:$ LD_LIBRARY_PATH
```


其次，可能有些软件需要某些系统依赖或者其他文件的依赖，例如在安装 R 时，则使用以下语句指定 R 的安装路径以及这些依赖文件的查找路径：

```shell
./configure --prefix=/home-yw/users/nsyw231_GJY/R-3.5.0/install 
--enable-R-shlib 

LDFLAGS="-L/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/zlib-1.2.7/lib -

L/home-yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/bzip2-1.0.6/lib -L/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/xz-5.2.2/lib -L/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/pcre-8.38/lib -L/home-
yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/curl-
7.47.1/lib"CPPFLAGS="-I/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/zlib-1.2.7/include -I/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/bzip2-1.0.6/nclude -I/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/xz-5.2.2/include -I/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/pcre-8.38/include -I/home-

yw/users/nsyw211_LZ/soft/R-3.5.0/LIBRARY/curl-7.47.1/include" 

```





其中重要的是 LDFLAGS 和 CPPFLAGS，需要分别指定 lib 和 include 的路径。


make install 之后也需要把 R 的 bin 路径加入 .bashrc 文件中：

```shell
export PATH=/home-yw/users/nsyw211_LZ/soft/R-3.5.0/R-3.5.0/install /bin:$PATH 
```



至此，安装 R 成功。下面需要看如何安装 R 包。


## 安装 R 包

安装 R 包首先需要下载包和依赖包的源码，生成包的索引以及源码安装。在不考虑系统依赖的情况下，可以在 R 中使用以下语句安装完成。


```r
setPackages <- function(packs){packages <- 
unlist(tools::package_dependencies(packs, available.packages(),
which=c("Depends", "Imports"), recursive=TRUE)
  )
  packages <- union(packs, packages)
  packages
}

raw_packages <- c("packages","you","want","to","download")
packages <- getPackages(raw_packages)

download.packages(packages, destdir="/path/you/want/to/store/in/",
                  type="source")
```


把源码全部下载之后，使用以下函数建立该路径下全部源码安装包的索引

```r
library(tools)
write_PACKAGES("/path/to/packages/")
```



最后，使用以下函数将全部源码安装包安装好

```r
install.packages(raw_packages, contriburl="file:///path/to/packages/")
```


注意，file: 后面是三个 /

参考网页：

[only download sources of a package and all dependencies](https://stackoverflow.com/questions/6281322/only-download-sources-of-a-package-and-all-dependencies)

[offline install of r package and dependencies](https://stackoverflow.com/questions/10807804/offline-install-of-r-package-and-dependencies)


当某个 R 包需要系统依赖，例如头文件时（安装 nloptr 包时，需要用到系统中的 nlopt.h 文件），则需要首先安装依赖，并将该依赖文件安装的路径写入 R 的配置中，否则按照 R 的默认查找路径将出现没有找到头文件的错误。

通过生成 $HOME/.R/Makevars 文件，即可修改 R 的默认查找路径。该 Makevars 文件可以加入相关的 LDFLAGS 和 CPPFLAGS 等路径信息。关于 Makevars 更详细的信息可以查阅 [网页](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Using-Makevars)。


## 总结

1. 安装是可以通过 `configure --prefix=` 来指定安装路径

2. 可以通过 configure LDFLAGS 和 CPPFLAGS 来指定依赖的查找路径

3. 某个程序下包的安装的依赖的查找顺序，可以通过 `$HOME/.X/configurefile` 来指定 LDFLAGS 和 CPPFLAGS 等路径

4. 某个 x 程序具体的配置文件一般在 `/etc/x` 路径下，或者针对当前用户也可以在 `$HOME/.x/` 路径下进行配置设置。

