# Kubernetes 新晋指北

> 内部分享稿
>
> 由简到繁
>
> 定位在 入门 和 进阶
>
> 这次分享的目的是 主要讲清楚 Kubernetes 如何实现他的编排能力 和 现阶段我们使用 Kubernetes 的方式

[TOC]

## 背景简介


<!-- TODO 待修改 -->
在 Docker 实现了更轻量的打包方式 (相较虚拟机), 并让 容器技术 成为当年的当红辣子鸡之后, 若停留于此, 那么 Docker 或者容器化技术就仅仅 只是一个开发者手头上的玩具. 若要将其发扬光大, 而若将 Docker / 容器化技术用于 DevOps 领域 或者 在服务端代替 现有的虚拟机方案, 都还有很多工作要做. 于是 很多大厂便开始将 目光转向容器编排领域, 当时各家提出了很多方案, 例如

* Docker 的 Docker Swarm ,
* Google 和 RedHat 主导的 Kubernetes,
* 加州大学伯克利分校 开发的 Mesos 套件, 后应用于 Twitter/Airbnb 等公司.
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

`Kubernetes` 还有一些其他特性:

* 自动装箱
    * 由于 Kubernetes 强依赖容器技术, 所有 应用 都将以容器的方式发布和管理, 配合前面自动扩缩容和自动部署的特性. 这样对整个集群来说, 在不牺牲可用性的前提下极大的提高了 整个集群的资源利用率.

那么接着我们先试探着来看一下 Kubernetes 的架构

![Kubernetes 的架构]()

Kubernetes 的架构是比较简单的, 我们可以看到 Master 部分有着 `ApiServer`, `Controller Manager`, `Scheduler` 这三个控制组件, 在 Worker Node 上, 有 `Kubelet` 这个组件, 我们简单介绍一下 这些组件, 不明白不要紧, 我们在下一 part 之后会详细解释.

## Kubernetes 解决了什么问题

了解一个软件或者系统最好的办法当然是阅读他的架构, 但为了更好的了解 Kubernetes , 我们可能需要先了解需求和问题.

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
* 由于 Kubernetes 中的一切皆为 API 对象, 以及 所有的对象都采用了控制器模式来进行设计 (后面会讲到), 所以拥有更好的扩展性和普适性, 并且这样给了我们更大的想象空间.

## Kubernetes 是如何解决这些问题的 （Kubernetes 架构）

实际上, 并没有一个 二进制文件或者一个服务叫做 Kubernetes, Kubernetes 在希腊语中是 ` 舵手 ` 的意思, 正如同一艘船不可能只有一个舵手一样, Kubernetes 是一群组件的总称, 他们互相协作, 驶着这艘船驶向远方.

### 分布式应用

> Kubernetes 为什么采用这样的架构
>
> <https://zhuanlan.zhihu.com/p/55401096>

Kubernetes 整个系统的实质是一个 分布式应用, 而作为一个 分布式应用, 通常会有 Master / Worker 的区分, Master 就是 控制节点, 控制平面一般放在 Master 节点上 , 而 Worker 就是 执行节点, 在 Kubernetes 这种节点称为 Node, 例如 ElasticSearch , 它使用的是 选举然后出现 Master 的方式, 其他作为 Worker. 例如 ETCD , 使用的 Raft 算法来维持集群内的强一致. 但他们的这些做法是为了保证数据的强一致, 而 Kubernetes 作为一个 容器调度平台, 我认为并不需要上述这样的数据强一致性, 再一个方面, 使用这些选主算法会让 Kubernetes 过度复杂, 所以 Kubernetes 采用的是最简单的固定 Master 的方式. 然后 其他节点 Join 到 Master 中, 作为 Worker. 也就我们一开始给大家看到的这张图,

![](Kubernetes 架构 simple)

但我们也能看到如果 Master 节点只有一个, 很容易出现单点问题, 所以一个高可用的 Kubernetes 会有一些 Master 节点作为备用. 最简单的高可用 Kubernetes 如下图所示.

