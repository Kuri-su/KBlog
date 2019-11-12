# Kubelet

## 简介

同 Kubernetes 内大多数Api 对象的一样, Kubelet 也是根据 "控制器模式" 来工作. 作为 Kubernetes 在 Node 上 对容器的控制器组件, Kubelet 将负责真正管理镜像和容器的生命周期. 

Kubelet 通过以下四种途径获取触发事件的请求,

* Api-server 通过 List-Watch 机制 , 主动通知 Kubelet 更新 (类似于 发布-订阅 机制), 并且这种是主要的事件来源, 而这种交互方式中, 以 HTTP 为载体, 发送 Protocal Buffers 编码的响应.
* Kubelet 主动 访问 Api-server 从而获取更新
* 应用程序 主动访问 Kubelet 的 HTTP 接口,
* 以 static Pod 文件的形式触发

通过这些事件主要分为如下四类:

* Pod 更新事件 (大多数情况)
* Pod 生命周期变化 (例如销毁)
* Kubelet 自身设置的执行周期
* 定期的清理事件

通过这四类事件, 它将对以下实现了以下三种接口的对象进行操作

* CNI (网络插件)
* CRI (容器运行时插件)
* CSI (存储插件)
* 并通过 GRPC 和 当前 Node 的 `Device Plugin` 进行通信

并且 Kubelet 还内置了 Google 开源的 容器资源分析工具 `cAdvisor`, cAdvisor 会自动采集CPU,内存，文件系统，网络使用情况, 定时上报

## CRI && OCI


## CNI && KubeProxy


## CSI

