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

flannel 会 以 DaemonSet 的 形式 在每个节点上安装一个 Agent, 然后这些 Agent 并不会自己转发和处理数据,这些 Agent 会在对应的节点上对环境进行配置, 设置那台机器的虚拟网络设备和相关配置文件, 



## ref

* [CNI - Flannel - IP 管理篇 - hwchiu](https://www.hwchiu.com/cni-flannel-ii.html)
