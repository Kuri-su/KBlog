!!! UNDONE

# Transport

[TOC]

Transport 提供 两个方式, 一个 是 Dial (连接), 另一个是 Listen (监听), 一个面向 Client , 一个面向 Server, Dial 返回的是 Client 也就是 Socket 对象, Listener 返回的是 Listener 对象, 

Socket 的核心方法是 Recv 和 Send , 分别用于接收和 发送, Listener 核心方法是 Accept , 用于接受,不过入参是 关于 Socket 的 闭包.

接着在 Transport 的 实现中, 通常 各个接口的实现会带上 对应后缀, 以 HTTP Transport 为例,  Client 是 `httpTransportClient Struct`, struct 是 `httpTransportSocket struct` 