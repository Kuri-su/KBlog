!!! UNDONE

# Server

[TOC]

## NewRpcServer 方法

newRpcServer 方法, 里面除了 newOption 之外, 还 newRpcRouter, 这个 Router 是 http 实现的 rpcServer 专有, 

```go
// rpcRouter encapsulates functions that become a server.Router
type rpcRouter struct {
	// handler
	h func(ctx context.Context, req Request, rsp interface{}) error
	// subscript message process
	m func(context.Context, Message) error
}

func (r rpcRouter) ProcessMessage(ctx context.Context, msg Message) error {
	return r.m(ctx, msg)
}

func (r rpcRouter) ServeRequest(ctx context.Context, req Request, rsp Response) error {
	return r.h(ctx, req, rsp)
}
```

## 启动流程

1. 启动 Transport 监听 Address, 默认 端口 `:0`,
2. 打开 Broker 的 连接, // TODO 暂时不知道连接到哪里
3. 进行注册检查(registerCheck) , 不过默认的 注册检查为空
4. 对 Registry 进行服务注册
5. 将请求的处理方法(server.ServeConn) 注册给 Transport , 
6. 启动 Registry 的定期维护程序

