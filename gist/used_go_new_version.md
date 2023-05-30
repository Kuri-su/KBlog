+++
date = "2019-08-28"
title = "如何优雅的体验 golang 的新版本"
slug = "golang-qduw9"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

> ref:
>
> https://www.evanlin.com/til-go-binary-install/

因为想体验 go 1.13 的 GOPRIVATE功能, 但又不想自己去麻烦的编译或者下载源代码包, 而找到了这篇文章, 所以转载做个备份, 下文在原文的基础上有所修改.

----------

你可以使用 `go get` 指令下载任意版本的 go安装程序
```shell
go get golang.org/dl/go1.13rc1
```
这个 任意版本的 go安装程序 将会下载在你的 $GOBIN 目录下, 以 `go1.13rc1` 为例, 你可以使用如下命令下载对应版本的完整 Go 可执行文件

```shell
go1.13rc1 download
```

如果你的 Terminal 无法找到 go1.13rc1 这个命令, 那么你可能需要设置你的 GOPATH 路径, 通常 `go get` 获取的二进制文件会存放在 $GOPATH/bin 下.

然后你就可以开始尝鲜 go的新版本了.

```shell
$ go1.13rc1 version
go version go1.13rc1 linux/amd64
```



