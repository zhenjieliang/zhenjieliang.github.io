---
layout: post
title:  "Reproducible Python"
date:   2018-01-09 22:25:37 +0800
categories: CS Tools
---

轻便版：python + markdown

专业版：python + latex

轻便版的实现方法有使用 `md`、 `rmd` 和 `pmd` 三种。其中 `rmd` 的设置示例如下：

```R

​```{r setup, include=FALSE}
library(knitr)
knitr::opts_chunk$set(engine.path = list(python = '/usr/bin/python2.7'))
​```

​```{python}
print(1 > 2)
​```
```

`rmd` 可以使用 Typora 编辑，然后在 Rstudio 里运行。

`pmd` 则使用 pweave，在 Atom 编辑并运行。

`md` 则是使用 stitch 来运行并保存为 HTML 格式。命令 `stitch tidy.md -o output4.html`。



专业版同样使用 Rnw 和其他版本。

Rnw 的设置示例如下：

```R
<<setup, include=FALSE, cache=FALSE>>=
library(knitr)
# set global chunk options
opts_chunk$set(echo = TRUE,message=FALSE)
options(formatR.arrow=TRUE,width=90)
@

<<hi-python, engine.path="/home/liangzhenjie/anaconda3/bin/python">>=
x = 'hello, python world!'
print(x)
@
```

写完 Rnw，可以先在 Rstudio 里生成 pdf，这一过程将附带生成 tex 文件。再使用 latex2html 或者 htlatex 来将 tex 转化为 html。

```shell
htlatex source.tex
latex2html source.tex
```

