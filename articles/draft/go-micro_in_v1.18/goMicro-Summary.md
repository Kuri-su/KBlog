[TOC]

// note: 现在只有 语句段落,  后面再拼成文章



在 了解 `micro/go-micro` 框架结构之前, 我们首先需要了解他的功能, 除了基础的 服务发现 和 RPC 互调 功能外, `micro/go-micro` 还有别的功能

-----

### metadata

---

### Broker

daemon

pub-sub 的异步调用, 是异步获取? 还是同步获取? 规则是怎样的?

---

### Proxy?

协议转换, 支援 异步请求, 和 MicroApi 的区别?

---

## Wrapper

wrapper 有两种, 一种是  client 的, 一种是 server 的, 但都建议在 micro.NewService 中传入对应的 闭包参数, Client 是传入 `micro.WrapClient(c client.Wrapper)`  client.Wrapper 是这样的 `func(Client) Client`  闭包, server 部分类似, 换个名字 , 传入 `micro.WrapHandler(server.HandlerWrapper)` server.HandlerWrapper 是 这样的闭包 `func(HandlerFunc) HandlerFunc`

---

## Web

Micro 提供一个 自带 服务注册 的 简单 web 服务

---

## WaitGroup

演示 如何使用 WaitGroup 来完成 一个优雅结束

---

## Tunnel

Tunnel 感觉类似于 Proxy, 还待看完 Transport 的部分, 然后细看他的 WithTunnel 方法

---

### Pubsub?

支持 Event 传递

