# Prometheus

[TOC]

## PromQL

### 关于时间序列

```
# HELP node_cpu Seconds the cpus spent in each mode.
# TYPE node_cpu counter
node_cpu{cpu="cpu0",mode="idle"} 362812.7890625

# HELP node_load1 1m load average.
# TYPE node_load1 gauge
node_load1 3.0703125
```

以 非# 开头的每一行标示当前 Node Exporter 采集到的一个监控样本:

* node_cpu 和 node_load1 表明了 当前指标的名称
* 大括号中的标签 {cpu="cpu0", mode="idle"} 则反映了当前样本的一些特征和维度(暂时理解为 tag)
* 浮点数则是该监控样本的 具体值

### 样本

Prometheus 会将所有采集到的样本数据以 `时间序列(time-series)` 的方式保存在内存数据库中, 并且定时保存到硬盘上(刷盘).

时间序列 是按照 `时间戳` 和 `值` 的序列顺序存放的, 这被称为 向量(Vector).每条 时间序列 通过指标名称 (metrics name, 例如上面的 node_cpu 这个指标名称) 和一组 标签集 ( labelSet, 例如上面大括号中的内容.) 

那么如下图所示,  可以将 time-series 理解为一个 以时间为 Y 轴的数字矩阵:

```
  ^
  │   . . . . . . . . . . . . . . . . .   . .   node_cpu{cpu="cpu0",mode="idle"}
  │     . . . . . . . . . . . . . . . . . . .   node_cpu{cpu="cpu0",mode="system"}
  │     . . . . . . . . . .   . . . . . . . .   node_load1{}
  │     . . . . . . . . . . . . . . . .   . .  
  v
    <------------------ 时间 ---------------->
```

当 time-series 中的每一个点称为一个样本 (sample), 样本由如下三个部分组成:

* `指标 metric` :  由 metric name 和 描述当前样本特征的 labelSets 构成;
  * 可以理解成 name 和 tag
* 时间戳 timestamp : 精准到毫秒的时间戳, 主轴;
* 样本值 Value : 一个 float64 的浮点型数字标示当前样本的值;

三者的关系如下所示:

```
前面的部分也就是 metric 的name 和 labelSet 构成 metric, 后面分别是 timestamp 和 value值
<--------------- metric ---------------------><-timestamp -><-value->
http_request_total{status="200", method="GET"}@1434417560938 => 94355
http_request_total{status="200", method="GET"}@1434417561287 => 94334

http_request_total{status="404", method="GET"}@1434417560938 => 38473
http_request_total{status="404", method="GET"}@1434417561287 => 38544

http_request_total{status="200", method="POST"}@1434417560938 => 4748
http_request_total{status="200", method="POST"}@1434417561287 => 4785
```

### 指标 Metric

形式上, 所有的 指标 metric 都通过如下的格式标示: 

```
<metric name>{<label name>=<label value>, ....}
```

metric name 必须满足如下的正则表达式 `[a-zA-Z_:][a-zA-Z0-9_:]*`

label 反映了当前样本的特征维度(??), 通过这些维度 Prometheus 可以对样本数据进行过滤和聚合. 标签的名称必须满足如下正则表达式 `[a-zA-Z_][a-zA-Z0-9_]*`

其中以 `__` 作为前缀的标签, 是系统保留的关键字, 只能在系统内部使用. 标签的值则可以包含任何 Unicode 编码的字符.  在 Prometheus 的 底层实现中, 指标名称,实际上是以`__name__=<metric name>` 的形式保存在数据库中, 因此, 如下两种方式标示的 时间序列相同.

```
api_http_requests_total{method="POST", handler="/messages"}
^^^ 这里就是下面的 "__name__"

{__name__="api_http_requests_total"，method="POST", handler="/messages"}
```

而这些结构在 Prometheus 源码中是这样标示的:

```go
type Metric LabelSet

type LabelSet map[LabelName]LabelValue

type LabelName string

type LabelValue string
```

### Metric 的类型

Prometheus 的所有数据都是以 time-series 的形式保存在 Prometheus 内存的 TSDB 中, 而 time-series 所对应的 metric 也是通过 labelSet 进行唯一命名.

**从存储上来讲, 所有的监控指标 metric 都是相同的**, 但是在不同的场景下, 这些 metric 又有一些细微的差异. 所以Prometheus 定义了四种不同的指标类型 (metric Type).

