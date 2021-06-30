# Kubernetes Network 方案和实现

[TOC]

## 虚拟网络究竟要解决什么问题

在提出解决方案之前，务必需要清楚需求。在 Kubernetes 场景下，对 网络有什么需求

1. 所有的 Pods 都需要有 独立的 IP 地址
2. 所有的 Pods 都需要可以对外发包并接收到响应
3. Pod CIDR 用来区分节点，划分子网
4. 提供多个后端服务的负载均衡器（Service）
5. 使用 DNS 来服务发现
6. 使用 Network Policy (网络策略) 来区分网络

简单的讲就是希望是一个大内网环境, 每个 Pod 都希望像一个实体机一样, 

能够 明确了需求, 接着我们列举下目前受到的限制和挑战:

1. 容器 IP 地址重复的问题，
2. // TODO

## 跨节点组网

上面的虚拟网路设备只是完成 跨节点虚拟设备组网的基础，下面我们需要基于上述设备，提出跨节点组网的方案。

### Overlay 方案 和 Route 方案

目前市面上的 跨节点组网方案 大多分为两类

#### Overlay 方案

overlay 直译过来就是 覆盖层，也就是在原有网络的基础上，使用软件构造一层像覆盖在上面的虚拟网络， 来完成数据包的转发。

##### flannel

flannel 几乎是最早的跨节点容器解决方案，flannel 目前提供很多种的网络模式，除了等下要详细讲的 `UDP` \ `VXLAN` \ `Host-Gateway` 这三个模式外，还包括如下

* 平台绑定的网络模式 ： `AliVPC` \ `AWSVPC` \ `TencentVPC` \ `GCE Route`
* `IPIP` \ `IPSec` 
* 仅限单机的 `Alloc`



![img](https://miro.medium.com/max/1806/1*JqSLd3cPv14BWDtE7YEcRA.png)

// TODO

##### Weave

// TODO

##### Open vSwitch（OVS）

// TODO



#### Route 类型方案

Route 类型想借用 物理网络设备 的能力， 来完成组网，数据包出网的时候调整到达的 IP 地址， 让外部的 物理网络设备 完成数据包的路由转发。

##### Calico

// TODO

##### Macvlan

// TODO

##### Metaswitch

// TODO

### 其他

#### Cilium

##### cBPF && eBPF

// TODO

#### CNI-Genie

// TODO

