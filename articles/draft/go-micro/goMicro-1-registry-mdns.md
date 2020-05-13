# mDNS

> Go-Micro Registry  part

## mDNS

`multicast DNS` 翻译成中文变成 `组播DNS` 或者 `多播DNS` , 可以理解成在在没有传统 DNS 服务器 下使局域网内的主机互相发现和通信的注册中心. mDNS 和 传统dns 的不通电在于, 他不会去递归请求 DNS, 而只是在 局域网内广播.

Go-Micro 框架是在 `v0.21.0` 将 mDNS 作为 默认的 Registry 来使用, 在此之前, Consul 则是 Go-Micro 的默认 Registry. 相比 Consul , mDNS 有两个特点, 

1. 零依赖, Go-Micro 的作者 `asim` fork 了一份 mDNS 的 Go 实现作为 Go-Micro 默认使用的 mDNS 实现, 这样在测试运行的时候, 直接可以由  `mdns_registry.go` 拉起 `mDNS Server`, 而不需要像此前的 Consul 那样, 还需要额外安装 Consul 并启动 Consul 服务. 
2. mDNS 相较于传统 DNS 服务器 , 基本就是一个 `内网 DNS` , 不会递归查询, 直接就是内网注册, 非常契合 `Go-Micro` 默认dev 的local 测试场景. 并且 mDNS 也支持多节点.

### 启动 mDNS 时机

`mdns_register` 会在被调用 Register 方法的时候, 去调用 `github.com/micro/mdns` 的 `NewServer` 方法

## Interface

Registry Interface 要求了 Registry 必须实现这些接口.

```go
// The registry provides an interface for service discovery
// and an abstraction over varying implementations
// {consul, etcd, zookeeper, ...}
type Registry interface {
    // 初始化
    Init(...Option) error
    // 获取 options
    Options() Options
    // 注册服务
    Register(*Service, ...RegisterOption) error
    // 取消服务注册
    Deregister(*Service) error
    // 获取服务
    GetService(string) ([]*Service, error)
    // 获取全部服务
    ListServices() ([]*Service, error)
    // TODO:: Unknown
    Watch(...WatchOption) (Watcher, error)
    // 获取 Registry 类型
    String() string
}
```

可以看到 Interface 规定的 Registry 功能主要是 

* 注册和取消注册服务
* 获取服务
* 以及 Watch



ref: 

> [什么是 mDNS 组播 DNS 多播 DNS ？](https://www.logcg.com/archives/972.html)