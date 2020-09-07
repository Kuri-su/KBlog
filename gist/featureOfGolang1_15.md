


[TOC]

这次 Go 1.15 的版本升级没有带来太多的改变, 保持了对 Go 1 的兼容性. Feature 主要集中在 `Go Runtime` 以及 `编译器` 和 `连接器` 上, 对于发行平台方面, 我们只关注 Linux Amd64 的更改 . 下面对修改点一一列举

## Go Tools

### GOPROXY

现在 GOPROXY 支持 使用 `,` 或者 `|`  来设置多个 Proxy Server URL, 这样的好处在于, 当第一个 Proxy Server 不可用的时候, 将继续尝试第二个和第三个 Proxy Server, 直到尝试完所有.

```shell
# , side
GOPROXY=http://goproxy.cn,direct

# | side
GOPROXY=http://goproxy.cn|direct
```

 二者的不同在于,当你使用 `,` 的时候, 只有在碰到 404 或者 410 返回码 的时候, 才会接着往后尝试, 否则直接报错. 而 `|` 则会在任何错误时 , 都继续向后尝试. 

### GOMODCACHE

现在可以修改 GOMODCACHE 的位置, 默认值为 `GOPATH[0]/pkg/mod`

## Go Vet

Go Vet 是 go tools 里的 bug 和 容易出错的代码结构 检查工具. 不过 用 IDE 的话 (例如 IDEA 或者 Goland), IDE 会做到类似于 GoVet 的功能, 所以有需要的话可以前往 [此处](https://golang.org/doc/go1.15#vet)观看详细的 修改.  不过改动也不多, 加了两种 检查类型.

## Runtime (运行时)

1. Panic 对于 指针类型 的 值, 将会打印具体的值, 而不是 打印一个地址
2. 在 类 Unix 系统中, 如果 通过 Kill 来传递 `SIGSEGV (11 无效内存访问)`, `SIGBUS (07 非法内存访问)`, `SIGFPE (13 管道破损)` 信号, 而 信号又没有被 `os.signal.Notify` 捕获的话, Go 现在可以 在 崩溃时, 可靠的使用 堆栈跟踪, 而在之前的版本里, 这个时候得到的堆栈是不可靠的.
3. 优化在多核场景下的小对象分配效率, 即便在最坏情况下的分配延迟也有所降低
4. 将 小的 整数值 转换为 Interface 类型 将不再导致分配
5. Non-blocking receives on closed channels now perform as well as non-blocking receives on open channels. (这句没看懂....)

## Compiler (编译器)

1. unsafe 包的 pointer 类型 在多次转换时, 效率更高
2. 编译后的 二进制包更小, 比 1.14 有大概 5% 优化
3. 针对 Intel 的 Bug `SKX102` 做了修改
4. 针对 CPU 的 Spectre(幽灵) 漏洞, 提供了 ` -spectre`  编译参数来进行缓解
5. 在编译时, 对所有 注释中 `//go:`  声明的无意义指令将会报错, 在以前的版本里这种错误的 `//go:` 将会忽略, 通常在 写 `//go:generate` 的时候会比较有感觉
6. The compiler's `-json` optimization logging now reports large (>= 128 byte) copies and includes explanations of escape analysis decisions. (没用过..不懂啥意思..)

## Linker (连接器)

1. 优化了 Linker 的 资源使用, 并优化了 Linker 本身代码的 健壮性 和 可维护性
2. 在 类Unix 系统上, 生成 ELF 的链接速度快了 20%左右, 平均内存使用减少了 30%左右 . 在其他的操作系统和架构上, Linker 的表现也有不小的进步 
3. Go 1.15 生成的 目标文件(object file) 比 1.14 稍大, 这得益于 目标文件 的结构优化 : ). (也就是 类 Unix 系统上的 ELF)
4. The linker now defaults to internal linking mode for `-buildmode=pie` on `linux/amd64` and `linux/arm64`, so these configurations no longer require a C linker. External linking mode (which was the default in Go 1.14 for `-buildmode=pie`) can still be requested with `-ldflags=-linkmode=external` flag. (没看懂...)

### Other

1.  `go test` 命令的 `-timeout` 参数的行为略有修改, 由于没有用过这个参数所以这里不做介绍, 有兴趣可以自己看下面原文
> Changing the `-timeout` flag now invalidates cached test results. A cached result for a test run with a long timeout will no longer count as passing when `go` `test` is re-invoked with a short one.
2. `golang tools` 中的 `obkdump` 工具支持 GUN 汇编语法, 只要加上 -gnu 参数 (不过其实没用过, 看起来很 power 的样子, 之后试试)
3. 新增 `time/tzdata` 包, 以解决对 运行机器的 时区数据库的依赖. `import _ "time/tzdata"` , 或者你也可以在编译时, 添加 `-tags timetzdata` 参数, 来引入这个包, 不过无论你是 用 import 的形式还是 编译时加参数的形式, 都会让编译后的 bin 文件的大小膨胀 800KB 左右.(也就是给你编译进去了 XD)
4. CGO 又新增了个特性, 有兴趣可以点 [这里](https://golang.org/doc/go1.15#cgo)看
5. 以及对于其他标准库, 有一些 细节上的修改, 你可以点击 [这里查看](https://golang.org/doc/go1.15#minor_library_changes), 这里举几个笔者比较关注的
   * Context 现在不允许使用nil 来创建, 在 `WithValue`,`WithDeadline`, `WithCancel` 中这样用将会触发 `panic`
   * SQL 新增了 `DB.SetConnMaxIdleTime ` 方法, 用来设置 Conn pool 中闲置连接的清除时间 

## Ref

1. https://golang.org/doc/go1.15