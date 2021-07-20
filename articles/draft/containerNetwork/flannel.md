# flannel

[TOC]

flannel 是一个 提供给 Kubernetes 的 CNI 容器虚拟网络方案, 

## 背景 和 flannel 要解决的问题

从 flannel 的角度看, Kubernetes 只提供了 CNI 接口, 而 flannel 要完成下层网络的连通和构建.

flannel 要解决基于 CNI 的问题包括如下: 

1. 分配每个 Pods 的网络地址 (知道每个 Pods 在哪)
2. 设置虚拟网络设备, 来负责虚拟网络连通 (让数据包到达 指定 Pods 的位置)

除此之外, 它还要解决 Kubernetes 环境下对 网络方案的要求: 

1. 所有的 Pods 都需要有 独立的 IP 地址
2. 所有的 Pods 都需要可以对外发包并接收到响应
3. 合理划分子网, 避免 ARP 泛洪问题.
4. 可以动态的分配 IP 地址, 而不是静态的地址分配
5. 节点上的 Pod 可以不通过 NAT 和其他任何节点上的 Pod 通信
6. 节点上的代理（比如：系统守护进程、kubelet）可以和节点上的所有Pod通信

基于这些问题, flannel 提出了如下被后面出现的网络方案视为标准的 point: 

1. 讲 Pod 的 CIDR 网段与 机器绑定, 从而避免不必要的数据包转发
   ![210715-flannel-CIDR](/Users/kurisuamatist/Downloads/210715-flannel-CIDR.png)
1. ....// TOOD

明确了要解决的问题后, 需要来写一些代码来解决这些问题, flannel 选择了构建 overlay 网络的方式来解决 Kubernetes 网络的搭建问题.

## runtime 方案设计

### TUN ( backend UDP )

> 在其他大部分文章里, 以及 flannel 的官方文档里, 都会把这一阶段称为 `UDP` ,但笔者认为这个描述有失准确性, 这里的关键事实上不是 UDP, VXLAN 也是使用 UDP 来进行数据包的四层封装, 笔者认为这个方案的核心在于 TUN 设备. 遂这一节的标题笔者将它取为 TUN 

#### 设计

构建 overlay 网络, 最简单的方式自然是使用 TUN 来将 三层网络(L3) 的包抓上来, 然后由 应用层(L7) 重新封包 再投递. flannel 也是这么想的. 如下面的示意图所示, 

// TODO https://app.diagrams.net/#D210720-flannel-tun-arch.drawio

每个节点上会有一个 flannel 的 agent 叫做 `flanneld` , (下一章节会专门聊这个是如何预先配置到各个节点上的, 这里先专注在 Runtime 上) , 这个 Agent 会设置 router 和 开启 一个 tun 类型的网络设备 叫 `flannel 0` .

网络包从 `Network Namespace` 中, 透过 `veth pair` 来到 `docker0 (bridge)` 之后, 数据包的 `目标 mac 地址` 已经到达 (mac 地址是一段一段改变的), 当前数据包结构如下

```
# current package format

---------------
mac(L2)
---------------
ip (L3)
---------------
L4 protocal format
---------------
```

所以 bridge 会将这个数据包交给 `Linux 协议栈` 来做 L3 层的路由, `Linux 协议栈` 发现 数据包中的 `目标地址 IP` 符合 `Linux Kernel` 路由表中的路由规则, 接着会将 数据包 转发给 `flannel 0 设备`, 而 `flannel 0` 是 tun 设备, 在 收到 数据包后 会以 `L3 数据包` 的格式将 数据包 发给 flanneld 程序. 当前数据包结构如下

```
# current package format

---------------
ip (L3)
---------------
L4 protocal format
---------------
```

flanneld 程序会读取 收到的数据包 的 `目标 IP`, 根据 etcd 中的各 flannel 节点的 `网段信息` 判断 这个数据包要发给哪一个其他的 flanneld 程序. 

etcd 中的一个网段信息对应一个节点, 每个节点上会有一个 flanneld 程序, 而 etcd 中实际存储的就是一个网段信息对应一个 flanneld 程序的 IP 地址.

所以 flanneld 程序根据 etcd 中的 `网段信息` 知道了 数据包 的接受者在哪个节点之后,  就会将 数据包使用 UDP 的格式重新封包, 然后发送给对应节点的 flanneld 所监听的端口上. 当前数据包结构如下

```
# current package format

---------------
UDP (L4)
---------------
ip (L3)
---------------
L4 protocal format
---------------
```

// TODO https://app.diagrams.net/#D210720-flannel-tun-arch.drawio

接着数据包流经 当前节点的  eth0 网卡发送出去,  当前数据包结构如下

```
# current package format

---------------
Mac (L2)
---------------
other flanneld ip (L3)
---------------
UDP (L4)
---------------
ip (L3)
---------------
L4 protocal format
---------------
```

接着对端的 eth0 网卡接受到数据后, 开始将数据包解包, 在 L4 层发现是 Node B 上的 flanneld 监听的端口, 然后将 数据包透过 socket 的形式传输给 flanneld, 接着 flanneld 收到 eth0 给过来的数据包后,  当前数据包结构如下

```
# current package format

---------------
ip (L3)
---------------
L4 protocal format
---------------
```

将数据包再给回 flannel 0 这个 TUN 设备, TUN 设备会把这个包放回 L3 的协议栈中, 协议栈会去根据 Linux Kernel 路由表中的命中规则, 将 数据包发送 给 docker 0 , 然后 docker 0 完成 ip 到 mac 地址的转换, 将 数据包从对应的 veth pair 传输到 `network namespace` 中, 接着在 Linux 的协议栈 L4 拆包时, 将数据包给到 Biz App.  当前数据包结构如下

```
# current package format

---------------
L4 protocal format
---------------
```

// TODO https://app.diagrams.net/#D210720-flannel-tun-arch.drawio

这样就是 flannel 在 TUN 模式下, 数据包传输的全过程, 可以看到使用一个较为简单的结构, 以 overlay 的形式, 解决了 Kubernetes 网络的搭建.

#### 结

虽然 flannel 的 TUN 方案存在一些不小的缺陷(性能方面), 但可以看得出这个方案的潜力, 

* 通过以 节点维度 的网段划分, 来避免了要精确找到每个 IP 对应的 容器在哪的 问题 ~~(拯救大兵瑞恩 :))~~, 我们只需要知道这个节点对应的网段, 就可以知道这个数据包要发到哪个 flannel agent 上, 剩下的由 对应节点内部自行确定 数据包的接收容器. 虽然这个不一定是 flannel 首创, 可能在 传统的 VM 的网络方案中 就已经有. 但这是一个很棒的解决方案.

不过这个模式依旧存在缺陷, 主要是性能方面, 由于大量使用了 TUN 网络设备, 每发送一个数据包每次都会经历两次从 `用户态` 到 `内核态` 的切换,

```
  TUN ========> flanneld =======> eth 0
 内核态           用户态             内核态
```

这会造成不小的性能损耗, 接着需要对这块做优化.

### backend VXLAN



## 与 K8s 结合

大多数的文章写到这里就停了, 但其实只介绍 flannel 的  runtime 是没有办法和 K8s 相关知识串起来的, 还需要了解 flannel 是如何 支持 CNI 来达成和 K8s 协作的.



// 你可以看到 flannel 并不是强绑定 K8s 的, flannel 只是依赖 etcd . 大多数的 K8s 的网络方案自身也支持 为虚拟机提供服务.  



## ref

* [CNI - Flannel - IP 管理篇 - hwchiu](https://www.hwchiu.com/cni-flannel-ii.html)
