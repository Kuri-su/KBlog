# Istio Arch

[TOC]

## Istio 组成

### 用户 Pod

1. InitContainer , 用来配置 Iptables 来劫持 Pod 中的所有流量, 都转发给 Envoy Sidecar 
2. sidecar Container: 里面有两个进程
   * polit-agent 是 polit 的一个 Agent, 用来初始化并掌管 envoy, 
   * Envoy, 除了 Envoy 的 功能之外, 还有 Mixer Client 的逻辑

### istio sidecar injector

1. httpServer, 用来接受 kubeApi 的 Webhook 事件请求, 修改 用户 Pod 的 Yaml 然后进行注入 SIdecar

### Istio galley

1. 提供 istio 中的 配置管理服务, 验证 Istio 的 CRD 资源的合理性, 对外提供三个接口
   1. gRPC 接口
   2. https 接口, 用于验证 CRD 合法性 接口(Istio 自己的那些 CRD Object 的 Yaml 合法性)
   3. http monitoring 接口, 用于获取监控指标

并且通过 k8s 的 service 对外提供服务

### istio pilot

pilot 组件核心 pod, 抽象服务注册信息, 流量控制模型, 封装统一的 Api 和 Envoy 交互

包含这么两个 容器: 

1. istio-proxy
2. discovery, 应该是用来做服务发现的?

对外提供三个接口

1. grpc XDS 接口
2. https XDS 接口
3. http XDS 接口

### istio-telemetry && istio-policy

telemetry 负责遥测

policy 负责 策略控制

都包含两个容器, istio-proxy 和 mixin server

### istio-citadel 

负责 安全  和 证书管理