+++
date = "2020-08-14"
title = "Goweb Benchmark Testing Tips"
slug = "goweb-stress-testing-tips-u2xxa"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "这篇文章讨论范围仅限于 `Golang webApp` 单服务压测, 而不涉及链路压测等场景"
+++
> 这篇文章讨论范围仅限于 `Golang webApp` 单服务压测, 而不涉及链路压测等场景

## 压测的目的

在讲 压测的指标之前,我们需要先明确一下压测的目的, 压测不是压的出最高的 QPS 就OK ... 我们还需要关注 Web App 在 **各种压力下, 对应的 指标表现** . 同时,  利用压测找出 App 或 框架 **最适合的 压力范围** 也是 非常重要的报告内容. 基于这些 压测数据 和 报告, 我们就能更好的 选型 和 资源调配.

## 指标

单服务压测时除了我们最关注的 QPS 以外, 还有 进程的 `CPU` / `MEM`, `HTTP 状态码`, `Timeout 状态`, `响应时延`, `网卡流量` 这几个指标需要关注, 下面笔者一个一个指标来说.

### QPS

这个指标 没啥好说的, 就是 每秒处理请求数, 属于客观指标, 对于 Go Web 程序来讲, 主要影响 QPS 的因素在于 CPU 和 bandwidth.

### CPU && 响应时延 && Timeout

在讲述 `CPU`/`响应时延`/`Timeout` 之前, 我们简单的做一个小的实验来了解一下现象.

假设 一个 `Go Web App` 在  50 并发时 将处于 最合适的 压力范围, CPU 使用率稳定在 95-100%, 响应时延处于 7-10 ms, 没有响应 Timeout 时的 QPS 是 10k.

当我们把 并发数加到 100 并发时, 我们会发现 QPS 不会继续上升, 仍然保持 10k 上下, 但响应时延会上升, 例如 20ms 左右

我们接着把 并发量往上加, 加到1000 并发的时候, 我们发现 QPS 仍然在 10k 上下, 但响应时延已经疯涨到 300ms 甚至部分请求的响应时延已经上涨到 1s , 并伴随 少量 请求 Timeout. 

实验结论, 对于 GoWeb App , 随着并发数的上涨, 我们的 QPS 也不断上涨,而响应时延不会跟随上涨, 直到到达 该程序的 最合适的压力范围. 在达到最合适的压力范围后, 继续提升 并发量, QPS 不会接着上涨, 而 响应时延会逐步上涨, 在最后极端状况下, 可能会伴随 请求 Timeout.

那么为什么会这样呢? 我们需要简单了解一下 Golang Http Server 的运行模型.

在 标准库 `net/http` 的 http server 实现中, 每接受到一个请求就会新开一个 Goroutine 协程来处理. 那么当极大的并发涌入 的时候, 此时 http server 会开巨量的 Goroutine 来处理, 但 Goroutine 不是 操作系统 级别的线程,它没有办法直接从 CPU 分到时间片, 他的执行完全由 golang 本身的 协程调度器 来进行调度, 当 调度器 没有分配 时间片给 协程的时候, 此时的协程只是一段存在内存里的 代码上下文而已, 不会有任何多余的损耗. 

你可以看着下面这个图, 由于计算力有限, CPU 的计算力就相当于一个 固定大小的窗口,  CPU 的计算力窗口 在 由 Goroutine 组成的长条上滑动来完成计算范围内的 Goroutine 计算任务.

![](https://github.com/Kuri-su/KBlog/blob/master/assets/GowebCpuWindow.png?raw=true) 

当 Groutine 的长条 过长, 导致长条后面的 Goroutine 太久没有被分到时间片计算, 这将导致 Client 端直接 Timeout , 这也就能讲通上面为什么 并发量 持续提升, 而 QPS 不变, 请求时延 和 Timeout 请求量 跟随并发量持续提升.

### MEM

通常 Goweb 程序 在运行过程中占用的  mem 是基本不会有太大或者太急速的上涨 (特殊情况除外), 如果发现 mem 占用 在 压测过程中持续上涨, 建议 用 pprof debug 一下是不是有哪里 内存泄漏了.... [pprof 的 guide 请点这里](https://kuricat.com/articles/golang-pprof-guide-sw40b) 

### 网卡流量

网卡流量是压测中, 非常容易被忽略的点. 经常会发现无论怎么调优, QPS 就是压不上去, 最后发现是 网卡的  `上行/下行` `流量/包` 到达极限.

### HTTP 状态码

在压测过程中,我们碰到最多的异常状态码通常是 499 和 5xx 系列, 

* 499
  * 客户端取消
* 5xx
  * 500 服务端程序报错
  * 503 按照定义是 服务过载的意思, 但是 根据通常的 Goweb 的运行模型 , 在过载的时候报的是 Timeout 而不是 503 状态码, 但这样是不正确的反馈, 通常会修改 Goweb 的 Goroutine Pool 或者 在链路做 QOS 
  * 502 && 504  或许是 网关出错

## 压测工具

最后提一下压测工具, 个人用的比较多的是 [wrk](https://github.com/wg/wrk), 不过目前的 压测工具基本类似, 都是指定 并发数, 和压测时间, 来获取到 QPS.

不过也有另一种 压测工具, 可以自己逐步推高 并发数, 在 并发数停滞 或者 响应时延 开始提升 或者 出现 Timeout 的时候停下来.  