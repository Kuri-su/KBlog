# Kubernetes 新晋指北

> 内部分享稿

[TOC]

<!-- 由简到繁 -->
<!--定位在 入门 和 进阶-->

## 背景简介

<!-- TODO 待修改 -->
在 Docker 实现了更轻量的打包方式 (相较虚拟机), 并让 容器技术 成为当年的当红辣子鸡之后, 若停留于此, 那么 Docker 或者容器化技术就仅仅 只是一个开发者手头上的玩具. 若要将其发扬光大, 而若将 Docker / 容器化技术用于 DevOps 领域 或者 在服务端代替 现有的虚拟机方案, 都还有很多工作要做. 于是 很多大厂便开始将 目光转向容器编排领域, 当时各家提出了很多方案, 例如

* Docker 的 Docker Swarm ,
* Google 和 RedHat 主导的 Kubernetes,
* 加州大学伯克利分校 开发的 Mesos 套件, 后应用于 Twitter/Airbnb 等公司.
* ....

这里主要介绍 `Kubernetes` 项目, Kubernetes 常常简称 `K8S`, 是将中间的 八个字母 (ubernete) 合起来, 然后简称 K8S, 类似的还有 i18n 也是 `internationalization` 的简称. Kubernetes 最早由 Google 内部进行开发, 后在 2014 年公开, 此后在 2015 将 项目捐献给 CNCF.

 Kubernetes 的前身是 Google 内部的 编排系统 `Borg`. 如今的 Kubernetes 已是上述提到的三者中使用者最多的容器编排工具, 是当下容器编排工具的 ` 事实标准 `.

> 以上部分内容来自 Wiki.

## Kubernetes 解决了什么问题

了解一个软件或者系统最好的办法当然是阅读他的架构, 但是在介绍架构之前,  我们可能需要先了解需求和问题, 以更好的了解 Kubernetes. 而说需求和问题, 我们就得结合当时的情况和工具来分析, 毕竟五十年前的问题放到现在来讨论是没有意义的 :joy:

最初我们在业务起步的时候都会使用单体应用, 即所有的服务都写在一起, 部署到一台专有的服务器中,

// TODO 将服务安装到一台服务器上, 然后 DB , cache, MQ 部署到别的服务器上

![SingleNode]()

在业务量上涨后, 单机无法支撑访问量, 便多开了几台服务器, 然后在前面做了一个负载均衡, 来提高 QPS.

![MutailNode]()

但是这样做又带来一个问题, 以 Go/Java 这种编译型语言写的应用为例, 由于我们所有的功能都写在一个项目中, 也就是由一个 main 函数控制 , 那么在部署时, 会将所有的功能都运行起来.

![RunningInServer]()

但正如上图所示, 有一些调用频率很低的服务并不需要开这么实例, 但是由于我们的全部服务都写在一起, 造成这类服务占用着内存, 造成内存的浪费, 并且集群规模越大, 这样的浪费会越严重. 并且线上的很多服务器往往经常负载不高, 但如果让别的服务到这些机器上运行又会难以管理.

那看到这里有同学就会说啦, 用微服务 (Micro Services) 不就行了, 将 Service 拆分, 单独部署, 中间使用 RPC 之类的协议进行通信, 完美解决上面的资源浪费问题. 并且可以根据服务的特点很方便的横向扩展. 是的没错, 使用微服务确实是可以解决上面的问题, 但是使用微服务又会带来新的问题 :joy: .

 ![]()

 一方面是部署会变得麻烦, 如果没有方便的服务监视和管理工具的话, 服务的监控 / 重启 / 更新 / 日志收集 等的方面都较难解决. 另一方面更加难受, 一台机器上同时运行多个同一服务进程时, 一旦需要操作 / 写入 / 读取同一份文件时, 将变得非常蛋疼..., 脏读 / 并发写覆盖 / 有些服务甚至还会在操作过程中加锁, 并且如果这同一服务的多个进程用的同一份配置, 将监听同一端口, 我们还需要实现一个让他们监听不同端口的方法, 防止端口冲突. 当你把这一份方案给 Leader 看的时候, 绝对会被 Leader 锤爆狗头.:joy::joy::joy:

