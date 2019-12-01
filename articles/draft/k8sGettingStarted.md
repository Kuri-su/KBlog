# Kubernetes 新晋指北

> 内部分享稿
>
> 由简到繁
>
> 定位在 入门 和 进阶
>/# 第一部分 - kube-apiserver 对 etcd 的 list-watch 机制)
> 这次分享的目的是 主要讲清楚 Kubernetes 如何实现它的编排能力 和 现阶段我们使用 Kubernetes 的方式
>
> 因为完全没有看过源码, 所以如下大部分内容都是来自 ` 道听途说 ` (虽然这个成语不是这么用的 XD) 和 ` 官方文档 ` ( 知识的搬运工 XD) , 以及 使用经验 和 逻辑上行得通的思考

[TOC]

## 背景简介

<!-- TODO 待修改 -->
在 Docker 实现了更轻量的打包方式 (相较虚拟机), 并让 容器技术 成为当年的当红辣子鸡之后, 若停留于此, 那么 Docker 或者容器化技术就仅仅 只是一个开发者手头上的玩具. 若要将其发扬光大, 而若将 Docker / 容器化技术用于 DevOps 领域 或者 在服务端代替 现有的虚拟机方案, 都还有很多工作要做. 于是 很多大厂便开始将 目光转向容器编排领域, 当时各家提出了很多方案, 例如

* Docker 的 Docker Swarm
* Google 和 RedHat 主导的 Kubernetes
* 加州大学伯克利分校 开发的 Mesos 套件, 后应用于 Twitter/Airbnb 等公司
* ....

这里主要介绍 `Kubernetes` 项目, Kubernetes 常常简称 `K8S`, 是将中间的 八个字母 (ubernete) 合起来, 然后简称 K8S, 类似的还有 i18n 也是 `internationalization` 的简称. Kubernetes 最早由 Google 内部进行开发, 后在 2014 年公开, 此后在 2015 将项目捐献给 CNCF.

 Kubernetes 的前身是 Google 内部的 编排系统 `Borg`. 如今的 Kubernetes 已是上述提到的三者中使用者最多的容器编排工具, 是当下容器编排工具的 ` 事实标准 `.

> 以上部分内容来自 Wiki.

## Kubernetes 的功能

Kubernetes 最常用的特性是用于 容器化应用的 自动部署 / 自动扩缩容与重启 / 管理.

* 自动部署
    * 意味着你不需要再手动的去每一台机器上装环境, 去手动的将一个一个的新服务部署上线, 你仅仅只需要写一个文件, 告诉 Kubernetes , 你的服务长什么样子, 有哪些特性, 需要多少资源. 然后 Kubernetes 就会将你的服务 / 应用, 部署到线上.

* 自动扩缩容与重启
    * 当 Kubernetes 发现你的服务处于高负荷的状态, 它有能力为你自动启动多个副本, 将请求均分到 这些 副本上, 环节峰值压力, 提高服务的稳定性, 并且如果你的 Kubernetes 位于 云平台上, 例如 AWS/Aliyun , Kubernetes 也可以对接云服务商的自动扩容节点的接口, 在 集群资源不够的时候自动扩容 节点. 而在峰值过后, 自动删除这些副本 / 节点. 并且当 服务 / 应用 报错退出时, Kubernetes 也会自动的将服务重启.

* 管理
    * 你可以在 Kubernetes 上通过访问 ApiServer 很方便的对资源进行管理以及二次开发.

`Kubernetes` 还有一些其它特性:

* 自动装箱
    * 由于 Kubernetes 强依赖容器技术, 所有 应用 都将以容器的方式发布和管理, 配合前面自动扩缩容和自动部署的特性. 这样对整个集群来说, 在不牺牲可用性的前提下极大的提高了 整个集群的资源利用率.

那么接着我们先试探着来看一下 Kubernetes 的最简版结构图

![](/assets/Kubernetes架构-simplest.png)

Kubernetes 的架构是比较简单的, 我们可以看到 Master 部分有着 `ApiServer`, `Controller Manager`, `Scheduler` 这三个控制组件, 在 Worker Node 上, 有 `Kubelet` 这个组件, 我们简单介绍一下 这些组件, 不明白不要紧, 我们在下一 part 之后会详细解释.

## Kubernetes 解决了什么问题

了解一个软件或者系统最好的办法当然是阅读它的架构, 但为了更好的了解 Kubernetes , 我们可能需要先了解需求和问题.

最初我们在业务起步的时候都会使用单体应用, 即所有的服务都写在一起, 部署到一台专有的服务器中,

将服务安装到一台服务器上, 然后 DB , cache, MQ 部署到别的服务器上

![](/assets/kubernetes-1server.png)

在业务量上涨后, 单机无法支撑访问量, 便多开了几台服务器, 然后在前面做了一个负载均衡, 来提高 QPS.

