# GopherChina 2020 游记 Day1

> **下文对 议题的总结是个人经验和观点, 很多并不是 议题演讲者所描述的, 可能存在 事实错误 和 描述不准确, 敬请谅解 . 若能前往 github.com/kuri-su/kblog 提出 Issue 指出错误, 着实感谢!**

[TOC]

> 博客目前不支持大纲, 只能手动做个目录惹 orz :joy: 
>
> 11.21  议题
>
> * 探探分布式存储系统实践 
> * Go 预演编程模式 (左耳朵耗子)
> * Golang in GrabFood Discovery System
> * 华为云的go语言云原生实战经验 (go-chassis huawei)
> * Go Package设计与初始化分析 (毛剑 bilibili)
>

## 探探分布式存储系统实践 

这个议题主要是在讲, 如何从 SQL 解析 到 数据落盘 做一个 tantanDB :joy:.

这个议题分为四个部分, 

* 从需求的角度谈谈为什么需要 tantanDB
* tantanDB 是什么
* 为什么选择 Golang 来做 tantanDB
* tantanDB 的路线图

### 从需求的角度谈谈为什么需要 tantanDB (需求)

探探的工程师总结 探探的业务特性包含如下特性, 

* 数据量很大, 
  * 这个点 主要和用户基数有关, 
* 数据增长速度快
  * 例如  `左滑无感,右滑喜欢`, `附近动态`, `擦肩而过` 等功能, 这些功能 会造成数据的快速增长,
* 低延时
  * 低延时主要是对比数据量来讲, 在这个数据规模下要求做到低延时返回. 例如`擦肩而过` 这个功能.

那么基于上述的 业务特性, 可以总结出一些数据特性:

* 首先数据很明显是分区的, 通常 tantan 上面找女生 都是同城会好约一些吧 :) , 再如 `擦肩而过` 这种功能, 基本都是同城数据, 
* 再有就是聚集性, 好看的女生 右滑喜欢的会非常多, 我大概是这样理解的......

![PPT p4-p5]()

#### 基于上述特性, 可以从以下三个角色对 `预选方案` 提出需求

* 架构师 角色
  * 首先由于数据量庞大, 必然不能单机承担, 并且基于上面的需求也可以看出这些数据并不是非常重要, 所以不希望想 MySQL 那样手动分表分库, 所以希望能有一些 **分布式** 特性, 例如 Hadoop
  * 对可用性有一定要求, 还是希望能够稳定
  * 对于之后的未知需求还是希望有一些扩展性 和 可定制化的空间
* 使用者 角色
  * 首先在查询语言方面, 还是希望能够用 描述能力比较强, 而且比较通用的 SQL 
  * 其次在一致性方面, 是要强一致性(ACID) 还是最终一致性(BASE), 那么从当前的需求特点上来讲, 要求 最终一致性 (BASE)会合理一些
  * 另外如果 数据库的实现中有考虑 `PACELC 理论` , 那么使用者还需要考虑由于数据库在 `一致性 和 时延` 之间的权衡, 而导致的缺数据问题

> 附录: 
>
> ACID 即 关系式数据库(e.g. MySQL) 事务正确执行所必须满足的四个特性的首字母缩写, 也可以认为是 `强一致性` 的代表
>
> 1. Atomicity（原子性）, 一个事务的所有操作，要么全部完成，要么全部不完成。
> 2. Consistency（一致性）, 指事务开始之前和事务结束之后，数据的完整性约束没有被破坏。
> 3. Isolation（隔离性）, 数据库能够防止由于多个并发事务交叉执行而导致数据的不一致。
> 4. Durability（持久性）, 指事务结束后，对数据的修改是永久的，不会回滚到之前的状态。
>
> 根据 业务特性, 可以采取 最终一致性 的方式来保证 数据可靠. 这也就提到了 BASE 理论
>
> 1. 基本可用(Basically Available) , 基本可用是指 分布式系统 在出现故障的时候,允许损失部分可用性,即保证核心可用。
> 2. 软状态(Soft State) , 软状态是指允许系统存在中间状态,而该中间状态不会影响系统整体可用性。
> 3. 最终一致性( Eventual Consistency) , 最终一致性是指系统中的所有数据副本经过一定时间后,最终能够达到一致的状态。
>
> 另外 CAP 理论在此之后也有所发展, 诞生了 `PACELC理论` , 如果有分区partition (P)，系统就必须在 可用性(availability) 和 一致性(consistency) (A and C)之间取得平衡; 否则else (E) 当系统运行在无分区情况下,系统需要在 时延(latency) (L) 和 一致性(consistency) (C)之间取得平衡.
>
> CAP 理论提出了在设计分布式存储系统时需要权衡的因素, 但未考虑到 时延(Latency) 因素, 而在分布式存储系统中, 时延 (latency) 是很重要的可靠性指标.
>
> 例如, 某个节点时延过长的时候, 我们是应该放弃那个节点的数据? 还是 继续等待直到 Timeout