那有同学就说了, 用容器不就能解决这个问题了么? 确实, 但在当时容器技术还没有火起来被大量使用, 不过 像 Google 公司的 Borg 系统中就使用 Cgroup 实现了类似于容器的东西, 但不是所有公司都像 Google 这么超前和强力. 那么当时的一些公司使用了 虚拟机 完成这些工作.

基于虚拟化技术的一台宿主上再虚拟出多台虚拟机器, 限制每台机器资源用量, 随着访问量的提升逐步创建虚拟机器, 提升了单台机器的资源利用率, 并且可以较好的进行水平伸缩. 这样的方案在当时其实是很不错的方案了, 但是虚拟化技术也有一些问题, 一方面是会有一定的性能损失, 因为虚拟化技术会将虚拟机器中的机器指令翻译成宿主支持的机器指令, 中间这个转换翻译的过程会有一定的性能损失. 即便我的宿主是 `Ubuntu 19.04` , 虚拟机也是 `Ubuntu 19.04` , 也会有性能损失....

![虚拟化技术示意图]()

再一个就是虚拟机器的启动,  我们知道虚拟机的启动由于这个转换层的存在, 以及由于加载和启动的是完整的系统, 所以虚拟机的启动时间往往都以分钟为单位.

但是问题又来了, 开虚拟机是可以一定程度上解决上面的问题了, 但是我的虚拟机要怎么调度呢, 例如 这台机器资源不够, 不能将新的实例分配到这台机器, 得分配到别的机器. 于是当时就有了类似于 Openstack 这种平台级应用, 负责将下面所有的宿主机器对上层抽象, 上层只要关注虚拟机即可, 而无需关注宿主状态, 这些虚拟机间的调度将又 Openstack 来完成, 这就是传统的 Paas 平台.

后面的事情大家就知道了, Docker 出现后, 由于它轻量, 启动快, Docker Image 便于分享等特点, 和后面的 容器编排技术一起, 快速取代了以前的 传统 Paas 平台.

上面讲了这么多, 主要是想加深大家对 Kubernetes 解决了什么问题的印象.

![问题示意图]()

* Kubernetes 将完成 服务的部署更新以及一定程度的监控和重启
* 解决了 容器调度 / 编排 等问题, 可以更大限度的使用服务器资源.
* 比较好的支持 有状态和无状态 的应用的部署
* 由于 Kubernetes 中的一切皆为 API 对象, 以及 所有的对象都采用了控制器模式来进行设计, 所以拥有更好的扩展性和普适性, 并且这样给了我们更大的想象空间.
* {更多的 Kubernetes 优点}

=========

tips:

1. 从自身角度出发， 假设没有 Kubernetes， 将如何部署多服务， 如何限制服务使用的资源，如何监视和自动重启服务，如何调度和更大限度的使用服务器资源。
2. 这也给了我们更大的想象空间，

此处需要查阅更多资料


## Kubernetes 是如何解决这些问题的 （Kubernetes 架构）

> 我自己需要先整理下 Kubernetes 的架构.

实际上, 并没有一个 二进制文件或者一个服务叫做 Kubernetes , Kubernetes 是一群组件的总称, 他们互相协作, 像一个 Kubernetes(舵手) 一样驾驶着这艘船.

那么在介绍 Kubernetes 是如何解决这些问题之前, 我们需要先了解以下 Kubernetes 的架构, 考虑到在场的大部分人是第一次接触到 Kubernetes , 所以我们不直接开始讲 Kubernetes 的架构, 我会先根据需求列出一个 大致的 Kubernetes , 然后逐步改进它, 最后引出 Kubernetes 的架构.

### 分布式应用

> Kubernetes 为什么采用这样的架构
>
> https://zhuanlan.zhihu.com/p/55401096

