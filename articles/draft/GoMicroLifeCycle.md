# GoMicro 生命周期

## 初始化

在引用了 GoMicro 后, 各组件的用 `var` 声明的 Default 的 变量都会最初被初始化, 例如在 `server/server.go` 中声明的 `DefaultServer = newRpcServer()` 将调用 `server/rpc_server.go:newRpcServer()` 方法创建一个默认的

