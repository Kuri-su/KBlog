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

---

## Stream

Steam 相对于 RPC 的区别？

## shutdown

使用 ctx 完成 shutdown 退出

## Sharding

shard 通过 Client Wrapper 根据 X-From-User 来设置 请求用户亲和性

## Secure

transport 开启加密传输

## Round Robin

？ 循环 什么

## Redirect

转发？

## Proxy sidecar

## Mocking

## Metadata

## Even

Event 参考 CloudEvent 和 敖小剑 的这两篇博文

* https://skyao.io/post/202004-building-event-driven-cloud-applications-and-services/
* https://skyao.io/talk/202007-microservice-avoiding-distributed-monoliths/



```
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20191225085741-46da811c3de3/go.mod h1:6D597tz0Za2JBrD/7qgb8dLDWoSZKrAkVLNa+C1s+Hg=
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20200923021755-d09e7500d283/go.mod h1:mZfjNDw1JuaNI2FLKffeI0MKThIKYvkh/qDsVtDMduE=
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20201015081037-2fb85714209b/go.mod h1:jrRF9DwPo+FmG/9QAM4GpY5CYIxSHFoxQh9eoS3bl5E=
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20201015091624-13775fc0eb45/go.mod h1:imardCvvx3ey+jIr29jjgqS8uT3AOOiCJtxYY46502A=
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20201015093255-6b9eb232f772 h1:njIU9bHeGsY1mNdVPy17uow4n7YpLbXgTbgAWuQS9CA=
gitlab.xinhulu.com/platform/GoPlatform v0.0.0-20201015093255-6b9eb232f772/go.mod h1:Qq3d0DlNjjmwQdgqOG7aav0dccPcpuUWJFoW63SJkW8=
```