+++
date = "2020-06-11"
title = "features of tidb 4.0"
slug = "features-of-tidb-40-vwabf"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "每次升级不外乎 Bug 修复和 New Features, 由于 bug 修复方面如果不是 踩坑 或者 Contributor, 通常基本不会关心, 所以这里只提 New Features,"

+++


每次升级不外乎 Bug 修复和 New Features, 由于 bug 修复方面如果不是 踩坑 或者 Contributor, 通常基本不会关心, 所以这里只提 New Features, 

NewFeatures 分为 X 块, 

* PD 调度优化
* 新增组件
* SQL 支持增强

## PD 调度优化

* Cascading Placement Rules (直译: 级联 配置 规则 (实验特性)),  可以通过配置文件控制 **Region** 或者 **Leader** 的分布,  笔者觉得一方面可以提升部分 重点副本 的容灾能力, 另一方面 提供了手动调整 Region 的能力. [文档中的例子](https://pingcap.com/docs-cn/stable/configure-placement-rules/#典型场景示例)
* 提供 PD 控制 Kubernetes 的能力, 目前支持 动态扩缩容 节点, 这块应该也许要 云服务商的支持, 或者提前准备节点, 将集群内剩余的资源由 PD 自动调度给 TiDB
* 增加热点调度的参考依据的维度, 原本仅仅将 写入和读出流量 作为调度依据, 但翻文档我也没懂 新的维度在哪.......

## 新增组件

这次新增的组件有四项, `TICDC` , `TIUP` , `TiDB Dashboard` ,  `TiFlash`, 其中最万众瞩目的当然是 TiFlash, 不过我们先看其他三个

### TICDC (Change data capture for TiDB)

![](https://download.pingcap.com/images/docs-cn/cdc-architecture.png)

一个从 TIDB(TIKV) 向外同步的同步器,原理也是通过 Binlog 的方式进行同步, 有个点是这款工具目前还支持 MQ, 目前处于实验阶段,  另外 TICDC 提供了一个 [TICDC open protocal 协议](https://docs.pingcap.com/zh/tidb/v4.0/ticdc-open-protocol) , 用户和第三方的贡献者可以根据这个协议 TICDC 支持的下游扩展下游

### TIUP

笔者认为 TiUP 的作用 是之后替代 3.x 时代的 Ansible, 来部署 TiDB 集群, 毕竟不是每个团队都熟悉 Ansible .  

* 组件管理功能，提供一键式组件信息查询、安装、升级、卸载等功能，方便 DBA 管理 TiDB 的所有组件。(同理 Kubectl)
* 在然后在集群管理方面, 支持包括 `扩容`, `缩容` , `升级` 等功能, 同时支持管理多个集群
* 另外 本地部署功能(此前的 Docker-compose 部署的本地测试集群) 也在 TiUP 中由 Playground 提供, 也支持使用 TiUP 来跑 Benchmark .

TiUP 仍然使用 Yaml 来标识 集群内 需要部署的机器, 不过配置更加集中, 用户不需要再 去理解 Ansible-playbook 和 Ansible-Role, 

#### 配置文件

```yaml
---
  
pd_servers:
  - host: 172.16.5.134
    name: pd-134
  - host: 172.16.5.139
    name: pd-139
  - host: 172.16.5.140
    name: pd-140

tidb_servers:
  - host: 172.16.5.134
  - host: 172.16.5.139
  - host: 172.16.5.140

tikv_servers:
  - host: 172.16.5.134
  - host: 172.16.5.139
  - host: 172.16.5.140

grafana_servers:
  - host: 172.16.5.134

monitoring_servers:
  - host: 172.16.5.134
```

#### 查看集群状态

```shell
Starting /root/.tiup/components/cluster/v0.4.5/cluster display prod-cluster
TiDB Cluster: prod-cluster
TiDB Version: v3.0.12
ID                  Role        Host          Ports        Status     Data Dir              Deploy Dir
--                  ----        ----          -----        ------     --------              ----------
172.16.5.134:3000   grafana     172.16.5.134  3000         Up         -                     deploy/grafana-3000
172.16.5.134:2379   pd          172.16.5.134  2379/2380    Healthy|L  data/pd-2379          deploy/pd-2379
172.16.5.139:2379   pd          172.16.5.139  2379/2380    Healthy    data/pd-2379          deploy/pd-2379
172.16.5.140:2379   pd          172.16.5.140  2379/2380    Healthy    data/pd-2379          deploy/pd-2379
172.16.5.134:9090   prometheus  172.16.5.134  9090         Up         data/prometheus-9090  deploy/prometheus-9090
172.16.5.134:4000   tidb        172.16.5.134  4000/10080   Up         -                     deploy/tidb-4000
172.16.5.139:4000   tidb        172.16.5.139  4000/10080   Up         -                     deploy/tidb-4000
172.16.5.140:4000   tidb        172.16.5.140  4000/10080   Up         -                     deploy/tidb-4000
172.16.5.134:20160  tikv        172.16.5.134  20160/20180  Up         data/tikv-20160       deploy/tikv-20160
172.16.5.139:20160  tikv        172.16.5.139  20160/20180  Up         data/tikv-20160       deploy/tikv-20160
172.16.5.140:20160  tikv        172.16.5.140  20160/20180  Up         data/tikv-20160       deploy/tikv-20160
```

相较之前的 Ansible 部署和管理的方式, 复杂度和心智负担下降了至少一个量级

### TiDB Dashboard

TiDB 也算是一个在原来工具栈基础上的加强, 用于代替此前 3.x 版本中 的 Grafana , 但不确定是否复用了 Prometheus , 功能点在移植 Grafana 面板的功能之外还追加了 Log 的 Search 和 Download 功能, 以及 追加了一个自动诊断的功能

![](https://download.pingcap.com/images/docs-cn/dashboard/dashboard-intro.gif)

### TiFlash

TiFlash 是 pingcap 在 4.0 中,为 TiDB 引入的 一个新的 存储引擎, 下面复制自官网

> - iFlash 是 TiDB 为完善 Realtime HTAP 形态引入的关键组件，TiFlash 通过 Multi-Raft Learner 协议实时从 TiKV 复制数据，确保行存储引擎 TiKV 和列存储引擎 TiFlash 之间的数据强一致。TiKV、TiFlash 可按需部署在不同的机器，解决 HTAP 资源隔离的问题。详情参阅：[TiFlash](https://docs.pingcap.com/zh/tidb/v4.0/tiflash-overview)。
> - 4.0 版本中 TiKV 提供新的存储格式，提升宽表场景下编解码数据的效率。

## SQL 支持增强

### 事务

- 悲观事务正式 GA 并作为默认事务模式提供，支持 Read Committed 隔离级别以及 `SELECT FOR UPDATE NOWAIT` 语法。详情参阅：[悲观事务模型](https://docs.pingcap.com/zh/tidb/v4.0/pessimistic-transaction)。
- 支持大事务，最大事务限制由 100 MB 提升到了 10 GB，同时支持乐观事务和悲观事务。详情参阅：[事务限制](https://docs.pingcap.com/zh/tidb/v4.0/transaction-overview#事务限制)。

### SQL 功能

在下看得懂的特性包括如下这些, 

* 新增了若干张表, 用于保存集群星系和 查询以及性能信息: 
  * 新增集群拓扑、配置、日志、硬件、操作系统等信息表，帮助 DBA 快速了集群配置、状态信息：
    - `cluster_info` 表，保存集群的拓扑信息。
    - `cluster_log` 表，保存系统的日志信息。
    - `cluster_hardware`，`cluster_systeminfo`，保存系统中服务器的硬件系统，操作系统信息等
  * 新增慢查询、诊断结果、性能监控等系统表，帮助 DBA 快速分析系统的性能瓶颈：
    - `cluster_slow_query` 表，慢查询信息。
    - `cluster_processlist` 表，保存全局的 processlist。
    - `inspection_result` 表，4.0 版本新增自动性能诊断的功能，性能分析报告，
    - `metrics_summary` 和 `metric_summary_by_label` 表，用于记录保存系统中的所有监控指标信息
    - `inspection_summary` 表，用于记录保存不同的数据链路或者访问链路上各种关键的监控指标

另外的请参考下面的官网链接 :joy: : 

[SQL 功能](https://docs.pingcap.com/zh/tidb/v4.0/whats-new-in-tidb-4.0#sql-功能)



## Ref: 

> [混合事务分析处理「HTAP」的技术要点分析 https://www.infoq.cn/article/rkCx3gsvFZGS9hBSU8LI](https://www.infoq.cn/article/rkCx3gsvFZGS9hBSU8LI)
>
> [What's New in TiDB 4.0 https://docs.pingcap.com/zh/tidb/v4.0/whats-new-in-tidb-4.0](https://docs.pingcap.com/zh/tidb/v4.0/whats-new-in-tidb-4.0)
>
> [调度 https://docs.pingcap.com/zh/tidb/v4.0/tidb-scheduling](https://docs.pingcap.com/zh/tidb/v4.0/tidb-scheduling)
>