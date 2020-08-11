
# Service Mesh 预研 && Roadmap

[TOC]

### Service mesh struction

Service Mesh 目前 的 最主要实现是 `istio` , 阿里云的 ASM (Aliyun Service Mesh) 也是 基于 (istio 1.4.6 )魔改.

蚂蚁金服 曾经 自己起一个 `SOFAMesh` 项目, 来实现用蚂蚁的 MOSN 代替 Envoy ,  但后面也 Archived 了 SofaMesh.  转而直接向 Istio 贡献, 所以可以说 Istio 是现在 Service Mesh 的事实标准.



#### Istio 结构

v1.4 (ASM)

![](https://istio.io/v1.4/docs/ops/deployment/architecture/arch.svg)

v1.6 

![1.6](https://istio.io/latest/zh/docs/ops/deployment/architecture/arch.svg)

因为 v1.6 的结构相较 v1.4 的结构更简单易懂, 所以下面将会使用 v1.6 结构的 来介绍 Istio .

首先 Istio 的结构其实相对简单, 而且和 [Kubernetes 的结构](https://d33wubrfki0l68.cloudfront.net/d35c2b375b43b4fa374ae834f95224975418e33f/6b47b/images/blog/2018-06-05-11-ways-not-to-get-hacked/kubernetes-control-plane.png)很像. 分为 `控制平面` 和 `数据平面`.

##### 数据平面

和 Kubernetes 一样  , 数据平面  负责 具体功能的处理. Istio 的数据面只有一种组件, 也就是 Envoy , Envoy 用 C++ 编写,  功能和 Nginx 类似,  提供 Proxy 的能力 , 但比 Nginx 支持更多云原生方面的特性, 例如动态服务发现,故障注入,熔断器等, 且性能也不输 Nginx 太多. 

虽然数据平面的 组件只有一种, 但是 Envoy的数量 可不少, 因为 Envoy 需要劫持 流量的缘故, 所以每一个加入 Istio Service Mesh 的 Pod 都会被注入一个 Envoy 的实例.就像上面结构图上画的那样.  

同时 Envoy 作为 Istio 动作的实际执行者, 还参与 如流量劫持和服务发现, TLS,  Metrics 生成, 链路监控 等的特性.

##### 控制平面

控制平面的组件就比较多, 有三种, 负责 管理集群层面的各种事项.

* Pilot (类似于 Kubernetes 中的Controller)

  * 下发服务列表
  * 流量调度
  * 控制弹性功能

  ![](https://d33wubrfki0l68.cloudfront.net/4e385fc1d44b1bbacebfa944b908b8920a71be9e/a21c7/latest/zh/docs/ops/deployment/architecture/discovery.svg)

* Citadel

  * 负责 身份和证书管理

* Galley (类似于API Server)

  * 直接与 istioctl 交互
  * 下发配置
  * 负责与 Kubernetes 等平台交互

#### Istio 特性列表

Istio 的特性有很多, 这里长话短说 总结成几个方面

* 流量管理
  * 因为 Envoy Sidecar 可以完全劫持流量, 再加上控制面对 Envoy Sidecar 的控制, 这里就可以做到非常完整的流量管理. 
  * 还包括熔断器, 重试机制, 超时机制,故障注入等的,  这些网络弹性相关的特性都可以在 Envoy Sidecar 中做到.
* 可观测性
  * 因为已经作为 中间人 劫持了流量, 延迟/流量/错误/饱和度 等的指标都可以监测的到
  * 链路监控 (哪些服务在互相调用)
    * 但是不确定可否将一个请求串联起来, 这个可能还是需要库级别的支持([可以在请求中添加 Header 以标识请求](https://preliminary.istio.io/latest/zh/faq/distributed-tracing/),例如 ZipKin 和 Jaeger)
    * 这块的详细动作, 仍然需要继续细化
  * 访问日志

* 安全性

  安全性主要是 TLS 的部分和 Policy 访问控制, 

  * TLS 方面, 因为作为 Transport 层, Envoy 可以将 由它 发送和接受 的流量进行加密传输. 从而杜绝中间人攻击

  * 另一方面, Istio 控制面 也可以搭配 Kubernetes 的 RBAC 机制, 对请求进行鉴权, 例如, 必须要 带有 label `app: products` 的 pod 才能使用 GET 方法 和 HEAD 方法访问当前 Pod 的 `/test/*` url. 

### ASM

ASM 全称 `Alibaba Cloud Service Mesh`, 基于 Istio 开发, 它从 云平台层面, 支持了将 `ESC VM`, `ServerLess Pod`,`Kubernetes Pod` 统统加入 服务网格的功能, 这样 原本不方便 迁入 Kubernetes 中的 服务(例如 PHP 服务) 也可以 就地加入 服务网格, 享受 上述的特性.

![](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/assets/img/zh-CN/8994636851/p73368.png)



