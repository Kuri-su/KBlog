# Prometheus 和 它实现的监控需求们

[TOC]

这篇博文主要 想讲清楚, Prometheus 是如何看待监控这件事情, 以及  Prometheus 是如何实现这些需求的.

## 当想看监控的时候, 我们到底想要什么? 

想要什么也就是需求

### 需求

在实际的生产过程中, 产生的和需要收集的监控数据分为很多种, 例如

* 瞬时状态的 CPU 和 MEM 使用率读数 
* 硬盘使用量的增长率
* 对 集群节点 状态 进行筛选 , 记录节点位于什么时刻不可用, 这就要求有 Tag 支持
* 瞬时状态的 网卡流量, 例如 100 Mbps,
* 服务请求量, 服务的 QPS, 服务的 错误率和错误次数 
* 全部请求的平均时耗
* 一段时间内, 所有请求的 时耗中, 50% 的请求时耗小于多少毫秒, 95% 的请求时耗小于多少毫秒? 以此评估整体的接口情况
* 一段时间内, 所有请求的 时耗中, 多少请求时耗大于1000ms, 多少请求时耗位于 200-500 区间内, 用于了解 请求时耗的具体分布, 以评估接口情况
* ....

## 从 Prometheus 的视角看这些需求

在 Pormetheus 的视角中, 他认为基于 TSDB (时序型数据库) , 将上述需求可以使用下列四类指标来完成: 

* 只会一直增加的 类型 (例如 服务的请求量)
* 记录瞬时状态的 类型 (例如 瞬时的 CPU 读数)
* 分位 类型 (例如 需要看 50% 的请求小于多少毫秒)
* 直方图 类型 (例如 例如 200-500 ms 的请求 有多少)

好的, 这里直接给出了结论, 下面就聊聊 如何基于这些 想法来实现上述需求, 以及 为什么基于这几种 指标可以实现上述需求

## Promtheus 需求实现

那么一开始, 我们先聊聊 TSDB, 毕竟这是 Prometheus 实现需求的基础.

TSDB  中的 数据, 通常以 `数据点(Point)` 作为基本单位, 多个 Point 构成 `Series (序列)`, 所有关于同一个主题的数据点 构成 `Metrics(指标)`, 

![](/home/kurisu/Downloads/200914-TSDB-timeseries-model.png)



// TODO 说说 TSDB , 简单说即可,  不用太过深入

// TODO Metrics 维度过高 的问题在于 样本集过大导致的 传输和 运算上的困难

// TODO https://developer.aliyun.com/article/174535

// TODO https://www.cnblogs.com/jimbo17/p/8337535.html

// TODO https://fabxc.org/tsdb/

那么 Prometheus 如何基于 时序型 数据库(TSDB)，来实现上面 这些需求？

首先我们介绍一下 TSDB 的基本使用方式， 我们在把 数据 插入 TSDB 的时候， TSDB 会自动为 数据 打上 Timestemp ，接着我们可以根据 数据插入时的 Index 信息来将 这个 Index 所关联的全部数据都拉出来。

![]()

但看到这里，就有个疑问，“那 TSDB 和 关系型数据库 有什么区别？” , 用 例如  MySQL , 我也能实现这个需求! 

// TODO 讲清楚这个区别

那么了解了 TSDB 的基本使用方式，那么 来尝试我们来完成这些需求。

#### 瞬时的 CPU 和 网卡流量记录

对于这个需求，我们只要定时的将获取到的数据写入TSDB即可，接着通过 TSDB 的接口将对应 Index 查询出来。

#### 需要持久观测的 QPS

对于 QPS ，如果我们要直接以 插入时候 `即`是 QPS 的话， 那么实现过程将过于 复杂，且十分难以适配。那我们是否有办法通过简单的方法来完成这个需求。Prometheus 是这样完成的，首先将 总请求数量 定时写入 TSDB， 接着在查询时，获得数据，通过 计算 进而 得到 QPS 或者 请求量增长 。

#### 平均值 && 分位值

