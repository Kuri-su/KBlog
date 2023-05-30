+++
date = "2019-08-26"
title = "Golang flag usage 自定义"
slug = "golang-flag-usage-erpxr"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "直接进入正题, golang 编译的二进制文件的 help 输出实质上 是调用的 flag.Usage() 方法, 而该方法是一个变量, 接受一个闭包, 源码如下"
+++

直接进入正题, golang 编译的二进制文件的 help 输出实质上 是调用的 flag.Usage() 方法, 而该方法是一个变量, 接受一个闭包, 源码如下
```go
// /usr/local/go/src/flag/flag.go:580
var Usage = func() {
	fmt.Fprintf(CommandLine.Output(), "Usage of %s:\n", os.Args[0])
	PrintDefaults()
}
```

所以你可以直接覆盖掉 flag的 Usage 方法来修改, 例如这样
```go
package main

import (
	"flag"
    "fmt"
)

func init(){
    flag.Usage = usage
    flag.Parse()
}

func usage(){
  fmt.Print("nginx version v1.12")
}

func main(){}
```

然后直接 build 接着运行
```bash
$ go build a.go
$ ./a -h
```

即可看到输出
```
nginx version v1.12
```


-------
一开始不知道这个方法是个闭包,然后疯狂的想怎么曲线救国, 甚至想自己实现 flag.CommandLine 结构体来替掉 CommandLine.PrintDefaults() 方法, 但是一直无果, 最后在google 上苦苦搜寻,发现原来可以这样 :joy: :joy: :joy: