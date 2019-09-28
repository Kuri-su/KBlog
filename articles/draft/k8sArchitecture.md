# Kubernetes 架构

> 内部分享演讲稿

<!-- 由简到繁 -->

为什么会有 Kubernetes ? 它的提出自然是用于解决问题的, 那么遇到了什么问题呢? 现在有个场景, 假设我们需要部署微服务, 我们有几种选择.

## Kubernetes 出现之前的 服务架构是什么样子的（Kubernetes 解决了什么问题）

tips:

1. 从自身角度出发， 假设没有 Kubernetes ， 将如何部署多服务， 如何限制服务使用的资源，如何监视和自动重启服务，如何调度和更大限度的使用服务器资源。
2. 这也给了我们更大的想象空间，

此处需要查阅更多资料


## Kubernetes 是如何解决这些问题的 （Kubernetes 架构）

实际上, 并没有一个 二进制文件或者一个服务叫做 Kubernetes , Kubernetes 是一群组件的总称, 他们互相协作, 像一个 Kubernetes(舵手) 一样驾驶着这艘船.

那么在介绍 Kubernetes 是如何解决这些问题之前, 我们需要先了解以下 Kubernetes 的架构, 但是我并不打算直接开始讲 Kubernetes 的架构, 我会先根据需要解决的问题列出一个 KuriNetes , 然后逐步改进它, 最后引出 Kubernetes 的架构.

( 这样听众会对 Kubernetes 的结构了解更加深刻)



!!! 整篇需要穿插着 Kubernetes 这么做是为了解决什么问题 !!! 

例如 CRI / CNI

<架构图>

<!-- Kubernetes 架构 -->

tips:

1. Kubernetes 使用的是 Master-Worker 的架构，

2.  Worker Node 如何启动和关闭， 以及和网络联通进行讲解 （Kubelet/CSI/CNI/CRI/OCI/KubeProxy）

> <Kubelet 的功能>
> <Kubernetes CSI 解密>
> <Kubernetes CNI 解密>
> <Kubernetes CRI 解密>

3. Master Node 如何调度 / 伸缩 / 服务发现。(Controller/Scheduler/ApiServer/Etcd)

4. Kubernetes 是如何解决这些问题的. 

> <Kubernetes Scheduler 解密>

此处需要查阅更多资料

> KubeCtl 是什么

## Kubernetes 如何将一个 Yaml 变成 一个运行在 Kubernetes 中的服务

此处需要查阅更多资料

最好能穿插一些源码

## 如何扩展 Kubernetes (Opteator/Custom Controller/Custom Scheduler)



此处需要查阅更多资料

## What's Next

`Istio` / `Enrvy` / `...`

