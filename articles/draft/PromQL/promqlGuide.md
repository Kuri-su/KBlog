# PromQL Guide

[TOC]

\# 文档翻译系列 XD

这篇文章的面向群体是 对 Prometheus 已经有一定的认识, 而开始想要了解 PromQL 的人群.

PromQL 全称  Prometheus Query Language, 是在 Prometheus 上使用的 DSL .

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

## Format 格式

一个 PromQL 语句可以由 如下几个部分组成

* metrics 指标名
* labels 
* 运算符和关键字
* 常量
* 时间范围选择器

// TODO

然后在 一个 PromQL 在运算完之后, 有四种可能的输出

* 瞬时向量
  * 某一个瞬时查询到的全部数据
* 范围向量
  * 一段时间内的 查询到的全部数据
* 常量
* 字符串(暂未投入使用)

// TODO

## Operators 运算符和关键字



## Functions 函数

## Advanced 高级



## Common collocation 常见搭配



## Ref

* https://prometheus.io/docs/prometheus/latest/querying

