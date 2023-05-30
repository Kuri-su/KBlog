+++
date = "2019-05-23"
title = "进程/线程/Goroutine 的区别"
slug = "goroutine-blveh"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

## 进程

* 进程是程序执行的一个实例, 担当分担系统资源的实体.
* 进程是分配资源的基本单位，也是我们说的隔离。线程作为独立运行和独立调度的基本单位
* 进程切换只发生在内核态

## 线程(用户级线程/内核级线程)

* 线程是进程的一个执行流, 线程是操作系统能够进行运算调度的最小单位
* 对于进程和线程,都是有内核进行调度,有 CPU 时间片的概念, 进行抢占式调度

* 线程可以在启动前设置栈的大小,启动后,线程的栈大小就固定了
* 内核由系统内核进行调度, 系统为了实现并发,会不断地切换线程执行, 由此会带来线程的上下文切换.

## 协程

* Goroutine 是协程的go语言实现
* 协程(用户态线程)是对内核透明的, 也就是系统完全不知道有协程的存在, 完全由用户自己的程序进行调度
* 在栈大小分配方便,且每个协程占用的默认占用内存很小,只有 `2kb` ,而线程需要 `8mb`,相较于线程,因为协程是对内核透明的,所以栈空间大小可以按需增大减小
* 在调度方面, 相较于线程,go 有自己的一套运行时调度系统,go的调度器类似于内核调度器, 而他不需要进行内核的上下文切换, 所以重新调度一个 Goroutine 的开销会小于重新调度线程的开销


**协程与线程主要区别是它将不再被内核调度，而是交给了程序自己而线程是将自己交给内核调度，所以也不难理解golang中调度器的存在**

~~面试翻车现场~~

~~左抄右抄系列~~

```
> via:
https://www.infoq.cn/article/a-million-go-routines-but-only-1000-java-threads
https://studygolang.com/articles/10112
https://www.cnblogs.com/shenguanpu/archive/2013/05/05/3060616.html
https://blog.csdn.net/feng973/article/details/79494402
https://zhongwuzw.github.io/2018/01/30/Goroutines-vs-%E5%A4%9A%E7%BA%BF%E7%A8%8B/
```