* DBA 角色
  * 首先是存储成本, 一方面是数据压缩性能, 另外是磁盘读写要求是否很高, 是否只能跑在 SSD 上
  * 另外需要运维友好
  * 此外, 容灾的能力也要考虑进去

![PPT P6]()

#### 让我们看看开源的方案

开源方案在 分布式存储系统方面 无外乎两种, `NoSQL` 和 `NewSQL`, 

NoSQL 有如下几个问题

1. SQL 限制, NoSQL 对 SQL 的支持一向不是很好, 有些甚至是自造的 DSL
2. 存储成本
3. 定制化难度较高

NewSQL 则有另外一些问题: 

1. 存储成本
2. 过于强调强一致性, 而这一点在 探探 的业务中可能并不是特别看中
3. ACID 也是一样的 point
4. 延迟方面则是另一个点
5. 再就是定制化的需求

因此, 决定自造 TantanDB

### tantanDB 是什么

![tantanDB 结构图]() ![TiDB 结构图]()

tantanDB分为三个部分, 结构上和 TiDB 有点相似, 不过在设计的侧重点上和 TiDB 并不一样.

1. ttdb-SQL 负责解析 SQL 语法, 转化成 DML(数据操控语言,例如 insert && delete && update 操作 ) 和 DQL(数据查询语言, 例如 SELECT 操作) , 提交给 ttdb-kv 

   * 这层类似于 TiDB 的 DB 层, 作为接入层, 负责解析请求, 并下推给 KV 节点
   
   ![]()

2. ttdb-KV 负责数据的存储查询和落盘,
   ![]()
3. ttdb-controller 负责作为调度节点, 来调度请求 和 检测心跳 以及 执行故障检测 等操作.

   * controller 层的元数据存储在一个由 Zookeeper 组成的 Raft 一致性集群中, 然后和 K8s Master 节点类似的 StandBy 结构来保证高可用.

   ![]()

另外会提供 Client 的  SDK , SDK 和 controller 之间也会保持心跳.

#### SQL 部分

![PPT-P11]()

SQL 部分主要分为以下三层

* Parser 层, 主要是语法分析
* Planer 层, 主要是 SQL 优化器层面
* Executor 层, 主要是 执行层面

