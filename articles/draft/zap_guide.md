# uber-go/zap guide

<!--uber-go/zap 初见指南-->

在 Golang 中由非常多的 日志库, 像 `uber-go/zap`,`rs/zerolog`, `sirupsen/logrus` , `google/glog`, `kubernetes/klog`,`op/go-logging`, `alecthomas/log4go`

zap 采用 `结构化`的 日志格式, 而不是将所有的消息放到 `消息体`里. 所以对应的, Zap 的日志有两个概念, `字段`和 `消息` , 这个在 Zap 中是相当重要的部分. 

1. 字段用来结构化输出错误相关的上下文环境
2. 消息则简明扼要的阐述错误本身

举个例子, 







## Ref
> [在 Github 中最受欢迎的 Go 日志库集合 https://www.ctolib.com/topics-123640.html]https://www.ctolib.com/topics-123640.html
>
> 