* Metric Type 
  * Counter 计数器
  * Gauge 仪表盘
  * Histogram 直方图
  * Summary 摘要

通常在 Exporter 返回的样本数据中,  其注释中也包含了该样本的类型. 例如上面举过的这个例子.

```
# HELP node_cpu Seconds the cpus spent in each mode.
# TYPE node_cpu counter   <---------------------------- 这说明它是一个 Counter 类型
node_cpu{cpu="cpu0",mode="idle"} 362812.7890625
```

那么这四种类型又有什么区别呢?

#### Counter 只增不减的计数器

Counter 的指标不会减少(除非系统发生重置). 我们可以在应用程序中记录某些事件发生的次数, 然后结合 Prometheus 的 Y轴, 表现出该事件出现的频率, 了解该事件产生的速率变化. 

另外 PromQL 提供的聚合操作和函数 可以让用户对这些数据进行进一步的分析. 例如下面则两个例子

``` 
# 通过 rate() 函数 获取 请求量的增长率
rate(http_requests_total[5m])

# 查询当前系统中, 访问量前十的 HTTP 地址: 
topk(10, http_requests_total)
```

#### Gauge 可增可减的仪表盘

与 Counter 不同, Gauge 类型的指标(metric) 侧重于反映系统的当前状态. 所以这个指标的样本数据可增可减. 

常见如: 当前剩余内存大小 node_memory_MemFree 以及 node_memory_MemAvailable 可用内存大小, 都是 Gauge 类型的监控指标.

使用 Gauge 指标, 用户可以直接查看系统的当前状态: 

```
node_memory_MemFree
```

同样的, 用户也可以使用内置函数进行进一步的分析: 

```
# delta() 可以获取样本在一段时间内的变化情况, 这里表现的是 CPU 温度在 两个小时内的差异
delta(cpu_temp_celsius{host="zeus"}[2h])

# deriv() 可以计算样本的线性回归模型, 另外你也可以直接使用 predict_linear() 对数据的变化趋势进行预测
# 下面这里表现的是磁盘空间在四个小时之后的剩余情况:
predict_linear(node_filesystem_free{job="node"}[1h], 4 * 3600)
```

#### 利用 Histogram 直方图 和 Summary 摘要 分析数据分布情况

Histogram 和 Summary 主要用于统计和分析样本的分布情况. 

> 在大多数情况下人们都倾向于使用某些量化指标的平均值，例如 CPU 的平均使用率、页面的平均响应时间。这种方式的问题很明显，以系统 API 调用的平均响应时间为例：如果大多数 API 请求都维持在 100ms 的响应时间范围内，而个别请求的响应时间需要 5s，那么就会导致某些 WEB 页面的响应时间落到中位数的情况，而这种现象被称为长尾问题。
>
> 为了区分是平均的慢还是长尾的慢，**最简单的方式就是按照请求延迟的范围进行分组**。例如，统计延迟在 0~10ms 之间的请求数有多少而 10~20ms 之间的请求数又有多少。通过这种方式可以快速分析系统慢的原因。Histogram 和 Summary 都是为了能够解决这样问题的存在，通过 Histogram 和 Summary 类型的监控指标，我们可以快速了解监控样本的分布情况。

所以 Histogram 和 Summary  都是用于分组的统计, 而他们也存在一些细节的不同.

首先来看 Summary , 我们可以在 Prometheus Server 自身的监控数据中找到 指标  `prometheus_tsdb_wal_fsync_duration_seconds` 他的类型为 Summary ,  它记录了 server 中 wal_fsync 函数的处理时间, 通过访问 prometheus server 的 /metrics 接口, 可以获取到 以下监控样本数据: 

```
# HELP prometheus_tsdb_wal_fsync_duration_seconds Duration of WAL fsync.
# TYPE prometheus_tsdb_wal_fsync_duration_seconds summary
prometheus_tsdb_wal_fsync_duration_seconds{quantile="0.5"} 0.012352463
prometheus_tsdb_wal_fsync_duration_seconds{quantile="0.9"} 0.014458005
prometheus_tsdb_wal_fsync_duration_seconds{quantile="0.99"} 0.017316173
prometheus_tsdb_wal_fsync_duration_seconds_sum 2.888716127000002
prometheus_tsdb_wal_fsync_duration_seconds_count 216
```

总操作次数为 216 次, 总耗时 2.9秒左右, 百分之50 的请求 用时 0.0123 左右, 百分之99 的请求都在 0.017 秒内完成.  