对应于上面提到的前端页面加载时间段, 这个 比较复杂的需求, 我们通常 会选用 `分位值` 来实现, 但在此之前, 我们需要先聊一聊, 为什么不可以只关注 平均值, 而需要引入 分位值的概念.

##### 平均值的缺陷

假设 如下图的一个瞬间, 系统 处理 100 条并发请求的 时耗如下左边所示:  

![](/home/kurisu/Downloads/200831-metrics-Quantile.png)

这 100 条请求里面 时耗分为 五个段, 

* 0 ~ 150 ms
* 151~250 ms
* 251 ~ 350 ms
* 350 ~ 450 ms
* 450+ ms

然后为了讲解 和 计算 方便, 我们直接粗暴的认为 这100 条请求里面,  100 ms , 200ms, 300ms , 400ms, 500 ms 的请求分别各有 20 条, 也就上图 中间的样子.

那么 我们很快就能算出 这一秒请求的时耗 平均值 是 300 ms,  在 3s 或者更长的时间段里, 我们都能看到时间段内的所有请求的平均值 在 300ms.

假设请求时延 超过 450 ms 被认为 `不可接受`, 那么很明显, 如果我们只关注 平均值(avg) , 我们就很可能认为这一时段, 系统正处于正常状态, 但实际上, 系统此时已经发生异常, 有 20% 的 请求处于不可接受的状态. 平均值 过度的 屏蔽了 `请求时耗分布` 的 具体细节, 只暴露了一个简单的值.  

##### 分位值

而我们如果需要 比较方便的了解 `请求时耗分布` 的 具体细节, 这个时候就需要引入 `分位值` 的概念.  

顾名思义, 分位值 就是 分位 分位上的值, 例如 中位数, 其实也就是 50% 分位数(TP50)(Top Percentile).  通常计算分位值的 分位数 是在将 样本集 的数据排序后, 取出指定位置的数据 作为对应位置的分位值.

例如假设我们有 一个已经排好序的数组, 里面有 100 个数, 那么 这个数组的 25% 分位值 就是第 25 个数, 这个数组的 99% 分位值就是第 99 个数. 这就是取到 分位值的方式

例如下面的 图, 就分别展示了  25% 分位值(TP25),  50% 分位值(TP50),  75% 分位值(TP75),  95% 分位值(TP95) 和  99% 分位值(TP99) 

![](/home/kurisu/Downloads/200831-metrics-Quantile2.png)

那么利用分位数,我们就可以明确知道 这个时段内的请求分布情况, 相比刚才计算 平均数的方式, 分位值 的优势就展示的比较明显. 

但分位值除了可以比较好的展示时段内请求的细节外, 分位值还可以作为服务异常的基准指标, 以搜索接口为例, 假设 规定搜索接口 95% 的请求都需要保证在 1s 内完成, 如果超过就告警. 用分位值来做就很好做, 直接 95% 的分位值 不允许大于 1s 即可.

但如果这个需求 使用平均数来表达, 可能就比较麻烦了, 搜索接口的一些命中索引或者比较短的情况下就会很快, 但如果一些复杂且未命中索引, 那么可能就会比较慢, 这如果 平均一下...那么除非 这个接口坏掉 或者 有用户反馈, 否则 这个告警永远不会被触发....

#### 直方图

但只使用 分位值没有办法完全实现我们上面的需求, 我们还需要每个区间内的实际访问量, 例如 100ms - 200ms 内, 究竟有多少访问量, 分位值只能告诉我们按百分比的位置是多少, 但是无法告诉我们 在 100ms - 200ms 这个区间内有多少, 那这个时候怎么办? 这个时候就可以使用直方图来完成我们上面的需求.

// TODO

#### 小结

上面就简单的介绍了下, Prometheus 基于需求, 抽象出来的四种 监控数据类型. 上面这些需求与其说是 Prometheus 的规则, 倒不如说 更像是 Prometheus 对于监控这件事情的看法, 他们认为监控数据的分析和存储诉求, 使用上述的 四种数据类型 和 PromQL 做简单分析, 就可以满足. 那么下面我们介绍一下 Prometheus 的基本单元 Metrics. 