在 TiDB 的开源代码里也可以看到类似的结构, 可以前往 [此处](https://github.com/pingcap/tidb) 查看.

##### Parser 层

主要是对 SQL 进行 Lex 词法分析转化为 Tokens, 然后再由 Yacc 的 语法分析转化为 AST , 接着经过一层 校验器, 验证语法是否正确, 再给到 优化器那一层.

在 会场的 QA 环节有人问 Lex 的效率问题, 因为每一次 SQL 查询 都得重新做 字符串 到 AST 的解析, 所以担心 C 的 Lex 和 Go 原生 Lex 的效率问题, 不过笔者还没比较过二者的区别... 改天写个 Demo 试试... 

> // TODO
>
> Lex 规则: 
>
> GoLex 规则: 
>
> Yacc 规则: 

##### Planer 层

这一层列出了两个 优化器, `Logical Optimizer` 和 `Physical Optimizer`, 分别标记为 RBO( Rule-Based Optimization 基于规则的优化器 ) 和 CBO( Cost-Based Optimization 基于代价的优化器 ), 下面贴上 CBO 和 RBO 的区别.

|          | CBO                                                 | RBO                               |
| -------- | --------------------------------------------------- | --------------------------------- |
| 定义     | 基于成本的优化                                      | 基于规则的优化                    |
| 目的     | 为每个SQL语句提供最便宜的执行计划                   | RBO使用一组规则来确定如何执行查询 |
| 支持     | Spark sql、Hive、Presto、Mysql 、Oracle和SQL Server | 几乎所有都支持                    |
| 实现难度 | 实现困难，以空间换时间                              | 实现容易，但是以时间换空间        |

在 Oracle 中, CBO 被认为是 优于 RBO 的优化策略, 因为 RBO 是一种呆板的优化器, 它只认规则, 对数据不敏感. 这样生成的执行计划往往是不可靠的, 不是最优的.

CBO优化器根据SQL语句生成一组可能被使用的执行计划，估算出每个执行计划的代价，并调用计划生成器（Plan Generator）生成执行计划，比较执行计划的代价，最终选择选择一个代价最小的执行计划。查询优化器由查询转换器（Query Transform）、代价估算器（Estimator）和计划生成器（Plan Generator）组成。

![ex](https://images0.cnblogs.com/blog/73542/201407/141040329593353.png)

TiDB 的 开源代码里也可以看到类似的结构, 感兴趣可以前往 [此处](https://github.com/pingcap/tidb/tree/master/planner/core) 查看. 

##### Executor 层

![PPT-P11]()

Executor 层有两个执行器, 一个是 Root Executor (根执行器) , 一个 是 distributed Executor (分布式执行器). 会有两个执行器的原因是由于这是一个分布式数据库, 从各个方面来讲, 都不能由 Root Executor 来干完全部工作, 那么必然推给每个 Exceutor 去找对应的 KV 节点执行命令, 再聚合到 当前节点上.

PingCap 在 17 年的 GopherChina 的 PPT 里也有提到 TiDB 的相关实现, 如下图

![TiDB SQL 解析部分]()

#### SQL 优化器

![PPT-P12]()

在 PPT 里着重介绍了下关于 RBO 优化器的部分, 主要有如下这些, 

* 列裁剪(prune columns)
* 谓词下推 (push down predicate)
* 聚合下推(push down aggregation)
* topN 下推(push down topN)

下面会用这个 SQL 例子来讲解优化过程

```sql
select 10 + 30, users.name, users.age
from users join jobs on users.id= user.id
where users.age > 30 and jobs.id>10
```

##### 列裁剪

列裁剪是一个很经典的优化规则,  对于上面实例的 Jobs 表来说, 其实只需要保留 jobs 表的 id 字段即可, 其他的字段都没有用到, 这样可以减少 网络IO 和资源的损耗. 例如下面这个大佬列出来的图中一样

![ex](https://matt33.com/images/calcite/8-pruning.png)

##### 谓词下推

SQL 中的 `谓词` 指的是, 返回值是逻辑值的函数, 例如上面例子中的 users.id = user.id 这种.

那么谓词下推就不难理解, 属于逻辑优化，优化器将谓词过滤下推到数据源，使物理执行跳过无关数据。最常见的例子就是 join 与 filter 操作一起出现时，提前执行 filter 操作以减少处理的数据量，将 filter 操作下推.

![ex](https://matt33.com/images/calcite/6-filter-pushdown.png)

聚合下推和 TopN 下推也类似, 尽量将计算 下推到距离数据源近的地方, 以尽早完成数据的过滤, 进而显著的减少数据传输 或 计算开销. 其他更多的 常见 RBO 策略,可以参考 [TiDB in action](https://book.tidb.io/session3/chapter1/optimizer-summary.html) 中的表格

| 列表 1            | 列表 2                |
| ----------------- | --------------------- |
| 1、列裁剪         | 6、外连接转内连接     |
| 2、分区剪裁       | 7、子查询去关联       |
| 3、聚合消除       | 8、谓词下推           |
| 4、Max / Min 优化 | 9、聚合下推           |
| 5、外连接消除     | 10、TopN / Limit 下推 |

#### 火山执行器(Volcano Model executor) 和 向量化模型执行器(Vectorization Model executor)

![PPT-P13~P14]()

所谓火山执行器, 是描述 一次查询如何执行的一个过程. 首先 请求从 `root executor` 出发, 向下逐步递交, 直到 `index scan` 进行 name 扫描, 然后逐步筛选返回. 但笔者有点遗忘了, 这二者的区别, 看起来一个是列式查询, 一个是行式查询.

#### 数据分片

// TODO

#### KV 节点 (笔者补充)

![PPT P9 KV 细节图]()

笔者补充一下 PPT 上没有提到的 KV 节点部分. KV 节点 分为两个部分, 一个 Primary 部分, 负责接受 和 响应 ttdb-SQL 层的请求, 然后将更改通过 binlog 的方式给到 replica 节点部分, 来重放并落盘. 

整体结构 与 RocksDB 类似, Primary 是 热数据部分, 可以理解成 RocksDB 中的 MemTable , 负责缓存热数据, replica 类似于 RocksDB 中的 SST . 

#### 高可用

##### 故障检测

![PPT P19]()

高科用的第一个部分就是 故障检测, 故障检测通常有两种 `中心化的` 和 `无中心化的`,   

* 中心化的通常有两个问题,
  * 假阳性, 就是在故障检测器认为正常的时候, 实质上 机器是挂掉的....
  * 再就是在节点和故障检测器网络分区的时候, 故障检测器会错误的认为 大部分节点都下线, 事实上可能这些节点都可以使用
* 去中心化的方案也有些问题
  * // TODO  https://iswade.github.io/database/db_internals_ch09_failure_detection/

![PPT P20]()

##### 故障恢复

![PPT P21~P22]()

如果是节点异常的话, 例如上面例子中 , 本该向 Node 2~4 同步 binlog 的 Node 1 故障下线, 那么将立刻选出 Binlog 最全的 Node 2 来向 Node 3~4 同步 Binlog

![PPT P23]()

如果是 目前工作的 Master 异常导致 Session 超时的话, 会像 K8s 的 Master 一样, 由其他 StandBy 的节点 去抢 分布式锁, 抢到锁的那个 Master 节点会当选继任 Master. 其他节点继续 StandBy, 然后在和其他节点的心跳包中, 声明 Master 的节点的更换.

![PPT P24]()

但节点的异常切换也带来问题, 就是由于数据库缓存的存在, KV 节点对于一条数据会有 热节点 和 冷节点的概念. 那么当热节点 下线后, 新顶上的 冷节点 收到请求需要较多的时间预热数据, 导致时延会瞬间飙高, 这是不能接受的

![PPT P25]()

为了解决这个问题, 在 ttdb-SQL 节点发送请求给 下层 KV 节点的时候, 将会以一定机率发送 同样的请求给别的有同样数据的节点, 来预热数据. 

![PPT P26]() 

##### 一致性和可用性方面

![PPT P27]()

刚刚也讲了, 由于 业务特性 的原因, 所以我们可以接受一部分数据的丢失或者失败, 所以会像上图表示的这样.

后略, [完]

## Go Programming Patterns - 左耳朵耗子

左耳朵耗子的分享带来的是 Go 编程范式的议题. 将分为如下几个 小节来分享

* Basic Coding
* Error Handling
* Delegation / Embed
* Functional Option
* Map && Reducs && Filter
* Go Generation
* Decoration
* Kubernetes Visitor
* Pipeline

### Basic Coding

#### Tips1 Slice 

Slice 是一个结构体, 结构如下

```go
type slice struct {
    array unsafe.Pointer
    len   int
    cap   int
}
```

这里 slice.array 字段 是一个连接到实际数组的指针, 这就是 slice 长度可变的关键 

##### Slice share memory

```go
foo := make([]int,5)
foo[3]=42
foo[4]=100

bar := foo[1:4]
bar[1]=99

fmt.Println(foo)
// 0,0,99,42,100
fmt.Println(bar)
// 0,99,42,100
```

但在超过 cap 的时候, 将会自动扩容,并重新分配内存

```go
a := make([]int, 32)
b := a[0:16]
a = append(a, 1)
a[2] = 42

fmt.Printf("%p,%d,%d,%v \n", a, len(a), cap(a), a)
// 0xc0000c2000,len: 33, cap: 64, [0 0 42 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1] 
fmt.Printf("%p,%d,%d,%v \n", b, len(b), cap(b), b)
// 0xc0000c0000,len: 16, cap: 32, [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]  
fmt.Println(unsafe.Pointer(&a[0]))
// 0xc0000c2000
fmt.Println(unsafe.Pointer(&b[0]))
// 0xc0000c0000    // 注意变量地址已经变了, 说明已经用的不是同一个数组了
```

##### Slices overlapped (Slice 堆叠覆盖) 

 ```go
path := []byte("AAAA/BBBBBB")
fmt.Printf("raws: %p,len: %d, cap: %d, %v \n", path, len(path), cap(path), path)
// raws: 0xc00018c000,len: 11, cap: 11, AAAA/BBBBBB
sepIndex := bytes.IndexByte(path, '/')
fmt.Println("sepIndex", sepIndex)
// sepIndex 4

dir1 := path[:sepIndex]
dir2 := path[sepIndex+1:]

fmt.Printf("dir1: %p,len: %d, cap: %d, %v , %s \n", dir1, len(dir1), cap(dir1), dir1, string(dir1))
// dir1: 0xc00018c000,len: 4, cap: 11, [65 65 65 65] , AAAA 
fmt.Printf("dir2: %p,len: %d, cap: %d, %v , %s \n", dir2, len(dir2), cap(dir2), dir2, string(dir2))
// dir2: 0xc00018c005,len: 6, cap: 6, [66 66 66 66 66 66] , BBBBBB

dir1 = append(dir1, "suffix"...)

fmt.Println("raws =>", string(path))
// raws => AAAAsuffixB
fmt.Printf("dir1: %p,len: %d, cap: %d, %v , %s \n", dir1, len(dir1), cap(dir1), dir1, string(dir1))
// dir1: 0xc00018c000,len: 10, cap: 11, [65 65 65 65 115 117 102 102 105 120] , AAAAsuffix
fmt.Printf("dir2: %p,len: %d, cap: %d, %v , %s \n", dir2, len(dir2), cap(dir2), dir2, string(dir2))
// dir2: 0xc00018c005,len: 6,  cap: 6, [117 102 102 105 120 66] , uffixB
 ```

可以看到由于 dir1 和 dir2 都来自 `path 切片`,并且共享下层同一个数组, 所以在对 dir1 进行 append 操作的时候, 会对影响到 path 切片依赖的下层数组, 进而影响 dir2 slice. 那么我们如何避免这个问题呢?

```go
path := []byte("AAAA/BBBBBB")
fmt.Printf("raws: %p,len: %d, cap: %d, %v \n", path, len(path), cap(path), string(path))
// raws: 0xc00018c000,len: 11, cap: 11, AAAA/BBBBBB 
sepIndex := bytes.IndexByte(path, '/')
fmt.Println("sepIndex", sepIndex)
// sepIndex 4

dir1 := path[:sepIndex:sepIndex]
dir2 := path[sepIndex+1:]

fmt.Println(unsafe.Pointer(&path[0]))
// 0xc00018c000
fmt.Println(unsafe.Pointer(&dir1[0]))
// 0xc00018c000
fmt.Printf("dir1: %p,len: %d, cap: %d, %v , %s \n", dir1, len(dir1), cap(dir1), dir1, string(dir1))
// dir1: 0xc00018c000,len: 4, cap: 4, [65 65 65 65] , AAAA 
fmt.Printf("dir2: %p,len: %d, cap: %d, %v , %s \n", dir2, len(dir2), cap(dir2), dir2, string(dir2))
// dir2: 0xc00018c005,len: 6, cap: 6, [66 66 66 66 66 66] , BBBBBB 

dir1 = append(dir1, "suffix"...)

fmt.Println(unsafe.Pointer(&path[0]))
// 0xc00018c000
fmt.Println(unsafe.Pointer(&dir1[0]))
// 0xc00018c040
fmt.Println("raws =>", string(path))
// raws => AAAA/BBBBBB
fmt.Printf("dir1: %p,len: %d, cap: %d, %v , %s \n", dir1, len(dir1), cap(dir1), dir1, string(dir1))
// dir1: 0xc00018c040,len: 10, cap: 16, [65 65 65 65 115 117 102 102 105 120] , AAAAsuffix 
fmt.Printf("dir2: %p,len: %d, cap: %d, %v , %s \n", dir2, len(dir2), cap(dir2), dir2, string(dir2))
// dir2: 0xc00018c005,len: 6, cap: 6, [66 66 66 66 66 66] , BBBBBB 
```

通过输出我们可以看出, 这次是符合我们预期的状态. 这两段代码唯一的区别点在于 dir1 第一次赋值的时候使用了 `dir1 := path[:sepIndex:sepIndex]` 这样的一个方式, 我们比较少这么写, 但这个实际上才是完整的 Slice 表达式, 以下面的这个例子为例: 

```go
slice := []string{"a", "b", "c", "d"}

a := slice[0:2:2]
fmt.Printf("%p,%d,%d,%v \n", a, len(a), cap(a), a)
// 0xc000100040,2,2,[a b] 
b := slice[0:2]
fmt.Printf("%p,%d,%d,%v \n", b, len(b), cap(b), b)
// 0xc000100040,2,4,[a b] 
```

使用 slice[0:2:2] 和 slice[0:2] 的结果区别在于, slice[0:2:2] 生成的slice 的 cap 等于 2, 这样依赖 slice的 a 在追加元素的时候, 会重新分配 内存也就是底层数组, 这样就不会影响原来的 Slice.

#### Tips2 Deep Comparison

通常会有一些 结构体的比较需求, 对于这种需求, 通常我们使用 reflect 包的  DeepEqual 方法来比较, 以下面这个例子为例, 

```go
type data struct {
	num    int               //ok
	checks [10]func() bool   //not comparable
	doit   func() bool       //not comparable
	m      map[string]string //not comparable
	bytes  []byte            //not comparable
}
```

reflect.DeepEqual 方法对于 Struct 的话, 只能比较简易类型, 如果出现不能比较的类型只能返回 false ,例如下面这样

```go
func main() {
	v1 := data{num: 1,}
	v2 := data{num: 1,}
	fmt.Println("v1 == v2:", reflect.DeepEqual(v1, v2))
	//prints: v1 == v2: true
    
    v3 := data{
		num: 1,
		doit: func() bool {
			return true
		},
	}
	v4 := data{
		num: 1,
		doit: func() bool {
			return true
		},
	}
	fmt.Println("v3 == v4:", reflect.DeepEqual(v3, v4))
    //prints: v3 == v4: false

	m1 := map[string]string{"one": "a", "two": "b"}
	m2 := map[string]string{"two": "b", "one": "a"}
	fmt.Println("m1 == m2:", reflect.DeepEqual(m1, m2))
	//prints: m1 == m2: true

	s1 := []int{1, 2, 3}
	s2 := []int{1, 2, 3}
	fmt.Println("s1 == s2:", reflect.DeepEqual(s1, s2))
	//prints: s1 == s2: true
    
    
}
```

#### Function vs Receiver

// TODO

#### Time 



#### Performance Tips



### Error Handling
### Delegation / Embed
### Functional Option
### Map && Reducs && Filter
### Go Generation
### Decoration
### Kubernetes Visitor
### Pipeline

## Functional options and config for APIs - 毛剑@bilibili

// TODO

## Golang In GrabFood Discovery System

// TODO

## 华为云的 Go 语言云原生实践

// TODO





















## ref

> * [[数据库基础]-- CBO and RBO optimizers](https://blog.csdn.net/high2011/article/details/86488299)
>
> * [[详解分布式一致性ACID、CAP、BASE，以及区别](https://youzhixueyuan.com/distributed-consistency-cap-base.html)](https://youzhixueyuan.com/distributed-consistency-cap-base.html)
>
> * [是时候把分布式存储系统的理论指导从CAP转到PACELC](https://stor.51cto.com/art/201806/575717.htm)
>
> * ###### [ORACLE优化器RBO与CBO介绍总结](https://www.cnblogs.com/kerrycode/p/3842215.html)
>
> * [Apache Calcite 优化器详解（二）](https://matt33.com/2019/03/17/apache-calcite-planner/#%E5%88%97%E8%A3%81%E5%89%AA%EF%BC%88Column-Pruning%EF%BC%89)
>
> * TiDB 源码阅读系列文章（八）基于代价的优化