另外我们来看看 Histogram , 同样我们也可以在 Prometheus Server 自身的监控数据中找到指标 `prometheus_tsdb_compaction_chunk_range_bucket`, 它的数据为 Histogram, 访问 /metrics 接口可以获取到如下监控样本数据: 

```
# HELP prometheus_tsdb_compaction_chunk_range Final time range of chunks on their first compaction
# TYPE prometheus_tsdb_compaction_chunk_range histogram
prometheus_tsdb_compaction_chunk_range_bucket{le="100"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="400"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="1600"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="6400"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="25600"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="102400"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="409600"} 0
prometheus_tsdb_compaction_chunk_range_bucket{le="1.6384e+06"} 260
prometheus_tsdb_compaction_chunk_range_bucket{le="6.5536e+06"} 780
prometheus_tsdb_compaction_chunk_range_bucket{le="2.62144e+07"} 780
prometheus_tsdb_compaction_chunk_range_bucket{le="+Inf"} 780
prometheus_tsdb_compaction_chunk_range_sum 1.1540798e+09
prometheus_tsdb_compaction_chunk_range_count 780
```

可以看到 , Histogram 类型的样本会以 区间 来反映 区间内的样本总数, 不同的 Histogram 指标反映了 不同区间内的样本个数.

从上面的例子中, 我们可以看出,  Summary默认以百分比标示 样本区间, 而 Histogram 则默认以 固定值标示样本区间. 不过事实上, 对于 Histogram 我们也可以通过 histogram_quantile() 函数计算出其值的分位数. 不过 这个函数则是在服务端将数据算出来, 然后推给客户端. 而Summary 的分位数则是在 客户端完成. 就计算分位数来说, Summary 在 通过 PromQL 查询时有更好的性能表现, 而 Histogram会更消耗服务端资源, 不过反之会比较节省客户端资源. 对于 分位数计算的选择上 , 用户应该根据自己的实际场景进行选择.



### 初识 PromQL

Prometheus 通过 Metrics Name 和 LabelSet , 指定唯一定义一条时间序列. 这里再次借用上面的图来表示.

```
  ^
  │   . . . . . . . . . . . . . . . . .   . .   node_cpu{cpu="cpu0",mode="idle"}
  │     . . . . . . . . . . . . . . . . . . .   node_cpu{cpu="cpu0",mode="system"}
  │     . . . . . . . . . .   . . . . . . . .   node_load1{}
  │     . . . . . . . . . . . . . . . .   . .  
  v
    <------------------ 时间 ---------------->
```

指标名称 Metrics Name 反映了监控样本的基本标识, 而 label 则在这个基本特征上为采集到的数据提供了多种特征维度. 用户可以基于这些特征维度 进行过滤/聚合/统计, 从而产生计算后的全新的 时间序列.



PromQL 是Prometheus 内置提供的数据查询语言, 其提供对 时间序列数据 丰富的 查询/聚合/逻辑计算能力的支持. 并且被应用到 Prometheus  的 日常应用中, 包括数据查询/可视化/告警处理中. 所以 PromQL 是Prometheus  所有应用场景的基础, 而理解和掌握 PromQL 是 Prometheus 入门的第一课.

#### 查询时间序列

當 Prometheus 通過 Exporter 採集到 相應的 監控指標樣本數據後, 我們將使用 PromQL 對監控樣本數據進行查詢, 

##### 直接指定 指標名稱(Metric Name) 進行查詢 

如果直接使用監控指標名稱進行查詢時, 可以查詢該指標下,最新的所有時間序列. 

```
# 使用如下 兩種查詢方式等價
http_requests_total
http_requests_total{}

# 將會返回所有 指標名稱爲 http_requests_total 的時間序列
http_requests_total{code="200",handler="alerts",instance="localhost:9090",job="prometheus",method="get"}=(20889@1518096812.326)
http_requests_total{code="200",handler="graph",instance="localhost:9090",job="prometheus",method="get"}=(21287@1518096812.326)
```

##### 指定 LabelSet 進行查詢

對標籤的過濾支持兩種匹配模式 : `完全匹配` 和 `正則匹配`

關於 `完全匹配模式` 可以使用 `=` 和 `!=` 來進行篩選

```
requests_total{instance="localhost:9000"}
requests_total{instance!="localhost:9000"}
```

而關於 `正則匹配模式`, 則可以使用 `label=~regx` 和 `label!~regx` 進行篩選,  例如下面這個例子

