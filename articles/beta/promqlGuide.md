// TODO 添加配置内容

# PromQL Guide

[TOC]

// TODO 添加头图

\# 文档翻译系列 XD

这篇文章的面向群体是 对 Prometheus 已经有一定的认识, 而开始想要了解 PromQL 的人群.

PromQL 全称  Prometheus Query Language, 是在 Prometheus 上使用的 DSL .

在文章开始之前, 想先明确一点, 就是通常写的 PromQL 都是比较简单的, 大多数的运算以及聚合操作都已经 在客户端生成 指标数据时 计算完毕了. 所以这篇文章更多的作用在 文档翻译 2333, 如果你看不懂其中的一部分也没有关系, 使用简单的 PromQL 就能很顺畅的进行查询.

## Example

与其先看一堆定义介绍, 倒不如 直接看实际用的 查询语句. 下面这个是关于 计算  web 服务 QPS 的 语句,

```go
rate(web_request_count{status="200"}[5m]) >0
```

先把它拆成三段, 

```go
rate(
	web_request_count{status="200"}[5m]
) > 0
```

中间部分 `web_request_count{status="200"}[5m]`  , 开头 `web_request_count` 表示要 处理 的 Metrics 名称,  大括号里的 `{status="200"}` 表示对 metrics 有一些标签筛选, 这里 status 为 200 说明只计算 正常处理的请求. 最后一个 方括号 则是为了搭配 `rate` 函数而加的时间范围限定, 

`rate` 是 一个 PromQL 提供的函数, 专门用来计算 增长率, 常用于计算 QPS.

接着使用上面这个简单的表达式 来对 Prometheus 的 API 发起查询

```shell
# 为了让命令确实可以运行, 这里替换成了 prometheus 自带的 go gc 监控, 不过意思是一样的
# URL 中没有 指定时间范围, 默认返回当前时间的瞬时数据
$ curl 'http://localhost:9090/api/v1/query?query=rate(go_gc_duration_seconds_sum[5m])>0'
#                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 这一块是实际运行的表达式
```

然后可以得到如下 Json 格式的数据: 

```json
{
  "status": "success",
  "data": {
    "resultType": "vector",
    "result": [
      {
        "metric": {
          "instance": "127.0.0.1:9090",
          "job": "prometheus",
          "source": "k8s"
        },
        "value": [
          1601183521.796,
          "0.000004714821924357098"
        ]
      }
    ]
  }
}
```

但这样直接使用 API 查询十分不方便, 推荐使用 Grafana 来查询, 相关的博客很多, 可以 Google 一下, 

将上面的查询放到 Grafana 中, Grafana 在查询时会自动带上时间范围, 所以得到的是一段时间内的数据, 然后  Grafana 会根据这段时间内的数据绘制出如下所示的一副图, 

![](/home/kurisu/Pictures/tmp/2020-09-27_13-31.png)

// TODO 补图

到这里, 就使用 PromQL 完成了一次查询.

## 格式

### PromQL 格式

一个 PromQL 语句可以由 如下几个部分组成

* metrics 指标名
* labels 
* 运算符和关键字
* 常量
* 时间范围选择器

```go
sum(rate(go_gc_duration_seconds_sum{instance=~"$instance",job=~"$job"}[2m])) by (instance) > 0

avg(avg_over_time(up{instance=~"$instance",job=~"$job"}[$interval]) * 100)

topk(20,sum(delta(api_time_use_count{code="200"}[$__interval])) by (code)) >0
```

### Result 格式

然后在 一个 PromQL 在运算完之后, 有四种可能的输出

* 瞬时向量
  * 某一个瞬时查询到的全部数据,例如 上面 Demo 演示的 例子
* 范围向量
  * 一段时间内的 查询到的全部数据, 例如上面展示在 Grafana 中的例子
* 常量
  * 一个运算结果, 例如上面 使用 avg 计算 启动率
* 字符串(暂未投入使用)

## 运算符和关键字

### 运算符

PromQL 对 基本的 运算符号都支持 , 例如

* `加减乘除+-*/` 
* `求余%`
* `乘方^`
* `==` `!=` `<` `>` `>=` `<=` `正则匹配 =~`

### 关键字

PromQL 中的关键字很少,只有如下六个,  通常都用在处理 `Label` 和 `Join操作` 上,  而这六个关键字又可以 又可以分为两类

* 在运算时忽略 label
  * `without` 和 `by`
* 连接 (Join) 操作
  * `ignoring` 和 `on`
  * `group_right` 和 `group_left`

如果需求不是很变态的话, 会用到的只有 `without` 和 `by` 而已, 不必慌张

#### 在运算中 忽略 或者 仅关注 某些 Label

乍一看, 好像 `without` 和 `ignoring` 意思好像接近丫, `by` 和 `on` 在 排除 label 上似乎意思也类似, 但在 PromQL 使用中, 他们还是略有不同.

