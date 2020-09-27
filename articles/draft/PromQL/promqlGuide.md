# PromQL Guide

[TOC]

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

PromQL 中的关键字很少, 通常都用在处理 Label 和 Join 上

#### 在运算中 忽略 或者 仅关注 某些 Label

* `without` `by` 用于 函数运算中, 忽略 或者 仅关注 某些 label

  ```go
  // example
  // TODO
  ```

* `ignoring` 和 `on` 则用在通常的运算场景中忽略 或者 仅仅关注 某些 label

  ```go
  // A{method="get", code="500"}  24
  // A{method="get", code="404"}  30
  // A{method="put", code="501"}  3
  // A{method="post", code="500"} 6
  // A{method="post", code="404"} 21
  
  // B{method="get"}  600
  // B{method="del"}  34
  // B{method="post"} 120
  
  // 这里把 A 的 `code` label 全部忽略掉之后, 参与后面和 B 的除法运算 
  A{code="500"} / (B ignoring(code))
  
  // <vector expr> <二元运算符> ignoring(<label list>) <vector expr>
  // <vector expr> <二元运算符> on(<label list>) <vector expr>
  // 汉化这里的表达式
  ```

#### Join

* 还可以使用 类似 group_right 和 group_left, 来实现 join 操作

  ```go
  // <vector expr> <bin-op> ignoring(<label list>) group_left(<label list>) <vector expr>
  // <vector expr> <bin-op> ignoring(<label list>) group_right(<label list>) <vector expr>
  // <vector expr> <bin-op> on(<label list>) group_left(<label list>) <vector expr>
  // <vector expr> <bin-op> on(<label list>) group_right(<label list>) <vector expr>
  
  // TODO 汉化 上面的表达式和举例子
  ```

* 除此之外, 还可以使用 `and` `or` `unless` 这些关键字实现两个 Metrics 之间的 `交集` `并集` `差集` 的运算

## 函数

PromQL 提供的函数很多 , 详细可以参考 [官方文档](https://prometheus.io/docs/prometheus/latest/querying/functions/)来查看, 下面仅仅列举一些常用的函数和使用示例: 

* rate / irate

  ```go
  // TODO add example
  ```

* delta / increase

* `sum` / `avg` / `max` / `min`

* `sum_over_time` / `avg_over_time` / `max_over_time` / `min_over_time`

* topk

* count

* log2 / log10

* label_join

* label_replace

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