```
http_requests_total{environment=~"staging|testing|development",method!="GET"}
```

##### 範圍查詢

直接通過 上面的例子 `http_requests_total{}` 查詢時間序列時, 返回值中只會包含該時間序列中的最新的一個樣本值, 這樣的結果稱爲 `瞬時向量`. 而對應這樣的表達式稱爲 `瞬時向量表達式`.

而如果想要獲取一段時間內的樣本數據時, 則需要使用 `區間向量表達式`. 區間 和 瞬時 向量表達式 之間的差異主要在於 `區間向量表達式` 需要我們定義時間選擇的範圍. 

時間範圍通過 `時間範圍選擇器 []` 進行定義. 

```
# 這個例子的意思時選擇最近 五分鐘內 的 所有樣本數據
http_requests_total{}[5m]

# 返回值, 五分鐘內的所有時間序列的樣本數據
http_requests_total{code="200",handler="alerts",instance="localhost:9090",job="prometheus",method="get"}=[
    1@1518096812.326
    1@1518096817.326
    1@1518096822.326
    1@1518096827.326
    1@1518096832.326
    1@1518096837.325
]
http_requests_total{code="200",handler="graph",instance="localhost:9090",job="prometheus",method="get"}=[
    4 @1518096812.326
    4@1518096817.326
    4@1518096822.326
    4@1518096827.326
    4@1518096832.326
    4@1518096837.325
]
```

區間向量表達式查詢到的結果 稱爲 `區間向量`.

除了使用 m 表示分鐘外, 還支持其他的時間單位

s 秒 / m 分鐘 / h 小時 / d 天 / w 周 / y 年

##### 時間移位操作

上面介紹的兩種操作中, 都是以當前的時間爲基準, 而如果需要 指定時間作爲基準, 那麼則需要使用關鍵字 `offset`, 這個被稱爲 位移操作

```
http_requests_total{} offset 5m
http_requests_total{}[1d] offset 5m
```

##### 聚合操作

可以使用聚合函數對返回的數據進行進一步的聚合

```
# 查询系统所有http请求的总量
sum(http_request_total)

# 按照mode计算主机CPU的平均使用时间
avg(node_cpu) by (mode)

# 按照主机查询各个主机的CPU使用率
sum(sum(irate(node_cpu{mode!='idle'}[5m]))  / sum(irate(node_cpu[5m]))) by (instance)
```

##### 標量和字符串

標量只是一個數字, 沒有時序

```
1090
```

如果直接使用 字符串 作爲 PromQL 的表達式, 則會直接返回字符串

```
'hello'
"hello"
```

##### 合法的 PromQL 表達式

所有的 PromQL 表達式最少包含一個指標名稱, 或者一個 不會匹配到空字符串的標籤過濾器, 另外, 你除了可以使用`<metric name>{label=value}` 的形式之外, 你也可以使用 內置的 `__name__`標籤來指定監控指標名稱

```
http_requests_total{} # 合法
{method="get"} # 合法
{job=~".*"} # 不合法
{__name__=~"http_requests_total|helloWorld"} # 合法
```

#### PromQL 運算和操作符

除了能够查询和过滤 `时间序列` 之外, PromQL 还支持丰富的 操作符. 例如 `数学操作符`, `逻辑操作符`,`布尔运算符`

##### 数学运算

```
node_memory_free_bytes_total / (1024 * 1024)
node_disk_bytes_written + node_disk_bytes_read

# 这个运算将会得到如下的结果, 返回的新的时间序列将不会包含指标名称
{device="sda",instance="localhost:9100",job="node_exporter"}=>1634967552@1518146427.807 + 864551424@1518146427.807
{device="sdb",instance="localhost:9100",job="node_exporter"}=>0@1518146427.807 + 1744384@1518146427.807

# PromQL 支持的数学运算符 有这些 +-*/ 以及 % 取模 和 ^ 幂运算
```

##### 布尔运算

瞬时向量 和 标量进行布尔运算时, PromQL 依次比较向量中的所有时间序列样本的值, 如果比较结果为 true 则保留, 否则会排除.

瞬时向量 与 瞬时向量 直接进行布尔运算时, 同样遵循默认的匹配规则, 依次找到与左边向量元素匹配的(LabelSet 完全一致) 的 右边向量进行对应的操作, 如果没找到 LabelSet 完全一致的元素, 则直接丢弃.

PromQL 支持的布尔运算包含如下这些 `==`/`!=`/`>`/`<`/`>=`/`<=`