#### metrics

metrics 的中文是`指标`, metrics 是 Prometheus 中的一个重要概念, 一个 Metrics 可以拥有若干个 Labels , 以及一个 Value,  类似于下面这样, 一条数据就是一个 Metrics. 

```
// 这里每一个 样本 由 三个部分组成, 
//    metricsPart : metrics name 以及 labels 
//    timestamp   : 毫秒时间戳
//    value       : float64 类型的值

<--------------- metricsPart ----------------> <-timestamp->  <-value->

http_request_total{status="200", method="GET"}@1434417560938 => 94355
http_request_total{status="200", method="GET"}@1434417561287 => 94334

http_request_total{status="404", method="GET"}@1434417560938 => 38473
http_request_total{status="404", method="GET"}@1434417561287 => 38544

http_request_total{status="200", method="POST"}@1434417560938 => 4748
http_request_total{status="200", method="POST"}@1434417561287 => 4785

```

你可以把 这里的 `Metrics Part` 中的 `metrics name` 对应成 Mysql 中的 Table , `metrics labels` 对应成 Mysql 中的字段, 来帮助理解.

但通常, Prometheus 从 Metrics 数据源那里采集到的 数据是不带 Timestamp 的, 就类似于下面这样: 

```
phpweb_xys_indexpage_detailtrace_total{goto="h5_baodan360"} 264
phpweb_xys_indexpage_detailtrace_total{goto="h5_xys_new"} 59
phpweb_xys_indexpage_detailtrace_total{goto="pc_baodan360"} 891
phpweb_xys_indexpage_detailtrace_total{goto="pc_xys"} 468
```

![]()

## Metrics 數據被收集 和 保存

那么随着 Metrics 被 Prometheus 抓取到, Metrics 就来到了 Prometheus 里.

#### Promtheus

![https://prometheus.io/assets/architecture.png](https://prometheus.io/assets/architecture.png)

通常交流中说的 Prometheus 其实是指 Prometheus 以及其生态组成的 Prometheus 监控系统, 这个监控系统中包含如下组件

- Grafana - 用于展示的前端面板
- Prometheus Server - 负责抓取和存储数据, Prometheus 本体
- AlertManager - 负责 处理和发送 告警事件, 例如需要告警的 频道 以及 抑制相同的告警等.
- PushGateway - 一个接受请求上报的网关, 通常比较少用

这里额外描述下 Prometheus Server, `抓取器` , `时序型数据库(TSDB)`,`HttpServer` 三部分组成了 Prometheus Server.

#### 抓取器

抓取器顾名思义, 专门负责抓取, 其中实现了多种抓取方式供使用, 在当前系统中最常用的三种方式是 

- `指定 URL 抓取`,
- `基于 服务发现 进行抓取`,
- `对 Kubernetes 的 Api 进行抓取`

#### 时序数据库

Prometheus 项目自己实现了 一個 时序型数据库, 用于将 抓取器采集到的数据写入磁盘, 供 HttpServer 查询.

#### HttpServer

提供查询 API 给外部的 Http 服务器, 使用 Prometheus 项目 自己实现的 PromQL 对 TSDB 进行查询, 也是我们后面要重点了解的部分.

#### Pull 模型

在采集模式上, Prometheus 选用 Pull 的模式来采集,

![/home/kurisu/Documents/tmp.png](/home/kurisu/Documents/tmp.png)

#### PromQL

// TODO 这里简单提一下, 后面会详细讲

### 觸發吿警

// TODO

### 基于指标的监控系统 和 基于日志的监控系统的区别

// TODO

Prometheus + Grafana

ElasticSearch + Logstash/Fluentd + Kibana

### Prometheus 基于 时序型数据库的问题

高维度指标 的 Bug

// TODO 

## Ref

* https://developer.aliyun.com/article/174535
* https://www.cnblogs.com/jimbo17/p/8337535.html
* https://fabxc.org/tsdb/