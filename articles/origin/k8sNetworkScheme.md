{"title": "Kubernetes network scheme","description": "kubernetes 组网方案","category": "cloudnative","tag": ["docker","cloudnative","network"],"page_image": "/assets/k8sNetworkScheme-00-header.png"}

# Kubernetes network scheme

> * 因为笔者对 计算机网络 认识浅薄, 加上很多的部分都是现学现卖，所以下述内容可能存在与具体事实相悖的内容, 所以如果发现请劳烦指正或讨论! 不胜感激.
>
> * 下文中如下词汇表达同一个意思： 数据帧，数据包

[TOC]

## SDN

SDN 全称 (software-defined networking), 直译为 `软件定义网络`. 在云计算风靡的今天, 已经无法在 `虚拟化的计算集群` 中使用硬件的网络资源来灵活的划分子网. 于是 SDN 的概念应运而生, 除了本地的 虚拟化网络外, 跨主机的 虚拟化网络也是 SDN 讨论的内容.

## 虚拟网络究竟要解决什么问题

在提出解决方案之前，务必需要清楚需求。在 Kubernetes 场景下，对 网络有什么需求

1. 所有的 Pods 都需要有 独立的 IP 地址
2. 所有的 Pods 都需要可以对外发包并接收到响应
4. 提供多个后端服务的负载均衡器（Service）
5. 使用 DNS 来服务发现
6. 使用 Network Policy (网络策略) 来区分网络

简单的讲就是希望是一个大内网环境, 基于 CNI 插件完成一个 大交换机的角色.

## CNI 跨节点组网

之前的文章里介绍的 `虚拟网路设备` 只是完成 跨节点虚拟设备组网 的基础，下面我们需要基于上述设备，提出跨节点组网的方案。

目前市面上的 跨节点组网方案 大多分为两类, `Overlay 方案` 和 `Route 方案`

overlay 成中文 就是 `覆盖层`，也就是在原有网络的基础上，使用软件构造一层像覆盖在上面的虚拟网络， 来完成数据包的转发, 通常使用的方法就是对软件再封包, 当 数据包到达 目标位置时再解包 并 投递到正确位置. 通常 overlay 方案会有一定的性能损耗(毕竟要修改数据包),但 overlay 方案的优势在于功能丰富. overlay 方案常用的 `虚拟网络设备` 包括如下: `VXLAN`, `TUN` 等 

Route 类方案， 来利用设置三层路由来完成组网，数据包出网的时候调整到达的 IP 地址, 数据包直达, 基本不修改数据包的结构, 但由于完全依靠路由完成, 所以功能没有 overlay 方案那么多, 不过 性能损失较小.

### flannel

flannel 几乎是最早的跨节点容器解决方案，由于 flannel 的设计实用而简洁, 所以通常建议在看其他 Kubernetes 网络方案之前, 先了解 flannel 的设计.

![](../../assets/flannel-01-arch-TUN.png)