**使用 bool 修饰符改变布尔运算符的行为**

布尔运算符的默认行为是 `对时序数据进行过滤`. sometime 我们需要的是真正的布尔结果, 而产生全新的时间序列. 例如某个指标是否真的大于某个值, 如果大于等于则返回 1 否则置为 0. 这个时候你可以在 布尔运算后添加 bool 修饰符 改变布尔运算的默认行为.

```
http_requests_total > bool 1000
```

在使用 bool 修饰符后 , 布尔运算将不会对时间序列进行过滤, 而会依次和时间序列的各个样本数据与标量比较获取结果 0 或者 1, 从而形成全新的时间序列, 如果是对 标量和标量之间使用布尔运算, 必须使用 bool 关键字 进行修饰.

##### 集合运算符

通过集合变量, 可以将两个瞬时变量获得 交集(`and`) / 全集(`or`) / 差集(`unless`)

##### 符号优先级

1. ^
2. `* / %`
3. `+ - `
4. 布尔判断符
5. and | unless
6. or

##### PromQL 匹配模式

向量与向量间进行运算操作时, 会基于默认的匹配规则, 当两边向量的 LabelSet 完全一致的时候, 才会进行值的运算, 如果没有找到 LabelSet 完全一样的 样本, 则直接丢弃. 这样则会引申出 `一对一` 或者 `多对一` 和 `一对多` 三种关系.

**一对一**

由于有时候并不能保证向量两边 LabelSet 都一样, 所以 可以使用 on() 和 ignoring() 关键字来修改 label 内的匹配行为. 

ignoring 表示在匹配时忽略某些 label 内. on 则标示将匹配行为限制在某些 label 内.

```
<vector expr> <bin-op> ignoring(<label list>) <vector expr>
<vector expr> <bin-op> on(<label list>) <vector expr>
```

例如下面这个例子: 

```
method_code:http_errors:rate5m{method="get", code="500"}  24
method_code:http_errors:rate5m{method="get", code="404"}  30
method_code:http_errors:rate5m{method="put", code="501"}  3
method_code:http_errors:rate5m{method="post", code="500"} 6
method_code:http_errors:rate5m{method="post", code="404"} 21

method:http_requests:rate5m{method="get"}  600
method:http_requests:rate5m{method="del"}  34
method:http_requests:rate5m{method="post"} 120

# 将上面的两个向量 进行如下计算 
method_code:http_errors:rate5m{code="500"} / ignoring(code) method:http_requests:rate5m

# 将会得到如下结果
{method="get"}  0.04            //  24 / 600
{method="post"} 0.05            //   6 / 120

而 由于 method 为 put 的label 没有 code = 500 的code , 所以 在结果中, method="put" 被抛弃 
```

**一对多和多对一**

这里的一对多指的是 LabelSet 上的一对多, 另外你需要 使用 `group_left` 或者 `group_right` 来指定哪一边是 多方

```
<vector expr> <bin-op> ignoring(<label list>) group_left(<label list>) <vector expr>
<vector expr> <bin-op> ignoring(<label list>) group_right(<label list>) <vector expr>
<vector expr> <bin-op> on(<label list>) group_left(<label list>) <vector expr>
<vector expr> <bin-op> on(<label list>) group_right(<label list>) <vector expr>
```

例如下面这个例子

```
method_code:http_errors:rate5m{method="get", code="500"}  24
method_code:http_errors:rate5m{method="get", code="404"}  30
method_code:http_errors:rate5m{method="put", code="501"}  3
method_code:http_errors:rate5m{method="post", code="500"} 6
method_code:http_errors:rate5m{method="post", code="404"} 21

method:http_requests:rate5m{method="get"}  600
method:http_requests:rate5m{method="del"}  34
method:http_requests:rate5m{method="post"} 120

# 将上面两个向量 进行如下操作
method_code:http_errors:rate5m / ignoring(code) group_left method:http_requests:rate5m

# 会得到如下结果
{method="get", code="500"}  0.04            //  24 / 600
{method="get", code="404"}  0.05            //  30 / 600
{method="post", code="500"} 0.05            //   6 / 120
{method="post", code="404"} 0.175           //  21 / 120
```

#### 聚合操作

```
sum (求和)
min (最小值)
max (最大值)
avg (平均值)
stddev (标准差)
stdvar (标准差异)
count (计数)
count_values (对value进行计数)
bottomk (后n条时序)
topk (前n条时序)
quantile (分布统计)
```