* `without` 和 `by` 只能用于单个 Metrics 的 函数运算中, 忽略 或者 仅关注 某些 label, 效果类似于 SQL 的 `group` 操作

  ```go
  // example about by , without 也是类似
  
  // A{method="post", code="200",service="FooServer"}  24
  // A{method="get", code="200",service="FooServer"}  30
  // A{method="put", code="200",service="BarServer"}  321
  // A{method="delete", code="200",service="BarServer"}  123
  
  // 计算所有的请求量
  
  // Before
  sum(A{code="200"})
  // 
  // SQL like this
  // SELECT sum(value) FROM A,B
  // 
  // result
  // sum(A{code="200"}) 498
  
  
  // After
  sum(A{code="200"}) by (service)
  // {service="BarServer"} 444
  // 
  // SQL like this: 
  // SELECT sum(value), service FROM A,B GROUP BY service
  // 
  // result
  // {service="FooServer"} 54
  
  
  // 当然, 读者也可以自行尝试 by (method) 来得到类似的结果
  ```

#### Join

* `ignoring` 和 `on` 则用在 `两个 Metrics 做基础运算` 的场景中 忽略 或者 仅仅关注 某些 label, 你也可以理解成

  ```go
  // A{method="get", code="500"}  24
  // A{method="get", code="404"}  30
  // A{method="put", code="501"}  3
  // A{method="post", code="500"} 6
  // A{method="post", code="404"} 21
  
  // B{method="get"}  600
  // B{method="del"}  34
  // B{method="post"} 120
  
  A{code="500"} /  on(method) B
  //
  // SQL like this
  // SELECT A.value * B.value, A.method 
  // FROM A INNER JOIN B ON (A.code = 500 AND A.method == B.method)
  // 
  // result
  // {method="get"}  0.04            //  24 / 600
  // {method="post"} 0.05            //   6 / 120
  // 而 method 等于 del 和 put 的由于找不到匹配项, 所以不会出现在结果中.
  
  
  // <向量表达式> <二元运算符> ignoring(<Labels>) <向量表达式>
  // <向量表达式> <二元运算符> on(<Labels>) <向量表达式>
  ```

* 还可以将 `ignoring` /`on` 和 `group_left` 或者 `group_right` 相组合, 达成更细节的 join 效果, 当  `ignoring` /`on`  和 group 组合的时候, 他们的动作会稍微有所改变

  ```go
  // <向量表达式> <二元运算符> ignoring(<labels>) group_left(<labels>) <向量表达式>
  // <向量表达式> <二元运算符> ignoring(<labels>) group_right(<labels>) <向量表达式>
  // <向量表达式> <二元运算符> on(<labels>) group_left(<labels>) <向量表达式>
  // <向量表达式> <二元运算符> on(<labels>) group_right(<labels>) <向量表达式>
  
  // A{method="get", code="500"}  24
  // A{method="get", code="404"}  30
  // A{method="put", code="501"}  3
  // A{method="post", code="500"} 6
  // A{method="post", code="404"} 21
  
  // B{method="get"}  600
  // B{method="del"}  34
  // B{method="post"} 120
  
  A / on(method) group_left B
  //
  // SQL like this
  // SELECT A.value * B.value, A.*
  // FROM A INNER JOIN B ON (A.method == B.method)
  // 
  // result
  // {method="get", code="500"}  0.04            //  24 / 600
  // {method="get", code="404"}  0.05            //  30 / 600
  // {method="post", code="500"} 0.05            //   6 / 120
  // {method="post", code="404"} 0.175           //  21 / 120
  
  ```

* 除此之外, 还可以使用 `and` `or` `unless` 这些关键字实现两个 Metrics 之间的 `交集` `并集` `差集` 的运算, 同样 `and`/`or`/`unless` 也可以用 ignoring 和 on 修饰.

## 函数

PromQL 提供的函数很多 , 详细可以参考 [官方文档](https://prometheus.io/docs/prometheus/latest/querying/functions/)来查看, 下面仅仅列举一些常用的函数和使用示例: 

* rate / irate

  ```go
  // 求增长率
  rate(node_network_receive_bytes_total[5m])
  irate(node_network_receive_bytes_total[5m])
  
  // rate 和 irate 的区别, 
  // irate 适合快速变化的计数器（counter），而 rate 适合缓慢变化的计数器（counter）。
  ```

* delta / idelta / increase

  计算 设定时间范围内的 第一个值减去最后一个值的 差, 例如 下面这个 表达式

  ```go
  // 每一分钟有多少请求
  delta(web_request_total[1m]) // count 类型
  
  ```

* `sum` / `avg` / `max` / `min`

* `sum_over_time` / `avg_over_time` / `max_over_time` / `min_over_time`

  一段时间内的 

* topk

* count

  metrics 数量

* log2 / log10

  常用于突出 底部的曲线变化, 

* label_join

  label 的修改

* label_replace

  label 替换

* predict_linear

* ...

## Common collocation 常见搭配

基本上你会这些就可以开始 尝试 在 Grafana 中新建面板了

### QPS

```go
// 根据 count 类型的指标
rate(http_requests_total[5m])
```

### 实际请求量

```go
// 根据 count 类型指标
delta(http_requests_total[5m])
```

### Histogram 区间内的请求量

```go
// 根据 histogram 类型指标
sum(increase(http_requests_time_histogram_bucket{le="200"}[5m])) 
-
sum(increase(http_requests_time_histogram_bucket{le="100"}[5m]))
```

### 对标签使用正则匹配

```go
http_requests_total{status_code=~"2.*"}
```

## Ref

* https://prometheus.io/docs/prometheus/latest/querying
* https://timber.io/blog/promql-for-humans/
* https://www.robustperception.io/left-joins-in-promql
* https://www.robustperception.io/using-group_left-to-calculate-label-proportions

