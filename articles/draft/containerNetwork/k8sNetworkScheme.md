# Kubernetes Network 方案

[TOC]

## 跨节点组网

上面的虚拟网路设备只是完成 跨节点虚拟设备组网的基础，下面我们需要基于上述设备，提出跨节点组网的方案。

### Overlay 方案 和 Route 方案

目前市面上的 跨节点组网方案 大多分为两类

#### Overlay 方案

overlay 直译过来就是 覆盖层，也就是在原有网络的基础上，使用软件构造一层像覆盖在上面的虚拟网络， 来完成数据包的转发。

##### Weave

// TODO

##### Open vSwitch（OVS）

// TODO

##### flannel

![img](https://miro.medium.com/max/1806/1*JqSLd3cPv14BWDtE7YEcRA.png)

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

