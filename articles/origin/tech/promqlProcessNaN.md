+++
date = "2020-06-29"
title = "PromQL query result is abnormal when it process NaN data"
slug = "promql-process-nan-data-result-is-abnormal-mkziw"
categories = [ "tech","cloudnative" ]
tags = [ "golang","prometheus","cloudnative" ]
katex = false
headline = "在使用 PromQL  简单查询 一个 Summary 类型的 Metrics 时(假设 Metrics  名字 `A`), 出现了一个比较诡异的现象."
headImgUrl = "https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/promQLHeadImage.png"
+++
> PromQL 处理 NaN 数据 输出结果异常


## 现象

在使用 PromQL  简单查询 一个 Summary 类型的 Metrics 时(假设 Metrics  名字 `A`), 出现了一个比较诡异的现象.

首先 , 我们不使用函数来进行查询, 仅仅列出原始结果: 

![](/assets/promQLGraphBeforeAggr.png)

```go
// 对应的 PromQL
A{quantile="0.5"}
```

接着, 我们对上述数据 使用 函数 `avg` 取 平均值.

![](/assets/promQLGraphAfterAggr.png)

```go
// 对应的 PromQL
avg(A{quantile="0.5"})
```

这时, **诡异的事情就出现了**, 按照常理, 如果这时我们使用 avg 函数对 `A` 求平均值 (`avg(A{quantile="0.5"})`),   应该会计算得到 Metrics A 的平均值曲线, 可是在使用 avg 函数后, 却发现图像上无数据. 

接着通过查看 Prometheus 的原始查询响应, 发现实际上**是有数据返回**, 但是由于全部都是 `NaN`, 所以 Graph 上没有图像.


![查询结果](/assets/promQLResultAfterAggr.png)


当时笔者以为是 有一些数据是不连续的, 导致影响了 `avg 函数` 的执行, 遂开始尝试使用 `sum`, 等函数来验证这个问题是由数据不连续所引发的. 结果发现这些函数都出现了上述问题. 但比较意外的是 `max` 和 `min` 函数却都表现正常. 

## 解决方案

这里先贴上 解决方案, 可以通过添加一个对 A 向量的筛选, 去掉 Value 为 NaN 的样本, 示例代码如下所示:

```go
// before
avg(A{label="label"})

// after
avg(A{label="label"} > 0)
                //  ^^^^^^ 注意这里
```

即可让结果按照预期显示.

![](/assets/promQLGraphFixed.png)

## 原因

这个问题是在最近出现的, 当时我们在对 PHP 侧的 Metrics 的 生产和 收集做一些改造, 将 Metrics 的生产和 收集 转由 `Golang 中间件` 负责. 但在我们改造完成后, 发现 Grafana 中, 部分和 Summary 有关的 Dashboard 无法正常展示图像.

那么接着就是定位问题,  通过直接查看 Grafana 对 Prometheus 的查询的响应体, 发现响应在正常返回, 但都是 NaN, 那说明问题并不是由 PromQL 表达式错误引起的. 

![](/assets/promQLResultAfterAggr.png)

