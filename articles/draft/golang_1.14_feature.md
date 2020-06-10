# Golang 1.14 特性

[TOC]

这次 Go 1.14 的版本升级没有带来太多的改变, 主要是保持 Go 1 的兼容性, 不过 令人兴奋的改动也是有的, 

## 允许 在 Interface 的定义中, 嵌入的 Interface 的方法冲突

Go 1.14 开始允许相同签名的方法可以内嵌入一个接口中。

中文看着估计得绕晕, 这里直接看代码

```go
type A interface {
    a() error
    b() error
}

type B interface {
    a() error
    c() error
}

type AB interface{
    A
    B
}
```

如果在 1.13 前的代码中, 这样是会报错的, 因为 A.a 和 B.a 在 AB Interface 中冲突, 但在 1.14 中将支持. 但是请注意, 同名方法的签名必须相同

## defer 性能改进

Go1.14 提高了 defer 的大多数用法的性能，几乎 0 开销

## goroutine 支持异步抢占

在 Go 1.14 之前的版本中, 调度器会在 如下几种情况中 使 Goroutine 让出 CPU: 

* 函数调用
* sleep 或者其他阻塞状态(比如IO)
* Goroutine 主动让出

但是在以前一些面试题里就经常问这种边缘情况: 

```go
import (
	"runtime"
	"time"
)

func main() {
	runtime.GOMAXPROCS(1)
	go func() { //创建一个 goroutine 并挂起
		for {
		}
	}()
    
	time.Sleep(time.Millisecond) //main goroutine 优先调用了 休眠
	println("OK")
}
```

这种情况下由于只有一个 CPU 线程在处理, 并且没有时机供 调度器 调度 Goroutine , 所以这一段代码永远不会 输出 OK, 而在 1.14 中这点得到了改进.官网描述: 

> Goroutines are now asynchronously preemptible. As a result, loops without function calls no longer potentially deadlock the scheduler or significantly delay garbage collection.
>
> Goroutine 现在可以异步抢占。 结果，没有函数调用的循环不再能致使调度程序死锁或影响 GC。

## time.Timer 定时器性能大幅提升

在 Go 1.10 之前的版本中，Go 语言使用 1 个全局的四叉小顶堆维护所有的 timer。由 time.after，time.Tick，net.Conn.SetDeadline 和 friends 所使用的内部计时器效率更高，锁争用更少，上下文切换更少。这是一项性能改进，不会引起任何用户可见的更改。

> Internal timers, used by [`time.After`](https://golang.org/pkg/time/#After), [`time.Tick`](https://golang.org/pkg/time/#Tick), [`net.Conn.SetDeadline`](https://golang.org/pkg/net/#Conn), and friends, are more efficient, with less lock contention and fewer context switches. This is a performance improvement that should not cause any user visible changes.

## Go 工具链

1. incompatible versions：如果模块的最新版本包含 go.mod 文件，则除非明确要求或已经要求该版本，否则 go get 将不再升级到该模块的不兼容主要版本。
   * 例子: https://github.com/kubernetes/kubernetes/blob/master/go.mod
   * 例子: https://blog.cyeam.com/go/2019/03/12/go-version
2. go.mod 文件维护：除了 `go mod tidy` 之外的 go 命令不再删除 require 指令，该指令指定了间接依赖版本，该版本已由主模块的其他依赖项隐含。除了 `go mod tidy` 之外的 go 命令不再编辑 go.mod 文件，如果更改只是修饰性的。
3. go mod 支持 SVN 仓库
4. go test -v 现在将 t.Log 输出流式传输，而不是在所有测试数据结束时输出。

## Ref

> https://golang.org/doc/go1.14
>
> https://juejin.im/post/5e5fca5551882548fd306950