![](/assets/kubernetes-2server.png)

但是这样做又带来一个问题, 以 Go/Java 这种编译型语言写的应用为例, 由于我们所有的功能都写在一个项目中, 也就是由一个 main 函数控制 , 那么在部署时, 会将所有的功能都运行起来.

![](/assets/kubernetes-3server.png)

但正如上图所示, 有一些调用频率很低的服务并不需要开这么实例, 但是由于我们的全部服务都写在一起, 造成这类服务占用着内存, 造成内存的浪费, 并且集群规模越大, 这样的浪费会越严重. 并且线上的很多服务器往往经常负载不高, 但如果让别的服务到这些机器上运行又会难以管理.

那看到这里有同学就会说啦, 用微服务 (Micro Services) 不就行了, 将 Service 拆分, 单独部署, 中间使用 RPC 之类的协议进行通信, 完美解决上面的资源浪费问题. 并且可以根据服务的特点很方便的横向扩展. 是的没错, 使用微服务确实是可以解决上面的问题, 但是使用微服务 (裸上) 又会带来新的问题 :joy: .

![](/assets/kubernetes-4server.png)

一方面是部署会变得麻烦, 如果没有方便的服务监视和管理工具的话, 服务的监控 / 重启 / 更新 / 日志收集 等的方面都较难解决. 另一方面更加难受, 一台机器上同时运行多个同一服务进程时, 一旦需要操作 / 写入 / 读取同一份文件时, 将变得非常蛋疼..., 并发写覆盖 / 文件锁, 并且如果这同一服务的多个进程用的同一份配置, 将监听同一端口, 我们还需要实现一个让它们监听不同端口的方法, 防止端口冲突. 当你把这一份方案给 Leader 看的时候, 绝对会被 Leader 锤爆狗头.:joy::joy::joy:

那有同学就说了, 用容器不就能解决这个问题了么? 确实, 但在当时容器技术还没有火起来被大量使用, 不过 像 Google 公司的 `Borg` 系统中就使用 Cgroup 实现了类似于容器的东西, 但不是所有公司都像 Google 这么超前和强力. 那么当时的一些公司使用了 虚拟机 完成这些工作.

![](/assets/kubernetes-5server.png)

基于虚拟化技术的一台宿主上再虚拟出多台虚拟机器, 限制每台机器资源用量, 随着访问量的提升逐步创建虚拟机器, 提升了单台机器的资源利用率, 并且可以较好的进行水平伸缩. 这样的方案在当时其实是很不错的方案了, 但是虚拟化技术也有一些问题, 一方面是会有一定的性能损失, 因为虚拟化技术会将虚拟机器中的机器指令翻译成宿主支持的机器指令, 中间这个转换翻译的过程会有一定的性能损失. 即便我的宿主是 `Ubuntu 19.04` , 虚拟机也是 `Ubuntu 19.04` , 也会有性能损失....