那么既然不是 PromQL 表达式的问题, 那 异常原因 有没有可能与 `PromQL 的处理机制` 以及 这里出现的 `NaN 响应` 有关?
在笔者印象中, 在 `Prometheus/client_golang` 里只有 Summary 指标 会有 NaN 相关的返回, 所以我们接着到 [prometheus/client_golang](https://github.com/prometheus/client_golang/issues) Issue 列表中 搜索相关的关键词, 还就真的找到两个相关的 Issue  [#860](https://github.com/prometheus/prometheus/issues/860) 和 [#8860](https://github.com/grafana/grafana/issues/8860) , 通过 阅读 Issue , 就找到了[解决方案](https://github.com/prometheus/prometheus/issues/860#issuecomment-359867796).

这里的 解决方案其实很简单. 以上面的代码段为例,  我们只需要在  `A`向量 的后面 加上一个 `>0` 来筛掉 值为 NaN 的样本即可. 但由于 笔者通常用 写函数调用的思维 在写 PromQL,并没有很快的意识到 这里的`A`是一个向量而不是一个普通的变量, 遂才写了错误的表达式造成来这次的问题. 

### NaN 数据的 产生

NaN 的产生 通常出现在 [prometheus/client_golang](https://github.com/prometheus/client_golang) 的 Summary 实现上。

在  Summary 的 配置中， 有一个 叫 `MaxAge` 的配置项 用于表示 刚刚收到的样本 将会在 该 Summary 的 样本集中保存多久. 在超过 MaxAge 时间后(并且无新数据加入)，`prometheus/client_golang` 会将 Summary 的各个 `quantile(分位数)` 的 Value 置为 NaN， 类似下面这样.

```go
// before
a_metrics{quantile="0.2"} 181
a_metrics{quantile="0.5"} 181
a_metrics{quantile="0.9"} 181
a_metrics{quantile="0.99"} 181
a_metrics_sum 3.246959e+06
a_metrics_count 17939

// after (after maxAge)
a_metrics{quantile="0.2"} NaN
a_metrics{quantile="0.5"} NaN
a_metrics{quantile="0.9"} NaN
a_metrics{quantile="0.99"} NaN
a_metrics_sum 3.246959e+06
a_metrics_count 17939
```

接着这些数据会被 Prometheus 采集, 然后储存在 Prometheus 中. 

#### 为什么不设置成 0 , 而设置成 NaN 

那这样就引出另一个问题, 为什么要把 过时数据的值 设置成 NaN 而不设置成 0 呢? 如果设置成 0 就不会影响 PromQL 的运算了.

关于这一点, 其实 已经由类似的讨论在 Issue 中, [#85 (2015)](https://github.com/prometheus/client_golang/issues/85) , 

*  `beorn7`: 在很长时间之后, 我们希望 Summary 能观察到 `衰减在图像上` 而不是 `冻结最后一个的样本的值在图像上` , 如果 Summary 的图像展示冻结是不准确的, 我们甚至没有办法根据这个冻结的结果判断现在服务是否正常. 下面两种方式都能获取到 图像的衰减, 但是我(beorn7)不确定哪一种会更好

  * Summary 将所有 的分位数 设置为 0 并返回, 但这是一种错误! 因为你的 Summary 其实此时根本没有值, 而你在图像上看起来却是 0 , 这可能导致一些错误的判断
  * NaN 会更加忠实的反映你的 Summary 的当前状态, 但这大概很容易会让人感到疑惑, 

* `juliusv`: 0 值是一个错误的指标, 它根本不能反映现实, 只是告诉你 "噢, 那个很好", `冻结最后一个值在图像上` 的方案我觉得可能没问题, 但是 NaN 似乎是更加正确的方案, 我更加推荐它

* > 关于这个 Issue 后续还有 `哪些值需要被设置成 NaN` 的讨论, 如果有兴趣可以直接去 Issue 里了解, 这里就不过度展开

### NaN 数据为什么会干扰到 PromQL 的查询

#### NaN 的特性

根据 `IEEE 754` 的标准,  Golang 需要使用一个 NaN 的值来标识 `not-a-number(不是一个数值)`, 例如在下面这段代码, 就会得到一个 实际上为 NaN 的返回值.

```go
q := math.Sqrt(-1)  // 对 -1 开平方 (只能对正数开平方)
fmt.Print(q)        // NaN
```

根据 `IEEE 754` , 对 `NaN` 进行算数运算, 实质上是在和一个 不可表示的值(它甚至可能不是一个值, 是一个范围) 做运算, 所以结果将会得到一个 `NaN`, 就像下面的例子

```go
	NaN := math.NaN()   

	fmt.Println(NaN + 2)               // NaN
	fmt.Println(NaN - 2)               // NaN
	fmt.Println(NaN * 2)               // NaN
	fmt.Println(NaN / 2)               // NaN
	fmt.Println(math.Pow(NaN, 10))     // NaN
```

#### Prometheus 的函数处理逻辑

既然明白了 `NaN` 的特性, 接着我们来看  `sum` 函数 和 `avg` 函数 的源码是如何处理运行和处理数据的, 想直接跳往文件位置的读者可以点击这两个链接直接跳去相关文件: [sum](https://github.com/prometheus/prometheus/blob/f0a439bfc5d1f49cec113ee9202993be4b002b1b/promql/functions.go#L398-L406) / [avg](https://github.com/prometheus/prometheus/blob/f0a439bfc5d1f49cec113ee9202993be4b002b1b/promql/functions.go#L352-L360)

```go
// sum
func funcSumOverTime(vals []parser.Value, args parser.Expressions, enh *EvalNodeHelper) Vector {
	return aggrOverTime(vals, enh, func(values []Point) float64 {
		var sum float64
		for _, v := range values {
			sum += v.V                   // 这里可以看到, 直接累加全部的收集到的 Metrics 的值, 
		}
		return sum
	})
}

// avg
func funcAvgOverTime(vals []parser.Value, args parser.Expressions, enh *EvalNodeHelper) Vector {
	return aggrOverTime(vals, enh, func(values []Point) float64 {
		var mean, count float64
		for _, v := range values {
			count++
			mean += (v.V - mean) / count  // 这里也是类似, 把和现在差值直接加上去
		}
		return mean
	})
}
```

通过上面的代码我们可以得知, 如果 Metrics 的值里面混有 NaN 的值, 那么会直接污染整个结果, 导致输出的结果就像上面那样, 全部都是 NaN. rate 和 stddev 函数同理, 这里就不一一介绍了.

但问题又来了, 为什么 Max 和 Min 函数不受影响 ?

#### max 和 min 函数不受影响的原因

同样的, 我们还是直奔源码, 你也可以点这两个链接直接跳往文件位置: [max](https://github.com/prometheus/prometheus/blob/f0a439bfc5d1f49cec113ee9202993be4b002b1b/promql/functions.go#L372-L382) / [min](https://github.com/prometheus/prometheus/blob/f0a439bfc5d1f49cec113ee9202993be4b002b1b/promql/functions.go#L382-L395)

```go
// Max
func funcMaxOverTime(vals []parser.Value, args parser.Expressions, enh *EvalNodeHelper) Vector {
	return aggrOverTime(vals, enh, func(values []Point) float64 {
		max := values[0].V
		for _, v := range values {
			if v.V > max || math.IsNaN(max) {  // 过滤 NaN
				max = v.V
			}
		}
		return max
	})
}

// Min
func funcMinOverTime(vals []parser.Value, args parser.Expressions, enh *EvalNodeHelper) Vector {
	return aggrOverTime(vals, enh, func(values []Point) float64 {
		min := values[0].V
		for _, v := range values {
			if v.V < min || math.IsNaN(min) {  // 过滤 NaN
				min = v.V
			}
		}
		return min
	})
}
```

我们可以看到这里 Max 和 Min 的实现代码中, 使用 `IsNaN 函数` 对 值进行了一个判断, 过滤掉了病毒式的 NaN 感染, 所以 Max 和 Min 函数仍然可以表现正常. 同时还发现了一个 Issue [#4385](https://github.com/prometheus/prometheus/issues/4385) , 提交 Issue 的用户 `jacksontj` 表示 NaN 干扰了他的 PromQL 的 运算结果, 并提了一个 [PR](https://github.com/prometheus/prometheus/pull/4386) 来修正这个错误. 

## 总结

至此, 这个问题的`产生原因` 和 `解决方案` 就介绍完毕了. 实际上, 笔者被这个问题大约折磨了有两个星期, 一开始笔者觉得是 函数用法不对  或者 数据有间断 以及 多余的标签干扰, 然后一直尝试各种各样的 PromQL 函数, 比如 `label_replace` .

 结果到最后还是没有解决问题, Google 了很久也无果(毕竟如果连问题原因都没定位到, Google 也无能为力). 直到有一天 点开 Prometheus 的原始查询响应 发现返回了很多 NaN, 开始怀疑是不是 NaN 的问题, 遂开始 Google 相关的关键字才找到解决方法. 

这里又回到 Leader 念叨了很多遍的话, **定位问题的 方式很关键** , 这次这个问题能拖这么久就是压根没定位到问题, 然后乱试……

最后总算是解决了这个问题, 可喜可贺, 所以这里记录下来, 供大家参考

## Ref

> * [Prometheus Docs   https://prometheus.io/docs/prometheus/latest/querying/functions/](https://prometheus.io/docs/prometheus/latest/querying/functions/)
> * [Prometheus Issue https://github.com/prometheus/prometheus/issues/860](https://github.com/prometheus/prometheus/issues/860)
> * [Prometheus Issue https://github.com/grafana/grafana/issues/8860](https://github.com/grafana/grafana/issues/8860)
> * [Prometheus Issue https://github.com/prometheus/prometheus/issues/4385](https://github.com/prometheus/prometheus/issues/4385)
> * [Prometheus Issue https://github.com/prometheus/prometheus/pull/4386](https://github.com/prometheus/prometheus/pull/4386)
> * [wikipedia https://zh.wikipedia.org/wiki/NaN](https://zh.wikipedia.org/wiki/NaN)