作为一个 分布式应用, 通常会有 Master / Worker 的区分, Master 就是 控制节点, 控制平面一般放在 Master 节点上 , 而 Worker 就是 执行节点, 例如 ElasticSearch , 它使用的是 选举然后出现 Master 的方式, 其他作为 Worker. 例如 ETCD , 使用的 Raft 算法来维持集群内的强一致. 但他们的这些做法是为了保证数据的强一致, 而 Kubernetes 作为一个 容器调度平台, 我认为并不需要上述这样的数据强一致性, 再一个方面, 使用这些选主算法会让 Kubernetes 过度复杂, 所以 Kubernetes 采用的是最简单的固定 Master 的方式. 然后 其他节点 Join 到 Master 中, 作为 Worker. 也就是大致如下图,   

![](最简单的 Kubernetes 集群 )

但我们也能看到如果 Master 节点只有一个, 很容易出现单点问题, 所以一个高可用的Kubernetes 会有一些 Master 节点作为备用. 最简单的高可用 Kubernetes 如下图所示

> <Kubernetes 高可用>


### Worker 

那么既然已经确定了集群结构, 那么自然来到最关心的点, 如何实现将 我写的一个容器 放到 Node 也就是机器上呢,这里以 Nginx:latest 为例, 这个必然首先由 Master 发出一条请求, 告诉 某一个 Worker 节点, 你需要启动一个  Nginx:latest 这个容器, 然后 给限制它的内存和CPU.

那么 Worker 上的 客户端 收到这个 请求后, 就需要着手开始准备了, 首先 由于默认使用 Docker 作为容器技术, 那么将使用 Docker 启动容器运行时 (CRI),然后将 磁盘挂载 (CSI), 接着挂载 网络 (CNI), 接着注册回 Master 节点上, 

> <Kubelet 的功能>
>
> <Kubernetes CSI 初见>
>
> <Kubernetes CNI 初见>
>
> <Kubernetes CRI && OCI 初见>
>
> <Kubernetes Proxy>

### Master 

将 IP记录到 ETCD 中

> <Kubernetes Scheduler 解密>
>
> <Kubernetes Controller Manager>
>
> <Kubernetes Api Server>
(这样听众会对 Kubernetes 的结构了解更加深刻)

!!! 整篇需要穿插着 Kubernetes 这么做是为了解决什么问题 !!!

例如 CRI / CNI

<架构图>

<!-- Kubernetes 架构 -->

tips:

1. Kubernetes 使用的是 Master-Worker 的架构，

3. Master Node 如何调度 / 伸缩 / 服务发现。(Controller/Scheduler/ApiServer/Etcd)

4. Kubernetes 是如何解决这些问题的.

> <Kubernetes Scheduler 解密>
>

此处需要查阅更多资料

> <KubeCtl 是什么>
>

## Kubernetes 如何将一个 Yaml 变成 一个运行在 Kubernetes 中的服务

此处需要查阅更多资料

最好能穿插一些源码

> <Kuberntes Deployment 的生命周期>
>

## 我们现在如何使用 Kubernetes 

## What's Next

### 如何扩展 Kubernetes (Opteator/Custom Controller/Custom Scheduler)

> <Kubernetes opeator 的生命周期>

> <Kubernetes Helm>

此处需要查阅更多资料

### 如何参与到 Kubernetes 的开发中

> <Kubernetes 的目录结构>
>
> <Kubernetes Sig>


### 如何拥有自己的第一个 Kubernetes 集群

`MiniK8S` / `MicroK8S` / `KubeAdm` 

> https://avnpc.com/pages/kubernetes-for-single-vps#kubernetes-%E5%8D%95%E8%8A%82%E7%82%B9%E9%83%A8%E7%BD%B2%E6%96%B9%E5%BC%8F%E5%AF%B9%E6%AF%94

如果不知道怎么选就选 `MiniK8S` 就行了


### How to do better!!

`Istio` / `Enrvy` / `...`



