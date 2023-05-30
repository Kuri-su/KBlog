+++
date = "2021-03-08"
title = "access the server under the second layer network in OpenWrt route system"
slug = "access-the-server-under-the-second-layer-network-in-openwrt-route-system-nxb5t"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

> 基于 静态路由 

$x$

## 背景

在家庭组网中, 有时不方便把所有的机器部署到一个路由器下, 比如 `我的服务器` 和 `PC` 很可能不在一个 房间, 那么这样就需要完成从 PC 访问  二层网络下的服务器.

![openwrt-home-networking-0](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/openwrt-home-networking-0.png)

这里的问题在于 `Route A` 是 不知道 `Route B` 下的子网是什么样子的, 甚至 `Route A` 不知道 Server 的存在. 

## 方案
对于这种情况有两种方案:
1. `Route A` 和 `Route B` 网段相同, 将 `Route B` 下的子网并入 `Route A`, 同时 `Route B` 做 `Route A` 的 DHCP 中继.
2. `Route A` 和 `Route B` 网段不同, 在 `Route A` 上设置 静态路由表, 让 `Route A` 将 `Route B` 的 网段的全部数据包都转发给 `Route B`.

方案 1 比较麻烦, 笔者没有搞定 DHCP 中继的问题, 始终没有办法让 `Route B` 将 Server 的 IP 广播到 `Route A`. 所以最后选择了 方案 2, 并且 方案 2 可以容纳更多的设备在网络中.

## 实施

为了方便讲解, 下面假设 `Route A` 的网段是 `192.168.1.0/24`, `Route B` 的网段是 `192.168.99.0/24`

### 0x00 将 `Route B` 连接到 `Route A`

你可以使用下面若干种方式 让 `Route B` 加入 `Route A` 的子网 (其实就是连上 `Route A`), 详细这里就不赘述了.
* 有线连接 
* `Route B`  无线连接到 `Route A`
* ...

然后记录 `Route B` 在 `Route A` 子网的 IP, 这里假设分配到的是 `192.168.1.155`.

最好可以在这里设置一下 DHCP , 固定 一下 `Route B` 在 `Route A` 子网中的 IP

### 0x01 设置 `Route B` 子网

> 注意, 这里 `Route B` 的 网段不要和 `Route A` 的网段相同, 例如 `Route A` 的网段是 192.168.1.0/24 , 那么 `Route B` 就得设置成 除 192.168.1.0/24  之外的网段.

前往 `Route B` 的 管理后台,` Network -> Interface` 页面, 选择 wan , 将 协议改成 静态地址(static address), 

然后这里有三个参数要改
* ipv4 地址
  * 填上面 `Route B` 在 `Route A` 子网 DHCP 分配的 IP . 例如上面假设的 `192.168.1.155`
* 子网掩码
  * 一般填 255.255.255.0 , 和你想要管理多大的子网有关.
* ipv4 网关
  * 填 `Route A` 的网关地址, 例如 `Route A` 分配的 DHCP IP 是 `192.168.1.155` 那么, 这里一般都填 `192.168.1.1`

### 0x02 打开 `Route B` 的入站防火墙

input 和 forward 都要 打开, 

### 0x03 在 `Route A` 上设置 静态路由表

> 这里就是让 `Route A` 把全部的 关于 `Route B` 子网网段的 包 都转发给 `Route B`, 
>
> 你也可以理解成 `Route B` 是这些包的下一跳

来到 `Route A` 的 `Network -> Routes` 页面, 添加一条 ipv4 规则, 

* Interface 
  * 选 lan
* Target 
  * 写 `Route B` 的网段, 例如上面的 `192.168.99.0/24`, 
* ipv4-netmask
  * 子网掩码, 根据网段, 这里填 `255.255.255.0`
* ipv4-gateway
  * 填 `Route B` 在 `Route A` 的子网中的地址, 例如上面的 `192.168.1.155`

别的设置都保持原样即可.

## 结

到这里就基本都完成了.

## ref

> [Openwrt静态路由实现内网通讯](https://blog.csdn.net/wgl307293845/article/details/90548290)