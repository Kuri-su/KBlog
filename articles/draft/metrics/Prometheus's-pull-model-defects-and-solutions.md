# Prometheus 在 Pull 模式下的缺陷 和 解决方案们

[TOC]

## 缘起

笔者在 实验环境 搭建了如下环境, 这个结构在 Prometheus 的部署中应该是挺常见的, 为了避免外部调用 kube-apiserver , 每个 K8s 集群里都有一个 Prometheus 作为 Agent , 然后利用外部的 Prometheus 和 K8s 内的 Prometheus 级联来汇总数据. 

// TODO 补图

部署完之后, 发现集群内作为 Agent 的每个 Prometheus 的内存占用 在 2G 左右, 感觉以 Agent 来讲, 这个 MEM 占用有点太大了,

## Pull 模式缺陷

最后发现 Pull 模式存在这样的问题, 为了抓取的需要, 得一直维持数据在 MEM 里, 直到被访问的时候, 再全部序列化出来, 产生 Response , // TODO

## 业界解决方案

### Thanos 

