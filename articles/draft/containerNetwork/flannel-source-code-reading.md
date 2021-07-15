# flannel 源码阅读

[TOC]

flannel 的源码分为两个部分, 

* Services 部分, 负责 子网划分 和 数据包转发: https://github.com/flannel-io/flannel 
  * 这是个 DaemonSet 服务, 运行在 K8s 中
* CNI Plugin 部分, 负责 容器 IP 地址的申请和释放: https://github.com/flannel-io/cni-plugin , 不过实际的 IP 分配过程不是由 flannel 完成, 而是由 kubernetes 的 nodeIPAM controller 完成. flannel 的 CNI plugin 仅仅负责传递 IP 分配的限制条件, 例如 分配的IP 范围, 等.
  * 这是个 二进制文件, 供 CNI 调用



---

## Struction

Services 部分结构上分为四块

* Subnet manager
* backend 方案们
* Main.go (配置加载和启动器)
* helper 函数库们

### Subnet manager (子网 管理器)

subnet manager 是管理程序, 负责管理 IP 的申请和分配 , Manager 的 Interface 如下, 从 Interface 上看起来类似于 DHCP 的功能,申请和续期 IP, 它会依赖 local etcd 或者 kubernetes 的 etcd 来集中管理 IP 分配情况(在 local etcd 的 模式下会有 IP 续期, 在 Kubernetes 的模式 下没有)

```go
type Manager interface {
	GetNetworkConfig(ctx context.Context) (*Config, error)
	AcquireLease(ctx context.Context, attrs *LeaseAttrs) (*Lease, error)
	RenewLease(ctx context.Context, lease *Lease) error  // only local etcd
	WatchLease(ctx context.Context, sn ip.IP4Net, cursor interface{}) (LeaseWatchResult, error)
	WatchLeases(ctx context.Context, cursor interface{}) (LeaseWatchResult, error)

	Name() string
}
```

Subnet manager 负责管理子网 以及 初始化虚拟网络, 