![](https://k8smeetup.github.io/images/docs/ha.svg)

而 Kubernetes 的高可用实质上是 Master 节点中 etcd/scheduler/controllerManager 这三个组件的高可用, etcd 比较好解决, 直接 etcd 集群即可. 而 scheduler 和 controllerManager 就比较麻烦, 如果两个 scheduler 一起调度, 那么中间就很难协调. 所以 Kubernetes 的高可用方案是同时启动多个 scheduler , 但同时只允许一个 Scheduler 运行, 其余的 Scheduler 处于 pending 状态, 直到他们发现 scheduler 没有更新心跳信息, Scheduler 们将会尝试向 etcd 提交把自己作为 Leader 的请求, 由于 scheduler 之间不进行通讯, 利用 etcd 的 raft 的强一致性. 能够保证在分布式高并发情况下 leader 的全局唯一性 (这里的意思是说, 他只保证全局唯一性, 而不保证一定是第一个发起注册的 scheduler 抢到 Leader).


### Master

Master 中有三个核心组件, Scheduler / ControllerManager / ApiServer

#### Kubenetes Scheduler

Scheduler 是 Kubernetes 的调度器, 

> <Kubernetes Scheduler 解密>

#### Kubenetes Controller Manager


#### Kubenetes Api-Server

> <Kubernetes Controller Manager>
>
> <Kubernetes Api-Server>


tips:

1. Master Node 如何调度 / 伸缩 / 服务发现。(Controller/Scheduler/ApiServer/Etcd)

### Worker

那么既然已经确定了集群结构, 那么自然来到最关心的点, 如何实现将 我写的一个容器 放到 Node 也就是机器上呢, 这里以 Nginx:latest 为例, 这个必然首先由 Master 发出一条请求, 告诉 某一个 Worker 节点, 你需要启动一个  Nginx:latest 这个容器, 然后 给限制它的内存和 CPU.

那么 Worker 上的 客户端 收到这个 请求后, 就需要着手开始准备了, 首先 由于默认使用 Docker 作为容器技术, 那么将使用 Docker 启动容器运行时 (CRI), 然后将 磁盘挂载 (CSI), 接着挂载 网络 (CNI), 接着注册回 Master 节点上,

#### Kubelet 

> <Kubelet 的功能>

#### CRI

> <Kubernetes CRI && OCI >

##### OCI

#### CNI

> <Kubernetes CNI >

#### CSI


### Kubectl

> <KubeCtl 是什么>


## Kubernetes 如何将一个 Yaml 变成 一个运行在 Kubernetes 中的 一个 Pod

假设我们现在需要提交这样的一个 Yaml , 那么他是如何变成一个在 Kubernetes 中活跃的 Pod 的呢

```yaml
apiversion: v1
kind: pod
label:


spec:

```

### 提交

通过 Kubectl 提交 yaml 文件

### 处理

### 调度

### 运行

此处需要查阅更多资料

最好能穿插一些源码

> <Kuberntes Deployment 的生命周期>

## 我们现在如何使用 Kubernetes

### API Object

在 Kubernetes 中, 有若干的 Api Object 可以被使用, 我们常用的包括如下这些, 将逐个介绍:

* Deployment
* CronJob
* ConfigMap
* Horizontal Pod Autoscaler
* Service
* Volume

### 和 Jenkins 协作

* Muc Jenkins Client
* Jenkins Pipeline

### 整体结构

// 此处隐藏

![结构图]()


## What's Next


### 如何 Running 自己的第一个 Kubernetes 

你可能见过这两个项目 `MiniK8S` 和 `MicroK8S` , 你可能还见过 `k3S` 和 `K9S` 以及 `KubeAdm` 这几个项目. 那么下面我们就来讲讲他们的区别和 如何跑起来自己的第一个 Kubernetes.

首先来的是 `MiniK8S` 和 `MicroK8S` 这一对, 这两个开源软件都可以快速帮你搭建起一个开发用的本地 Kubernetes 节点.

MiniK8S 是 由社区和 Kubernetes-sig 维护的, 支持 MacOS/Linux/Windows 的本地 Kubernetes 节点管理工具. 它支持在 `KVM`/`Vagrant(VirtualBox)` 创建的虚拟机内初始化Kubernetes , 也支持在直接将 Kubernetes 安装在宿主机中. MiniK8S 可以下载 GitHub 上 Release 的 二进制文件到本地, 然后一键安装 Kubernetes . 功能上对于本地测试的场景完全够用, 也支持安装一些插件.

![](https://github.com/kubernetes/minikube/raw/master/images/logo/logo.png)
![](https://github.com/kubernetes/minikube/raw/master/site/content/en/start.png)

MicroK8S 是由 Ubuntu 团队维护的 , 支持在多种场景下安装 轻量级 Kubernetes 的管理工具, MicroK8S 将目标放在小而简单的运行场景, 用于快速验证, 并且安装也挺方便, 你可以通过 Snap 包管理工具将他安装在 Linux 上. 你也可以在安装 Ubuntu 系统的时候一起安装到 系统中.  MicroK8S 目前因为直接安装在 宿主机上的关系, 目前仅支持 Linux 平台. 这个笔者也没有用过...建议如果感兴趣的访问下托管在 github 的 `ubuntu/microk8s` 深入了解

接下来是 `K3S` 和 `K9S`, 虽然他们的名字看起来和 `K8S` 很像, 但是实际上, 他们其实有一些不一样的用途, 

K3S 号称是史上最轻量的 Kubernetes (毕竟 `5 less than K8S`) , 由知名的 Kubernetes 云服务商 Rancher 和社区 维护, 推荐的使用场景 在于边缘计算 ,物联网, ARM 以及 CI调度上, 它移除了一些这些场景下不需要的特性和 Alpha 的测试特性, 并删除部分内置的插件, 可以用外部插件替换 (CSI/CNI), 并且将默认的 etcd3 替换成 SQlite3. 个人觉得不太适合用于本地开发测试 .

而 K9S 是一个 Terminal 下的挺方便的一个 Kubernetes dashboard, 由个人开发者维护. 如果有同学用过 针对 docker 开发管理的 `dockly` 的话, 这个 K9S 类似于 Kubernetes 的 dockly, 你可以在 k9s 里管理你的 Kubernetes 集群, 查看 各种 Api Object的状态, 并且选择某一个 Object 看 Describe 和 log 以及 edit 等更多操作, 针对 Pod 可以通过 K9S 直接进入容器. 这个对于不想记命令或者初学 Kubernetes 的同学来说是相当方便. 你就不需要 kubectl 的一个命令一个命令的去敲了, 直接上下左右的选取就行了.

![](https://github.com/derailed/k9s/blob/master/assets/k9s.png)

![](https://github.com/derailed/k9s/raw/master/assets/screen_po.png)

那么最后就是 KubeAdm , KubeAdm 上是 Kubernetes 的安装工具. 我们知道, 通常 分布式应用安装起来都十分麻烦, 手动安装 Kubernetes 能直接把新手劝退, 你需要登录每个节点去拉代码,配 IP,配证书 , 出一个问题跑几台机器看日志. 于是社区便八仙过海-各显神通, 各式各样方便 Kubernetes 安装部署的脚本就出来了, 有以 shell 的方式复制到各台机器上一键部署的, 有用 ansible 批量安装的等等, 最后 有一位 芬兰的 18岁高中生, 写了 Kubeadm , 他的方式是在 Master 上安装了 kubelet 之后, 使用 `kubeadm init` 以容器的方式拉下来其他组件并运行, 然后在 node 上, 安装了 kubelet 之后, 只需要 `kubeadm join token` 即可加入集群, 极大的方便了部署, 省略了中间尤其是配证书的步骤.  

最后总结一下:

如果打算先玩一下 Kubernetes , 并且不希望出现太多问题的话, 推荐 MiniK8S, 以虚拟机的方式部署.

如果打算深入 Kubernetes , 想搭建集群 ,并且有自己的额外机器, 并且出问题也愿意克服的话, 推荐 KubeAdm + K9S 进行搭建.

最后, 如果不知道怎么选就选 `MiniK8S` 就行了

### How to do better!!

好的, 假设你已经开启了你的第一个 Kubernetes 集群, 并部署了一些 App 和 服务在 Kubernetes 上, 那么我还能做一些什么让它变得更好呢?


#### 如何扩展 Kubernetes (Operator/Custom Controller/Custom Scheduler)

> <Kubernetes operator 的生命周期>

此处需要查阅更多资料

#### Helm

#### Kustomize

#### Istio


#### 如何参与到 Kubernetes 的开发中

> <Kubernetes Sig>


ref: 

> [穷人也能用得起 K8s - VPS 单节点部署 Kubernetes 的方法与对比](https://avnpc.com/pages/kubernetes-for-single-vps#kubernetes-%E5%8D%95%E8%8A%82%E7%82%B9%E9%83%A8%E7%BD%B2%E6%96%B9%E5%BC%8F%E5%AF%B9%E6%AF%94)
> 
> [深入剖析 Kuberetes - geekbang](https://time.geekbang.org/column/intro/116)
> 
> [Helm]()
>
> [Kubernetes Sig]()