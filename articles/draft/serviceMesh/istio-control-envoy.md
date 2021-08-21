# Istio control envoy (How to control envoy of Istio)

[TOC]

## 缘起

在某些场景下, Envoy sidecar 的 MEM 会高达 80Mbyte, 和 8 Mbyte 的 Go 服务放到一起, 颇有种 sidecar 快要被压塌的感觉. 遂开始想优化 istio 中 envoy 的 MEM 占用.

## Istio 结构 以及 如何与 Envoy 交互

在目前最新的 Istio (Version: // TODO) 中, 三个核心组件已经合并成一个单独的  Istiod 文件. `Pilot` 依旧存在, 主要负责收集/生成/下发 配置, `Citadel` 负责管理密钥 和 证书, `Galley` 负责验证提交的 yaml 文件, 管理 Galley 中的配置.

可以看到这里会与 Envoy (Data Plane) 交互的只有 Pilot, 

![](https://www.servicemesher.com/istio-handbook/images/pilot-arch.png)



// TODO 更加详细和 清晰的理解 Envoy Api 和 Envoy proxy 中间的传输

// TODO 为什么 Envoy Proxy 会因为 服务发现条数的增多而 内存增大.

// TODO 按道理来讲,  Service 在发出 数据包的时候, 应该已经在 L4 的位置写了 SIP, Envoy 自己做服务发现, 然后丢到对面的另一个 Envoy 上的时候, 是否会修改这个 SIP , 如果没有修改这个 SIP , 包是否会再次路由到 另一个 节点上? 