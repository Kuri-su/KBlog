+++
date = "2019-09-09"
title = "Shell if 参数笔记"
slug = "shell-if-phciv"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

文件:

* -b 当 file 存在并且是 块文件时, 返回 true
* -c 当 file 存在并且是 字符文件时, 返回 true
* **-d 当 file 存在并且是 目录时, 返回 true**
* **-e 当 file 存在时, 返回 true**
* **-f 当 file 存在并且是 普通文件时, 返回 true**
* -g 当 file 存在,并且设置了 SGID 时, 返回 true (SGID 是 Set Group ID 的意思)
* -h 当 file 存在, 并且是一个 符号链接文件时, 返回 true
* i
* -k 当 file 存在, 并且设置了sticky 
* **-L 当 file 存在, 并且是一个符号连接时, 返回 true**

* **-x 当file 存在,并且具有可执行权限**
* -S 当 file 存在, 并且是一个 socket 文件, 返回 true


比较:
* -n 非空时, 返回 true
* -z 为空时, 返回 true


```shell
if [ -n "" ] ; then
    echo 1
fi
```
