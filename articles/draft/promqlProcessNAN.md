# PromQL 处理 NaN 数据 输出结果异常

> PromQL process NaN data result error

[TOC]

## 现象

在尝试使用 PromQL 对 一个 Summary 类型的 Metrics A 进行处理时出现了一个比较诡异的现象,  对该 A 进行简单查询时, Grafana 中呈现如下图像, 

![]()

```go
// 对应的 PromQL
A{quantile="0.5"}
```

按照常理, 如果这时我们使用 avg 函数对 A 进行平均 (`avg(A{quantile="0.5"})`),   应该会计算得到 A Metrics 的平均曲线, 可是在使用 avg 函数后, 却发现图像上无数据. 接着直接查看查询结果, 发现有数据返回返回, 但是全部都是 NaN.

![图像]()

![查询结果]()

接着笔者以为是 avg 函数的问题, 毕竟数据有一些是不连续的, 遂开始尝试 sum, rate, irate 等函数, 发现皆出现上面问题. 而 max 和 min 函数则表现正常. 

## 解决方案

这里先贴上 解决方案, 以上面的例子为例, 通过筛选掉 结果为 NaN, 例如下面这样.

```
// before
avg(nan_metrics{label="label"})

// after
avg(nan_metrics{label="label"} > 0)

```

即可让结果正常显示,

## 深挖原因

这个问题通常出现在 Prometheus 的 Go Client 的 Summary 指標上。
// 需要銜接
// 需要確認 MaxAge 是否決定該位置
在 go Client 的 summary 指標中， 有一個 叫 `MaxAge` 的指標用於表示 Summary 的數據將會在 樣本集中保存多久，在超過 MaxAge 且無新數據加入後， GoClient 會將 Summary 的各個 quxxxx 的數據置為 NaN， 類似下面的代碼表示的這樣

```
// before
xxx
// after
xxx
```

// 需要繞回主題

然後這些數據經過查詢後， 暫時在 Grafana 上， 將會呈現如下的樣子，

## 总结

## Ref

> * [Prometheus Docs   https://prometheus.io/docs/prometheus/latest/querying/functions/](https://prometheus.io/docs/prometheus/latest/querying/functions/)
> * [Prometheus Issue https://github.com/prometheus/prometheus/issues/860](https://github.com/prometheus/prometheus/issues/860)
> * [Prometheus Issue https://github.com/grafana/grafana/issues/8860](https://github.com/grafana/grafana/issues/8860)