由于篇幅过长, 并且是理解 K8s 网络的基础, 所以移动到 [另一篇文章中专题讨论](https://kuricat.com/articles/flannel-whhdp) , [(点这里)](https://kuricat.com/articles/virtual-network-basic-7yoiq)

### Calico

Calico 是一个完全基于 L3 的 Kubernetes 网络方案, 提供 2.5 种模式来进行路由处理, 并提供基于 iptables 的 network policy.

![](../../assets/k8sNetworkScheme-01-calico-arch.png)

![](https://docs.projectcalico.org/images/architecture-calico.svg)

#### IPIP  overlay 隧道

 它会在一个完整的 原 IP 包外面再封装一层 IP 包, 所以在 整个过程中 会产生两次路由判断,  这个模式和 flannel 中的基于 host-gw 的改进模式 ipip 很像, 毕竟思路都类似. 

#### BGP 方案

针对大规模 和 复杂的网络拓扑下, Calico 将每一台的 x86 服务器 都作为一个  路由器 和一个 AS, 各 AS 维护各自 AS 内的路由转发, 由 Calico 的控制平面来控制 BGP 路由以及设置各个节点的路由表.

![](../../assets/k8sNetworkScheme-02-calico-bgp-arch.png)

但由于 BGP client 之间需要维持 节点间 尽可能全连接的 TCP 连接, 用于同步路由信息, 所以如果有 100 个节点, 整个集群间就需要维护 100*99 个连接, 并且随着集群规模的上升, 每台机器的基础消耗 (CPU && MEM) 将会逐步上升,为了降低这里的消耗, Calico 还支持一种 `BGP Router Reflector (BIRD)` 的模式 , 直译 `BGP 路由反射器` , 

![](../../assets/k8sNetworkScheme-03-calico-bgp-bird-arch.png)

会在 BGP 的 AS 区域上层再抽象若干个区域出来,本区域的 BGP 节点可以借由 BIRD 来获取到另一个区域的路由信息, 这样就减轻了集群内的连接消耗. 另外 BIRD 属于控制平面组件, 并不会有数据包通过 BIRD.

#### 网络策略

除了上述功能之外, Calico 还支持设置网络策略, 用于切割内部网络, 这个 网络策略通过 iptables 实现.

![](../../assets/k8sNetworkScheme-01-calico-arch.png)

#### 结

可以看出 Calico 是为了解决 大型 K8s 集群中的网络问题而出现的, 它通过 BGP 技术使得 该方案可以兼容绝大多数的 K8s 节点的网络拓扑模型, 并使用较小的性能损耗.

BGP 唯一可以支撑 Calico 规模 和 方案 (纯 L3) 的路由协议, BGP 透过设置 AS, 让整个集群内的路由规则条数下降到极低的水平. 并且能够容忍 K8s 集群内 IP 快速漂移的特性.  而通过 其他的 路由协议, 例如 IGP / OSPF / IS-IS 等. 同时 BGP 也是当前的业界标准.

BTW, Calico 方案目前 (v3.13)已经支持使用 BPF 来完成包的转发.

### Weave

Weave 方案有点像 Calico 和 Flannel 的组合体, 数据包装和 Flannel 的 TUN 方案 以及 VXLAN 方案类似, 而跨节点组网和 Calico 类似, 由 BGP 改为 Gossip 协议. 这里不展开 Weave.

### Cilium

Cilium 提供多种组网方式, 除了提供 基于 VXLAN 的 Overlay 组网方式外, 还提供基于 BGP 的 组网 和互联, 另外还提供如下几种组网模式: 

* 和 云服务提供商的 网络绑定模式, 例如 AWS 的 ENI
* flannel 和 Cilium 的混合模式
* 基于 ipvlan 的组网,代替了 veth
* 基于 Cluster Mesh 的组网, 实现跨多个 Kubernetes 集群的网络连通性 和 安全性.

不过这些都有一个共同点,就是他们都大量的使用了 eBPF 技术.

![](../../assets/k9sNetworkScheme-04-cilium-arch.png)

#### BPF

// TODO

### CNI-Genie

// TODO

### 其他

还有很多基于 Macvlan  / IPvlan 甚至 直接使用 OVS 的 K8s CNI 网络插件这里就不一一介绍, 有兴趣可以去看 [虚拟网络基础](https://kuricat.com/articles/virtual-network-basic-7yoiq) 这一篇文章,[(点这里)](https://kuricat.com/articles/virtual-network-basic-7yoiq)

## 结

所以根据上述方案, 可以总结出如下结论

1. K8s 的 组网方案分为 `隧道方案 (overlay)` 和 `路由方案(router)`, 

   * Overlay 方案 由于要对 数据进行二次封包, 所以必定会带来一定的性能损耗, 但同时由于能够对数据操作, 所以功能也更加丰富.
   * Router 方案 由于只转发数据包, 并不处理数据包,所以性能相较 Overlay 方案会更高, 但是由于不对数据包做处理, 所以功能相对较少.

   上述二者各有千秋, 可以根据场景的不同自行选择.

2. K8s 的组网方案从过程上分为 `封包和转发` 以及 `本地交换机与 IP 分配` 两个部分 

   * 本地交换机 与 IP 分配代表本地的数据包处理
   * 封包和转发 代表外部的数据包和处理

   例子如下

   1. flannel 使用 veth pair 和 bridge 来处理本地的交换机, 以及 使用 host-local 来完成 本地的 IP 分配, 然后使用 VXLAN 或者 host-gw 来完成对外部的转发
   2. cilium 使用ipvlan 代替 veth pair , 然后使用 VXLAN 来完成外部转发, 并 搭配 ebpf


## ref

> * [kubernetes 网络权威指南 - jd.com](https://item.jd.com/12724298.html)
>   * ![](https://img14.360buyimg.com/n0/jfs/t1/83076/12/12519/154383/5da01033Ee717550a/9a3d23a200e3b207.jpg)
> * 

