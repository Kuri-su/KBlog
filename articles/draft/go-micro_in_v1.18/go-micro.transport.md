!!! UNDONE

# Transport

[TOC]

Transport 提供 两个方式, 一个 是 Dial (连接), 另一个是 Listen (监听), 一个面向 Client , 一个面向 Server, Dial 返回的是 Client 对象, Listener 返回的是 Listener 对象, 

// to section 2

Socket 的核心方法是 Recv 和 Send , 分别用于接收和 发送, Listener 核心方法是 Accept , 用于接受,不过入参是 关于 Socket 的 闭包.

接着在 Transport 的 实现中, 通常 各个接口的实现会带上 对应后缀, 以 HTTP Transport 为例,  Client 是 `httpTransportClient Struct`, struct 是 `httpTransportSocket struct` 

---

[section 2]:  Transport 以 HttpTransport 为例, 有三个结构体, 

* httpTransportClient
* httpTransportSocket
* httpTransportListener

其中 httpTransportClient 结构体是给 Client 用的, 而 httpTransportListener 是给 server 用的, httpTransportClient 和 httpTransportSocket 结构体都实现了 Transport.Socket interface, 都有 Recv 和 Send 方法, 但是区别在于 ,httpTransportClient 用于 Client 接受和发送消息, httpTransportSocket 作为每一条请求的载体, 传入 Server 通过 Listener.Accept 方法注册的闭包上, 