#### PromQL 内置函数

查阅官方文档...

#### HTTP API 中使用 PromQL

##### 状态码

成功 2xx

参数错误 404

表达式无法执行 422

请求超时或者被中断 503

##### 响应格式

```json
{
  "status": "success" | "error",
  "data": <data>,

  // Only set if status is "error". The data field may still hold
  // additional data.
  "errorType": "<string>",
  "error": "<string>"
}
```

##### 接口 

`/api/v1/query` 或者 `/api/v1/query_range` 查询 表达式或者一定时间范围内的结果

**瞬时数据**

```
GET /api/v1/query?query=foo&time=foo

# 可用的 URL 参数
query= : PromQL 表达式
time= : 用于指定 PromQL 的时间戳,  可选参数, 默认情况下会使用当前系统时间.
timeout= : 超时设置

# 响应格式 Data
{
  "resultType": "matrix" | "vector" | "scalar" | "string",
  "result": <value>
}
```



##### 区间数据格式

```
GET  /api/v1/query_range?query=foo

# 可用的 URL 参数
query= : PromQL 表达式
start=: 起始时间。
end=: 结束时间。
step=: 查询步长。
timeout= : 超时设置

# 响应格式 Data
{
  "resultType": "matrix",
  "result": <value>
}
```



### 监控实践

##### 监控所有

Prometheus 推荐用户进入黑盒, 监控所有的东西, 下面是常用的监控指标

|   级别               | 监控什么                                              |    Exporter                     |
|--------             |---------                                             |                       ----------|
|   网络               | 网络协议：http、dns、tcp、icmp；网络硬件：路由器，交换机等  | BlackBox Exporter;SNMP Exporter |
|   主机               | 资源用量                                              |     node exporter               |
|   容器               | 资源用量                                              |     cAdvisor                    |
|   应用(包括Library)   |  延迟，错误，QPS，内部状态等                             |     代码中集成Prmometheus Client  |
|   中间件状态          |  资源用量，以及服务状态                                 |     代码中集成Prmometheus Client  |
|   编排工具           |  集群资源用量，调度等                                    |     Kubernetes Components       |

#### 四个黄金指标

* 延迟: 请求所需事件
* 通讯量: 监控当前系统的流量, 用于衡量服务的容量需求
* 错误量: 监控当前系统所有发生的错误请求，衡量当前系统错误发生的速率。
* 饱和度：衡量当前服务的饱和度。
  * CPU 和磁盘用量

##### RED 方法

在上面四个黄金指标的原则下,  RED 方法可以有效帮助用户衡量 云原生以及微服务应用下的 用户体验

* (请求) 速率：服务每秒接收的请求数。
* (请求) 错误：每秒失败的请求数。
* (请求) 耗时：每个请求的耗时。

##### USE 方法

USE 方法全称 "Utilization Saturation and Errors Method"，主要用于分析系统性能问题，可以指导用户快速识别资源瓶颈以及错误的方法。正如 USE 方法的名字所表示的含义，USE 方法主要关注与资源的：使用率 (Utilization)、饱和度 (Saturation) 以及错误 (Errors)。

* 使用率：关注系统资源的使用情况。 这里的资源主要包括但不限于：CPU，内存，网络，磁盘等等。100% 的使用率通常是系统性能瓶颈的标志。
* 饱和度：例如 CPU 的平均运行排队长度，这里主要是针对资源的饱和度 (注意，不同于 4 大黄金信号)。任何资源在某种程度上的饱和都可能导致系统性能的下降。
* 错误：错误计数。例如：“网卡在数据包传输过程中检测到的以太网网络冲突了 14 次”。

### Grafana

Dashboard => Row => Panel

### Node Exporter

每一个监控指标之前, 都会有一段类似于如下形式的信息

```
# HELP node_cpu_scaling_frequency_max_hrts Maximum scaled cpu thread frequency in hertz.
# TYPE node_cpu_scaling_frequency_max_hrts gauge
node_cpu_scaling_frequency_max_hrts{cpu="0"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="1"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="2"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="3"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="4"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="5"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="6"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="7"} 3.7e+09
node_cpu_scaling_frequency_max_hrts{cpu="8"} 3.7e+09
```

其中 

* HELP 用于解释 当前指标的含义
* TYPE 说明当前指标的数据类型

ref: 

> [Prometheus 操作指南](https://yunlzheng.gitbook.io/prometheus-book/)