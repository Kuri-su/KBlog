# 容器网络 (虚拟网络) 基础

> 因为笔者对 计算机网络 认识浅薄, 所以下述内容可能存在与具体事实相悖的内容, 所以如果发现请劳烦指正或讨论! 不胜感激.

[TOC]

当笔者第一次看到 Flannel 的结构图的时候, 是懵的...WTF..... 为什么网络能弄得这么复杂...

![](https://msazure.club/content/images/2018/05/Flannel.jpg)

这又是 网桥(bridge), 又是 vethpair , 还有什么逻辑 以太网设备 (`physical eth dev`), 和什么 VXLAN? WTH? 怎么感觉和 我学得计算机网络课程一点关系都没有....老师只讲过 TCP/IP , OSI 七层网络....

## 容器网络 解决 什么问题, 为什么会有这些问题? 

但每一个技术方案的出现, 都是为了解决一个或多个问题, 容器网络要解决的问题(或需求)包括如下: 

* 每个 Pod 都有独立的 IP
* 不同 Pod 的容器间能互相通信 (即便是跨节点)

但这种问题其实不是只有容器网络遇到, 早在 `虚拟机时代` (VM), `OpenStack` 就已经遇到过这些问题, 我们可以通过 OpenStack 官网给出的计算节点结构略窥一二, 

![KVM 网络结构](https://www.xjimmy.com/wp-content/uploads/image/20180107/1515321289889563.jpg)

可以看到这些虚拟网络设备, 在 OpenStack 节点的结构图上都有, 所以事实上, 其实所谓容器网络的方案解决的问题并不局限于容器网络, 或者虚拟机网络, 本质是为了解决 `不同场景下的网络虚拟化需求`.

`虚拟网络` 是相对于 `传统网络` 所提出的概念, 例如大型机房中, 需要有很多的 交换机/网线/网卡 等的 实体网络设备, 来让机房中的各个 Server 之间互相通信. 当 `虚拟化技术(VM/Container)` 开始升温之后, 一台16C64G 的实体机器上, 可能存在 十几个到上百个的 虚拟机, 他们宛如 大型机房中的多个主机, 之间需要解决互联的需求. 于是 便有了虚拟网络的概念. 但在当前的常见技术中, 尚无能完美解决这个需求的技术方案, 各家都在提出自己的方案, 用不同的技术, 来不断的优化. 例如 `OpenStack(一个 基于 KVM 的 虚拟机编排系统)` 本身对于 其虚拟化网络实现就进行了多次迭代, 容器网络生态中, 也针对 K8s 的 CNI 接口, 以 CNI-Plugin 的形式 , 提出了 各种实现方案, 例如

* Flannel
* Calico
* Weave
* Cilium
* CNI-Genie
* terway(Aliyun)

这里先简单聊一下CNI , CNI 全称 (Container Network Interface), 是 K8s 对外抽象的三个接口之一, 

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/Kubernetes%E6%9E%B6%E6%9E%84-simple.png)

CNI 的Interface 很简单, CNI-Plugin 只要实现下述接口, 再进行简单的配置, 就可以和 K8s 进行交互

```go
type CNI interface {
	AddNetworkList(ctx context.Context, net *NetworkConfigList, rt *RuntimeConf) (types.Result, error)
	CheckNetworkList(ctx context.Context, net *NetworkConfigList, rt *RuntimeConf) error
	DelNetworkList(ctx context.Context, net *NetworkConfigList, rt *RuntimeConf) error
	GetNetworkListCachedResult(net *NetworkConfigList, rt *RuntimeConf) (types.Result, error)
	GetNetworkListCachedConfig(net *NetworkConfigList, rt *RuntimeConf) ([]byte, *RuntimeConf, error)

	AddNetwork(ctx context.Context, net *NetworkConfig, rt *RuntimeConf) (types.Result, error)
	CheckNetwork(ctx context.Context, net *NetworkConfig, rt *RuntimeConf) error
	DelNetwork(ctx context.Context, net *NetworkConfig, rt *RuntimeConf) error
	GetNetworkCachedResult(net *NetworkConfig, rt *RuntimeConf) (types.Result, error)
	GetNetworkCachedConfig(net *NetworkConfig, rt *RuntimeConf) ([]byte, *RuntimeConf, error)

	ValidateNetworkList(ctx context.Context, net *NetworkConfigList) ([]string, error)
	ValidateNetwork(ctx context.Context, net *NetworkConfig) ([]string, error)
}
```

这些方案通过不同的 Linux 能力和组件, 都实现了 可用的容器网络方案, 但在此之前, 让我们先了解 这些 Linux 能力与组件.

## 虚拟网络设备 和 本机组网

### 虚拟网卡 和  物理网卡 

虚拟网卡和物理网卡, 虽然中文里都叫网卡, 但是事实上他们是两种完全不一样的存在, 虚拟网卡的英文是 VNIC (virtual Network Interface Controller),  英文的直译应该是 `虚拟网络接口`, 而 VNIC 可以是多种 虚拟网络设备, 例如  Veth pair,回环地址,等, 它是一个虚拟的网络接口, 虚拟网卡和物理网卡不是一一对应的关系, 虚拟网卡甚至可以在没有物理网卡的情况下运行. 每个 虚拟网卡有自己的 PCI 地址 和 MAC 地址,  不一定有 IP 地址, 因为 IP 工作在 OSI 的第三层, 而 虚拟网卡工作在 OSI 的 第二层.

![](https://images2015.cnblogs.com/blog/697113/201602/697113-20160228205711695-689378767.jpg)

通过 `ip addr show` 命令, 可以列出主机上所有的 虚拟网卡 和 网桥 的信息. 

```shell
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether e0:d5:5e:eb:42:3a brd ff:ff:ff:ff:ff:ff
    inet 192.168.13.240/24 brd 192.168.13.255 scope global noprefixroute enp2s0
       valid_lft forever preferred_lft forever
    inet6 fe80::f37b:2fd6:1615:1ac9/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:fd:bd:10:9e brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:fdff:febd:109e/64 scope link 
       valid_lft forever preferred_lft forever
4: br-b46f9f84d316: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:e7:0a:7d:ea brd ff:ff:ff:ff:ff:ff
    inet 172.23.0.1/16 brd 172.23.255.255 scope global br-b46f9f84d316
       valid_lft forever preferred_lft forever
    inet6 fe80::42:e7ff:fe0a:7dea/64 scope link 
       valid_lft forever preferred_lft forever
5: br-e51b459e95d6: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:f6:78:18:d4 brd ff:ff:ff:ff:ff:ff
    inet 172.29.0.1/16 brd 172.29.255.255 scope global br-e51b459e95d6
       valid_lft forever preferred_lft forever
6: br-f9c150071433: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:89:9d:e4:71 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-f9c150071433
       valid_lft forever preferred_lft forever
    inet6 fe80::42:89ff:fe9d:e471/64 scope link 
       valid_lft forever preferred_lft forever
7: br-1c66916ee396: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:86:c1:0c:5e brd ff:ff:ff:ff:ff:ff
    inet 172.25.0.1/16 brd 172.25.255.255 scope global br-1c66916ee396
       valid_lft forever preferred_lft forever
    inet6 fe80::42:86ff:fec1:c5e/64 scope link 
       valid_lft forever preferred_lft forever
9: veth8363cd6@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
    link/ether 0a:64:0a:9d:bb:55 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet6 fe80::864:aff:fe9d:bb55/64 scope link 
       valid_lft forever preferred_lft forever
11: veth78fe6fc@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-f9c150071433 state UP group default 
    link/ether 4a:66:df:91:10:2f brd ff:ff:ff:ff:ff:ff link-netnsid 6
    inet6 fe80::4866:dfff:fe91:102f/64 scope link 
       valid_lft forever preferred_lft forever
13: vethfb75878@if12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-b46f9f84d316 state UP group default 
    link/ether e2:eb:19:1c:aa:18 brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet6 fe80::e0eb:19ff:fe1c:aa18/64 scope link 
       valid_lft forever preferred_lft forever
15: veth9886990@if14: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-1c66916ee396 state UP group default 
    link/ether 36:c5:a3:2e:89:7a brd ff:ff:ff:ff:ff:ff link-netnsid 5
    inet6 fe80::34c5:a3ff:fe2e:897a/64 scope link 
       valid_lft forever preferred_lft forever
17: veth36d8182@if16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-b46f9f84d316 state UP group default 
    link/ether 02:c3:1b:52:13:87 brd ff:ff:ff:ff:ff:ff link-netnsid 3
    inet6 fe80::c3:1bff:fe52:1387/64 scope link 
       valid_lft forever preferred_lft forever
19: veth22b9639@if18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-f9c150071433 state UP group default 
    link/ether da:3c:81:e5:70:84 brd ff:ff:ff:ff:ff:ff link-netnsid 2
    inet6 fe80::d83c:81ff:fee5:7084/64 scope link 
       valid_lft forever preferred_lft forever
21: veth1520a2e@if20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-1c66916ee396 state UP group default 
    link/ether c6:fb:d9:84:c7:c5 brd ff:ff:ff:ff:ff:ff link-netnsid 8
    inet6 fe80::c4fb:d9ff:fe84:c7c5/64 scope link 
       valid_lft forever preferred_lft forever
23: veth899d5f2@if22: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-b46f9f84d316 state UP group default 
    link/ether 3a:97:49:66:90:49 brd ff:ff:ff:ff:ff:ff link-netnsid 7
    inet6 fe80::3897:49ff:fe66:9049/64 scope link 
       valid_lft forever preferred_lft forever
25: vethd68ef22@if24: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-f9c150071433 state UP group default 
    link/ether 6a:4a:c8:f3:f2:ab brd ff:ff:ff:ff:ff:ff link-netnsid 4
    inet6 fe80::684a:c8ff:fef3:f2ab/64 scope link 
       valid_lft forever preferred_lft forever
27: veth9645276@if26: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-b46f9f84d316 state UP group default 
    link/ether e2:58:d2:b1:a5:7d brd ff:ff:ff:ff:ff:ff link-netnsid 9
    inet6 fe80::e058:d2ff:feb1:a57d/64 scope link 
       valid_lft forever preferred_lft forever
       
 // TODO 补一张 brctl 绑定的信息
```

这里可以看到四种设备, 

* lo 本地回环设备, 每一个 Linux 网络协议栈创建的时候都会有这个设备
* enp2s0 , 是对应网卡的虚拟网卡
* docker0 和 br-xxx 的设备, 这些是网桥 (Linux Bridge)
* vethxxx 设备, 这些是 Veth Pair 设备.

下面会具体介绍什么是 VethPair, 什么是 Linux Bridge

### Veth Pair

Veth 是 `Virtual Ethernet` 的缩写, 意思是 虚拟以太网卡,  Veth Pair 就是 虚拟网卡对,  也就是说, Veth Pair 是两个设备, 而不是一个设备, 你可以将这两个设备放入不同的 `Linux Network Namespace` , 来连通两个 Namespace, 从 Veth Pair 的任意一端喂进去的数据包, 会出现在另一端的设备上.

事实上, 其实 Veth pair 是一个 一端连着 网络连着网络协议栈, 一端连着 自己的另一端的设备, 从而实现了上述功能.

![img](https://ctimbai.github.io/images/net/veth.png)

如果 veth pair 像一个虚拟的网线一样, 只能连接 两个 Network Namespace , 那么功能实在太有限, 根本无法在大量部署容器的场景下使用, 事实上 veth pair 的最常见的用法是 将 Veth Pair 和 Bridge 关联, 进而实现 多个网络设备 的连接,这种用法 会经常出现在 虚拟机组网 和 容器组网中,  例如下面这样 , 这是 Docker 的本地组网方式: 

![img](https://i.stack.imgur.com/IoFjk.png)

### Linux bridge

顾名思义, 这个虚拟网络设备是 Linux 网桥, 对应的现实中的网络设备是 交换机, 多个设备或者 Network Namespace , 通过  Veth Pair 连接到网桥上, 来实现连通. 

当网桥接受到 数据包后, 会根据 `ARP 协议`广播  `询问报文` 到所有连接到自己的设备上 , 来转换 IP 获取 Mac 地址, 进而转发数据包, 到指定的网络设备上. BTW, 每个 veth pair 的设备都是有自己的 Mac 地址的.

Bridge 通常会在 虚拟机组网 和 容器组网 中, 担任交换机的角色, 连接本机的所有容器, 并且会连上 代表物理网卡的 eth0, 来将对外的 数据包通过转发给 eth0 发出去, 然后将 eth0 给过来的数据包 转发给对应的服务, 和上面的例子一样, Docker 在本地就是使用这种组网方式.

![img](https://i.stack.imgur.com/IoFjk.png)

### TUN/TAP

TUN 和 TAP 是两个设备, 他们会组合到一起使用

https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Tun-tap-osilayers-diagram.png/400px-Tun-tap-osilayers-diagram.png

// TODO

## 跨节点组网

### Overlay 方案 和 Route 方案

#### Route

#### Overlay

### VLAN(VXLAN)

// TODO first

### IPIP(隧道网络)

### Macvlan

### IPvlan

### IPVS

## 协议

### DNS 协议

### NAT 协议

### BGP 协议

## Linux 网络架构

介绍虚拟网络避免不了要先介绍 Linux 的网络架构, 需要从较高的视野来看一下容器网络到底在做什么. 工作在哪一层?

![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9pbWctbXkuY3Nkbi5uZXQvdXBsb2Fkcy8yMDEyMTAvMjUvMTM1MTE1OTYxNF8xNzAyLmpwZw?x-oss-process=image/format,png)

这是一张简单的 Linux 的内核结构图, 最右边一列是网络方面的管理,  

### 

![](https://images2015.cnblogs.com/blog/697113/201602/697113-20160228205711695-689378767.jpg)

## REF

> * [容器网络(一) - morven.life](https://morven.life/posts/networking-4-docker-sigle-host/)
> * [Linux無線網路架構 - itread01.com](https://www.itread01.com/content/1547977690.html)
> * [KVM 网络虚拟化基础  - Jimmy's Blog](https://www.xjimmy.com/openstack-5min-9.html)
> * [Flannel Networking Demystify - msazure.club](https://msazure.club/flannel-networking-demystify/)
> * 