![](https://pic2.zhimg.com/80/20006deca0fccda0d536edd626835e9e_hd.jpg)

再一个就是虚拟机器的启动,  我们知道虚拟机的启动由于这个转换层的存在, 以及由于加载和启动的是完整的系统, 所以虚拟机的启动时间往往都以分钟为单位.

但是问题又来了, 开虚拟机是可以一定程度上解决上面的问题了, 但是我的虚拟机要怎么调度呢, 例如 这台机器资源不够, 不能将新的实例分配到这台机器, 得分配到别的机器. 于是当时就有了类似于 Openstack 这种平台级应用, 负责将下面所有的宿主机器对上层抽象, 上层只要关注虚拟机即可, 而无需关注宿主状态, 这些虚拟机间的调度将又 Openstack 来完成, 这就是传统的 Paas 平台.

后面的事情大家就知道了, Docker 出现后, 由于它轻量, 启动快, Docker Image 便于分享等特点, 和后面的 容器编排技术一起, 快速取代了以前的 传统 Paas 平台.

上面讲了这么多, 主要是想加深大家对 Kubernetes 解决了什么问题的印象.

* Kubernetes 将完成 服务的部署更新以及一定程度的监控和重启
* 解决了 容器调度 / 编排 等问题, 可以更大限度的使用服务器资源.
* 比较好的支持 有状态和无状态 的应用的部署
* 由于 Kubernetes 中的一切皆为 API 对象, 以及 所有的对象都采用了控制器模式来进行设计 (后面会讲到), 所以拥有更好的扩展性和普适性, 并且这样给了我们更大的想象空间.

## Kubernetes 是如何解决这些问题的 （Kubernetes 架构）

实际上, 并没有一个 二进制文件或者一个服务叫做 Kubernetes, Kubernetes 在希腊语中是 ` 舵手 ` 的意思, 正如同一艘船不可能只有一个舵手一样, Kubernetes 是一群组件的总称, 它们互相协作, 驶着这艘船驶向远方.

### 分布式应用

> Kubernetes 为什么采用这样的架构
>
> <https://zhuanlan.zhihu.com/p/55401096>

Kubernetes 整个系统的实质是一个 分布式应用, 而作为一个 分布式应用, 通常会有 Master / Worker 的区分, Master 就是 控制节点, 控制平面一般放在 Master 节点上 , 而 Worker 就是 执行节点, 在 Kubernetes 这种节点称为 Node, 例如 ElasticSearch , 它使用的是 选举然后出现 Master 的方式, 其它作为 Worker. 例如 ETCD , 使用的 Raft 算法来维持集群内的强一致. 但它们的这些做法是为了保证数据的强一致, 而 Kubernetes 作为一个 容器调度平台, 我认为并不需要上述这样的数据强一致性, 再一个方面, 使用这些选主算法会让 Kubernetes 过度复杂, 所以 Kubernetes 采用的是最简单的固定 Master 的方式. 然后 其它节点 Join 到 Master 中, 作为 Worker. 也就我们一开始给大家看到的这张图,

![](/assets/Kubernetes架构-simplest.png)

但我们也能看到如果 Master 节点只有一个, 很容易出现单点问题, 所以一个高可用的 Kubernetes 会有一些 Master 节点作为备用. 最简单的高可用 Kubernetes 如下图所示.

![](https://k8smeetup.github.io/images/docs/ha.svg)

而 Kubernetes 的高可用实质上是 Master 节点中 etcd/scheduler/controllerManager 这三个组件的高可用,

*  etcd 比较好解决, 直接 etcd 集群即可.

而 scheduler 和 controllerManager 就比较麻烦, 如果两个 scheduler 一起调度, 那么中间就很难协调.

* 所以 Kubernetes 的高可用方案是同时启动多个 scheduler , 但同时只允许一个 Scheduler 运行, 其余的 Scheduler 处于 pending 状态, 直到它们发现 scheduler 没有更新心跳信息, Scheduler 们将会尝试向 etcd 提交把自己作为 Leader 的请求, 由于 scheduler 之间不进行通讯, 利用 etcd 的 raft 的强一致性. 能够保证在分布式高并发情况下 leader 的全局唯一性 (这里的意思是说, 它只保证全局唯一性, 而不保证一定是第一个发起注册的 scheduler 抢到 Leader).


### Master

Master 中有 ` 一个数据库 ` 和 ` 三个核心组件 `

* `etcd` KV 数据库

* `Scheduler` 主要负责调度 Pod
* `ControllerManager` 主要各种 Controller 的关系
* `ApiServer` Api Getaway , Kubernetes 中最重要的组件


#### Kubenetes Scheduler

Scheduler 是 Kubernetes 的调度器, 顾名思义, 调度器的主要职责就是为新创建出来的 Pod 寻找一个最合适的节点, 不过有一定需要注意, 在将 Pod 调度与节点绑定并启动后, 是通常不会重新绑定到另一个节点的 (也有例外).


而 Scheduler 的结构也较为简单, 由 一个 数据收集 GoRoutine 和 实际负责调度的 GoRoutine 组成,

![](https://static001.geekbang.org/resource/image/90/9b/90343a090a8242ad46d2f82cb6b99b9b.png)



上方的 Informer 也就是刚刚说的数据收集 GoRoutine , 下方的 Scheduling 也就是刚刚说的实际负责调度的 GoRoutine .

数据收集 GoRoutine 有两个工作,

* 一方面是维持一个叫 Scheduler Cache 的缓存数据处于最新,  这样使得 实际负责调度的 GoRoutine 的 预选 (Predicates) 和 优选 (Priorities) 过程中就不需要疯狂的访问 etcd 来获取当前的集群数据, 直接读内存中的 cache 即可 , 加速了效率.
* 另一方面会 用 Channel 实现一个 队列, 这个队列有可能是 FIFO 队列, 也有可能是 优先队列, 这个根据调度策略的不同而不同. 当 一个 待调度的 Pod 被创建后, 数据收集 GoRoutine 会将这个 Pod 推入 这个 队列


而另一个方面, 负责实际调度的  GoRoutine 会不断从 队列中取出 Pod 进行分配. 这里分三个步骤, 前面两个步骤就是常常在 相关博客 里可以看到 ` 预选 ` 和 ` 优选 ` 的算法, 这两块是可以在 自定义实现算法后进行绑定.

1. ` 预选 `, 也称为 ` 过滤 `, 它会根据 剩余资源大小 以及  Pod 设置的 节点亲和性 (例如 node Label 选择器) 和 污点容忍度 等的指标来进行过滤, 初步筛掉 无法进行调度的 Node , 换而言之, 过滤之后的 Node 就是所有可以运行这个 Pod 的 宿主机列表.
2. ` 优选 `, 也就是在上面预选后 所有可以运行这个 Pod 的宿主机列表中, 为每一个 Node 进行打分, 选出 得分最高的 Node 作为本次调度的结果, 然后写入到 `scheduler Cache` 中 , 然后创建一个 GoRoutine , 由该 GoRoutine 异步去通知 ApiServer, 要求 ApiServer 更新数据. 此处异步出去处理的原因是不希望 Scheduler 因为 请求 ApiServer 而被阻塞. 另一方面, 你也会注意到这里是一个相当乐观的情况 ,  仅仅根据 etcd 中的历史数据就判断可以将 pod 分配出去, 所以之后 ApiServer 会委托 Kubelet 做二次确认.
3. ApiServer 在接到 请求后, 会询问 被分配节点的 Node 的 `kubelet`, 再次确认是否能够确实运行在 Node 上, 例如 端口是否占用 等的二次验证 , 如果无法满足, 则会分配失败.



#### Kubenetes Controller Manager

顾名思义, `Controller Manager` , 自然是用于管理 Controller , 类似于一个 Hub , 读取类似于 Controller 列表的东西, 将全部的 Controller 都跑起来, 并且监控它们的健康状态, 如果意外退出需要重新拉起.

那么控制器又是什么呢, 为什么需要管理控制器呢, 这里就需要讲到 Kubernetes 中广泛使用的 ` 控制器模型 `. 让我们以 Kubernetes 中比较常用的 Deployment  作为例子来简单介绍 这个控制器模型.

##### 控制器模型

Kubernetes 中容器部分最基础的也是最常用的 Object 是 Pod , 什么是 pod , pod 可以理解成一组容器的集合, 一个容器组

![ex](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LDAOok5ngY4pc1lEDes%2F-LpOIkR-zouVcB8QsFj_%2F-LpOIpxWBdVu8J2RPaEs%2Fpod.png?generation=1569161458538823&alt=media)

假设我们现在只有一个 Nginx 的 Pod, 如果只是部署一次, 那么很方便, 但是如果我们希望可以部署 二十个 Pod , 那么我们可以写一个脚本去部署它 XD, 但是这样实在是不优雅哈哈, 毕竟这个脚本只适合这个场景, 那么有没有什么办法可以较为优雅的来解决这个问题呢?

我们引入了一个叫 `ReplicaSet` 的 Object, 这个 Object 做什么事呢, 我可以对它设置一个叫 replicas 的属性 , 也就是副本数的意思, 假设我们设置这个 replicas 为 3 , 那么叫它去做什么事 呢, 当我设置 replicas 数为 3 的时候, 你 ReplicaSet 需要去为我启动 3 个 Nginx 的 Pod. 很简单的功能对吧, 但是我们实际上这样就已经完成了对 Pod 的功能的扩充. 这个时候 ReplicaSet 就是 Pod 的控制器, 它不关心 ReplicaSet 的实现, 它只是控制它的数量

那么我们在这个功能之上, 我们还想加入一个功能, 就是我可以很方便的在 ReplicaSet 之间回滚, 这个时候怎么办呢, 直接改 ReplicaSet 的代码好像不太好, 我们可不可以继续使用这个控制器模型呢?

我们又引入了一个 叫 Deployment 的 Object, 这个 Object 有个 Array , 会记录它下面控制过的 ReplicaSet 历史, 那么如果我们我们想用 A 版本的 ReplicaSet , 我们就让 Deployment 将现在的版本的 ReplicaSet 的 replicas 属性的数量标记为 0 , 然后将 A 版本的 ReplicaSet 的 replicas 属性设置为 3 , 那么我们就完成了 这个回滚的功能, Deployment 此时就是 ReplicaSet Object 的控制器, 它不关心 ReplicaSet 的实现, 它只是控制 ReplicaSet .

那么控制链即如下所示,

`Deployment` => `ReplicaSet` => `Pod`

#####  Controller

通常一类 Object 就有一类对应的控制器控制它的行为, 你可以翻到 Kubernetes Github Repo 的 [pkg/controller](https://github.com/kubernetes/kubernetes/tree/master/pkg/controller) 下查看默认的 controller .

#### Kubenetes ApiServer

ApiServer 相比上面两种 组件, 虽然是 Kubernetes 中最重要的组件, 而结构上则朴素得多, 他是一个标准的 Api 服务器, 主要负责如下工作:

* 提供了集群管理的 REST API 接口
  * 包括认证授权、数据校验以及集群状态变更
* 提供其他模块之间的数据交互和通信的枢纽
  * 其他模块通过 API Server 查询或修改数据，只有 API Server 才直接操作 etcd
* 是资源配额控制的入口
* 拥有完备的集群安全机制

#### Master 结

那么 Master 部分的三个组件我们就说完了 , 接着我们来看 Worker 上的组件

![](/assets/Kubernetes架构-simple.png)

### Worker

那么既然已经确定了 控制平面 结构, 那么自然来到最关心的点, 如何实现将 一个容器 在  Node 上变成 Running 状态呢 ?

#### Kubelet

这里首先介绍 Worker 上 最重要的组件, 也是 整个 Kubernetes 上第二重要的组件 `Kubelet` , kubelet 是 在每个节点上运行的主要 ` 节点代理 `. 用来调度到到本节点的任务, 管理 Pod 和其他资源, Kubelet 也会定期上报资源等.

你可以把 Kubelet 想象成 Kubernetes 在 Node 节点上的大管家.

![](https://static001.geekbang.org/resource/image/91/03/914e097aed10b9ff39b509759f8b1d03.png)


然后从上面的工作原理图, 我们可以看到 Kubelet 在一启动就向 ApiServer 注册 Listers , 订阅关注的各种事件, 然后接着 就启动各种 Watcher 关注主机上的状态以及与 初始化等下要讲的各种插件.

接着它会启动  多个 GoRoutine 负责主机上多个信息的监视和处理, 例如

* Node Status Manager
* StatusManager
* Volume Manager
* Image Manager
* 等等....

到此 Kubelet 就初始化完毕, 接着他会从四个源获取指令和消息后

* ApiServer 这个是最主要的 信息源, 他们中间实现了一个 Watch 的订阅机制, 来及时推送事件给 Kubelet, 猜测是通过 TCP 连接等的方式实现的长连接来及时获取消息, 也有可能是 kubelet 做了一个 http server , 然后接受 APiServer 主动访问推送. 我猜测第一种的可能多点, 有空等看了源码再做详解
* 其次在 Kubelet 在某些情况下也会访问 ApiServer , 去主动 pull 信息, 这个也很容易理解, 毕竟有一些集群相关的消息 Kubelet 也需要知道
* 他还支持 接受信息的主动推送到 httpServer
* 以及 将 yaml 文件放到 某个文件夹的方式启动 pod , 这个方式叫做 static Pod ,


在获取到指令后, kubelet 需要为 container  启动容器 , 分配存储的 Volume 以及  设置网络, 而这些操作通常都不是由 kubelet 来完成, 而是由 相应接口的插件来完成, Kubelet 只是调用这些接口而已, 毕竟众口难调, 各家需要的 特性都不同, 不可能每一个人都去 fork kubernetes/kubernetes 然后加一个自己的插件, 这些特性也不可能全部的放在 Kubernetes/Kubernetes 中, 所以 将这些特性做成接口, 只要实现了这些接口, 就可以顺利的被 Kubernetes 调用.

这些接口分别是  CRI/CNI/CSI 对应 ` 容器运行时 `/` 容器网络 `/` 容器存储 `, 让我们从 CRI 容器运行时 开始.

#### CRI (Container Runtime Interface)

在说 CRI , 我们需要理解下 OCI:

##### OCI

OCI 是一个围绕 ` 容器格式 ` 和 ` 运行时 ` 创建开放的行业标准, 主要包含以下三个部分 (原文可以参考 [github open Containers](https://github.com/opencontainers) 这个 组织下的项目)

*  [Runtime Specification](https://github.com/opencontainers/runtime-spec)(运行时规范)
* [Image Format](https://github.com/opencontainers/image-spec)(镜像规范)
* [Distribution Specification](https://github.com/opencontainers/distribution-spec)(分发规范)

而这个规范下, 第一个 Runtime 的参考实现 是由 docker 公司将 `libcontainer` 的实现移动到 [runC](https://github.com/opencontainers/runc) 并捐赠给了 OCI,

<img src="https://landscape.cncf.io/logos/runc.svg" width="200px">

那么如何理解 runC ? Docker 应该各位都用过, 这里是一张 Docker 的总架构图.

![](https://static001.infoq.cn/resource/image/6b/b7/6bb88d09ae816dce9a1ee3b6ae9c87b7.jpg)

那 containerd 又是什么, 这里也可以借助 上面 的 docker 总架构图说明,

<img src="https://landscape.cncf.io/logos/containerd.svg" width="200px">

 从 Docker 1.11 之后，Docker Daemon 被分成了多个模块以适应 OCI 标准。拆分之后，结构分成了以下几个部分。其中，`containerd` 独立负责容器运行时和生命周期（如创建、启动、停止、中止、信号处理、删除等），其他一些如镜像构建、卷管理、日志等由 Docker Daemon 的其他模块处理。

我们参照这一张图和上一张图, 相信聪明的你一定能找到答案 XD,

![](https://static001.infoq.cn/resource/image/84/dd/84fcf0f6be6b7b5d0dda7b3fe086acdd.png)



#####  ` CRI`

CRI 是一个相当美好的愿景, 可是由于 Kubernetes 有着在早期的时候仅仅只支持 Docker 的历史包袱, 于是在 Kubernetes 1.5 的时候自行实现了 一个 叫做 `DockerShim` 的东西, 用于初步的将 docker 和 kubelet 分离开,

大概如下图所示,

![](https://xuanwo.io/2019/08/06/oci-intro/cri-docker.png)



shim 的中文翻译是 垫片的意思, 也就是我仅仅通过 CRI 协议 去连接不同的 shim , 就可以实现对容器运行时的实现的替换.   但这个实现的调用链还是有点过长 , 于是从 containerd 1.0 开始, containerd 开发了一个新的 daemon , 叫做 CRI-Containerd. 直接支持了 CRI 协议通信, 从而移除了 Dockershim.

![](https://xuanwo.io/2019/08/06/oci-intro/cri-containerd.png)

但是这样依旧多了一个 daemon, 于是从 containerd 1.1 开始, 进一步缩短调用链, 将 CRI 协议以 plugin 的形式, 集成到了 containerd 中.

![](https://xuanwo.io/2019/08/06/oci-intro/containerd-built-in-plugin.png)



但是这样依旧不是终点, 能否由把中间的 containerd 也一起拿掉, 直接由 kubelet 中的 某个插件 来通过协议控制 运行时呢?  来进一步降低开销, 答案是肯定的, 社区孵化了 CRI-O, 其中 O 也就是 OCI, 有兴趣可以到 [cri-o Repo](https://github.com/cri-o/cri-o) 看相关介绍.

<img src="https://landscape.cncf.io/logos/cri-o.svg" width="200px">

但是到目前位置, 由于 containerd 已经经历过各种场景下的考验,  所以目前 Kubernetes 默认使用的仍然是 containerd 那一套, 结构示意图如下所示:

![](https://static001.geekbang.org/resource/image/70/38/7016633777ec41da74905bfb91ae7b38.png)

最后用 [@xuxinkun](https://xuxinkun.github.io/) 的图总结下

![](https://xuanwo.io/2019/08/06/oci-intro/kubelet.png)



#### CNI (Container Network Interface)
<img src="https://landscape.cncf.io/logos/container-network-interface-cni.svg" width="200px">

CNI 和 CSI 我真没看太懂..... 待补充...

#### CSI (Container Storage Interface)

<img src="https://landscape.cncf.io/logos/container-storage-interface-csi.svg" width="200px">

#### Kube-Proxy




### Kubectl

Kubectl 是我们使用 k9s 之前最常使用的命令 (K9S 是什么等会儿会说明), kubectl 是 Kubernetes 的一个 Client , 他可以发送各种请求操作 ApiServer 进而进行资源控制和查询, 可以把他理解成我们常常使用的  Docker 命令 (Docker 也是 Server-Client 结构的, 我们常常使用的 Docker 命令是 Client 端).


## Kubernetes 如何将一个 Yaml 变成 一个运行在 Kubernetes 中的 一个 Pod

接着, 在这个位置, 我们将我们前面说的组件, 搭配起来进行合作, 假设我们现在需要提交这样的一个 nginx.yaml 文件, 那么它是如何变成一个在 Kubernetes 中活跃的 Pod 的呢

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mynginx0
  labels:
    name: mynginx0
spec:
  containers:
  - name: helloNginx
    image: nginx:latest
    ports:
    - containerPort: 80
```

![](https://yqintl.alicdn.com/b5d6fe9d9e92f9a12f92408e02de5cd6d15b57d8.png)

### 提交

首先我们会使用 `kubectl apply nginx.yaml`, 这个命令就是将读取该 yaml 文件, 并将他发送到 ApiServer, 告知 ApiServer 你需要启动一个名为 `mynginx0` 的 Pod,

![](http://res.cloudinary.com/dqxtn0ick/image/upload/v1512807164/article/kubernetes/arch/k8s-arch.jpg)

### 处理和调度

ApiServer 在确定集群里没有名字叫 `mynginx0` 的 pod 后, 会将提交的原始 yaml 记录到 etcd 中,  接着 Replication Controller 在获知到该 Pod 与预期状态不符合时, 会要求创建该 Pod , 随后, Scheduler 就会在他的队列中读到一个待调度的 Object, 然后通过 Node 筛选, 最后 由 APiServer 将调度结果写入 etcd 中.

### 运行

随后, 由于 kubelet 通过 watch 机制订阅了 ApiServer 中的事件, kubelet 将会接受到一个 Pod update 的请求, 他将会 调用 接口, 创建出该容器, 并上报.

至此, 一个配置文件就这样变成了容器出现在了集群中.

## 我们现在如何使用 Kubernetes

### API Object

在 Kubernetes 中, 有若干的 Api Object 可以被使用, 我们常用的包括如下这些 这里简单的介绍一些:

* Deployment

Deployment 此前介绍过了,

Deployment => ReplicaSet => Pod

* CronJob

CronJob => Job

* ConfigMap

ConfigMap 对应的是一个或者多个 etcd KV 数据库中的字段

* Horizontal Pod Autoscaler

HPA 是一个水平扩展器, 可以根据 CPU 和 内存的使用量 水平扩容

* Service

将运行在一组 Pods 上的应用程序公开为网络服务的抽象方法。自带 DNS

* Volume

声明 存储空间

### 和 Jenkins 协作

* Muc Jenkins Client
  * 一个 自行实现的 Jenkins Client, 主要功能包括
    * 触发上线 CICD Pipeline
    * 查看 对应环境中的 服务状态 (k8s/consul)
    * 服务健康检查
    * 起停服务

* Jenkins Pipeline
  * 各种可以被触发的任务

### 整体结构

// Private

## What's Next


### 如何 Running 自己的第一个 Kubernetes

你可能见过这两个项目 `MiniK8S` 和 `MicroK8S` , 你可能还见过 `k3S` 和 `K9S` 以及 `KubeAdm` 这几个项目. 那么下面我们就来讲讲它们的区别和 如何跑起来自己的第一个 Kubernetes.

首先来的是 `MiniK8S` 和 `MicroK8S` 这一对, 这两个开源软件都可以快速帮你搭建起一个开发用的本地 Kubernetes 节点.

MiniK8S 是 由社区和 Kubernetes-sig 维护的, 支持 MacOS/Linux/Windows 的本地 Kubernetes 节点管理工具. 它支持在 `KVM`/`Vagrant(VirtualBox)` 创建的虚拟机内初始化 Kubernetes , 也支持在直接将 Kubernetes 安装在宿主机中. MiniK8S 可以下载 GitHub 上 Release 的 二进制文件到本地, 然后一键安装 Kubernetes . 功能上对于本地测试的场景完全够用, 也支持安装一些插件.

<img src="https://github.com/kubernetes/minikube/raw/master/images/logo/logo.png" width="200px">

![](https://github.com/kubernetes/minikube/raw/master/site/content/en/start.png)

MicroK8S 是由 Ubuntu 团队维护的 , 支持在多种场景下安装 轻量级 Kubernetes 的管理工具, MicroK8S 将目标放在小而简单的运行场景, 用于快速验证, 并且安装也挺方便, 你可以通过 Snap 包管理工具将它安装在 Linux 上. 你也可以在安装 Ubuntu 系统的时候一起安装到 系统中.  MicroK8S 目前因为直接安装在 宿主机上的关系, 目前仅支持 Linux 平台. 这个笔者也没有用过... 建议如果感兴趣的访问下托管在 github 的 `ubuntu/microk8s` 深入了解

接下来是 `K3S` 和 `K9S`, 虽然它们的名字看起来和 `K8S` 很像, 但是实际上, 它们其实有一些不一样的用途,

K3S 号称是史上最轻量的 Kubernetes (毕竟 `5 less than K8S`) , 由知名的 Kubernetes 云服务商 Rancher 和社区 维护, 推荐的使用场景 在于边缘计算 , 物联网, ARM 以及 CI 调度上, 它移除了一些这些场景下不需要的特性和 Alpha 的测试特性, 并删除部分内置的插件, 可以用外部插件替换 (CSI/CNI), 并且将默认的 etcd3 替换成 SQlite3. 个人觉得不太适合用于本地开发测试 .

而 K9S 是一个 Terminal 下的挺方便的一个 Kubernetes dashboard, 由个人开发者维护. 如果有同学用过 针对 docker 开发管理的 `dockly` 的话, 这个 K9S 类似于 Kubernetes 的 dockly, 你可以在 k9s 里管理你的 Kubernetes 集群, 查看 各种 Api Object 的状态, 并且选择某一个 Object 看 Describe 和 log 以及 edit 等更多操作, 针对 Pod 可以通过 K9S 直接进入容器. 这个对于不想记命令或者初学 Kubernetes 的同学来说是相当方便. 你就不需要 kubectl 的一个命令一个命令的去敲了, 直接上下左右的选取就行了.

![](https://github.com/derailed/k9s/blob/master/assets/k9s.png)

![](https://github.com/derailed/k9s/raw/master/assets/screen_po.png)

那么最后就是 KubeAdm , KubeAdm 上是 Kubernetes 的安装工具. 我们知道, 通常 分布式应用安装起来都十分麻烦, 手动安装 Kubernetes 能直接把新手劝退, 你需要登录每个节点去拉代码, 配 IP, 配证书 , 出一个问题跑几台机器看日志. 于是社区便八仙过海 - 各显神通, 各式各样方便 Kubernetes 安装部署的脚本就出来了, 有以 shell 的方式复制到各台机器上一键部署的, 有用 ansible 批量安装的等等, 最后 有一位 芬兰的 18 岁高中生, 写了 Kubeadm , 它的方式是在 Master 上安装了 kubelet 之后, 使用 `kubeadm init` 以容器的方式拉下来其它组件并运行, 然后在 node 上, 安装了 kubelet 之后, 只需要 `kubeadm join token` 即可加入集群, 极大的方便了部署, 省略了中间尤其是配证书的步骤.

最后总结一下:

如果打算先玩一下 Kubernetes , 并且不希望出现太多问题的话, 推荐 MiniK8S, 以虚拟机的方式部署.

如果打算深入 Kubernetes , 想搭建集群 , 并且有自己的额外机器, 并且出问题也愿意克服的话, 推荐 KubeAdm + K9S 进行搭建.

最后, 如果不知道怎么选就选 `MiniK8S` 就行了

### How to do better!!

好的, 假设你已经开启了你的第一个 Kubernetes 集群, 并部署了一些 App 和 服务在 Kubernetes 上, 那么我还能做一些什么让它变得更好呢?


#### 如何扩展 Kubernetes (Operator/Custom Controller/Custom Scheduler)

> <Kubernetes operator 的生命周期>

此处需要查阅更多资料

#### Helm VS Kustomize

#### Istio


#### more....

* kubeflow
  *
* openshift
  *

#### 如何参与到 Kubernetes 的开发中

Kubernetes 的社区是以 `Sig` 和 ` 工作组 ` 的形式组织起来的. 每个工作组都会定期召开视频会议.

##### kubernetes sig

sig 全称是 `Special Interest Group`, 翻译成中文也就是 特别兴趣小组, CNCF 下的项目基本都是 sig 的形式进行维护.

任何人可以对 Kubernetes 发起 PR , 在有五个 实质性 PR 后, 可以开始申请加入 (修改 成员列表后发起 PR, 我觉得这个方式很酷 XD).

* 你需要事先找到两个 sig 的成员来支持你加入 sig (可以在 slack 或者 邮件列表中 寻求支持)
* 然后在 你的 申请加入的 PR 中 at 他们, 要他们来 +1
* 接着 在你的 成员资格获得批准后, 恭喜你 成为了 Kubernetes sig 的一员

在 sig 中, 常见的有两种角色:

* 审核人, 负责审核 PR ,
  * 审核人可以向 pr 添加 评论 `/lgtm` (Looks Good To Me) 或者 来表示你审核过后无异议, 已经 review 可以合并
  * 发送 `/hold` 防止被合并, 然后在修改完成后, 可以回复 `/hold cancel` 表示正常

* 批准人, 批准人有能力合并和审核 PR
  * 批准人回复 `/approve` 来表明同意合并

主要的 Sig 列表:

![](https://jimmysong.io/kubernetes-handbook/images/kubernetes-sigs.jpg)

## 结

最后, 这个这里用到的各种图基本都是从互联网上 各位大佬的博客 以及 极客时间专栏里 Copy 出来的, 由衷感谢各位大佬的分享.

## 附录: 各种 Kubernetes 架构图

![](http://res.cloudinary.com/dqxtn0ick/image/upload/v1512807164/article/kubernetes/arch/k8s-arch.jpg)

![](https://raw.githubusercontent.com/kubernetes/kubernetes/release-1.3/docs/design/architecture.png)

ref:

> [time.GeekBang.org/ 深入剖析 Kubernetes](https://time.geekbang.org/column/intro/116)
>
> [穷人也能用得起 K8s - VPS 单节点部署 Kubernetes 的方法与对比](https://avnpc.com/pages/kubernetes-for-single-vps#kubernetes-%E5%8D%95%E8%8A%82%E7%82%B9%E9%83%A8%E7%BD%B2%E6%96%B9%E5%BC%8F%E5%AF%B9%E6%AF%94)
>
> [深入剖析 Kuberetes - geekbang](https://time.geekbang.org/column/intro/116)
>
> [Helm]()
>
> [Kubernetes Sig]()
>
> [Kubernetes kube-controller-manager 控制中心机制源码深入剖析 - Kubernetes 商业环境实战](https://juejin.im/post/5d614862f265da03b31bd897#heading-0)
>
> [CNCF Cloud Native Interactive Landscape](https://landscape.cncf.io/fullscreen=yes&zoom=120)
>
> [开放容器标准 (OCI) 内部分享](https://xuanwo.io/2019/08/06/oci-intro/)
>
> [白话 Kubernetes Runtime](https://aleiwu.com/post/cncf-runtime-landscape/)
>
> [kube-apiserver watch 实现](http://likakuli.com/post/2019/08/21/apiserver_watch)
>
> [Kubernetes 社区是如何运作的系列之三——治理细则](http://ocselected.org/posts/community_management/how_kubernetes_community_works_3/)
>
> [Participating in SIG Docs](https://kubernetes.io/docs/contribute/participating/)
>
> [LGTM? 那些迷之缩写](https://farer.org/2017/03/01/code-review-acronyms/)
