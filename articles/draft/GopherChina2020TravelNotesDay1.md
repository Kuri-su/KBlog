# GopherChina 2020 游记 Day1-1

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
> 例如, 某个节点时延过长的时候, 是应该放弃那个节点的数据? 还是 继续等待直到 Timeout

* DBA 角色
  * 首先是存储成本, 一方面是数据压缩性能, 另外是磁盘读写要求是否很高, 是否只能跑在 SSD 上
  * 另外需要运维友好
  * 此外, 容灾的能力也要考虑进去

![PPT P6]()

#### 让看看开源的方案

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

在 Go 中, 推荐以函数接受者的方式来组合 特性, 而 Interface 也是组合的一个关键点, 来看下面这一段代码

##### Interface Patterns

```go
type Country struct {
	Name string
}
type City struct {
	Name string
}
type Printable interface {
	PrintStr()
}

func (c Country) PrintStr() { fmt.Println(c.Name) } 
func (c City) PrintStr()    { fmt.Println(c.Name) }
// 这两个Struct 都分别实现了输出的功能

func main() {
	c1 := Country{"China"}
	c2 := City{"Beijing"}
	c1.PrintStr()
	c2.PrintStr()
}
```

我们可以通过将具体实现抽成 Interface

```go
type Country struct {
	Name string
}
type City struct {
	Name string
}
type StringAble interface {
	ToString() string
}

func (c Country) ToString() string { return "Country = " + c.Name }
func (c City) ToString() string    { return "City = " + c.Name }

func PrintStr(p StringAble) {
	fmt.Println(p.ToString())
}

func main() {
	c1 := Country{"China"}
	c2 := City{"Beijing"}
	PrintStr(c1)
	PrintStr(c2)
}
```

之前做过面向对象编程的同学应该不会陌生 这种思想, 另外像 go 标准库的  io.Reader 和 io.Writer 接口 也是使用类似的思想.

这里引出一条 Golden Rule

> Program to an interface not an implementation

#### Verify Interface Compliance (验证是否实现 Interface )

```go
type Shape interface {
	Sides() int
	Area() int
}
type SquareIF interface {
	Sides() int
}
type Square struct {
	len int
}

func (s *Square) Sides() int {
	return 4
}
func main() {
	var _ SquareIF = (*Square)(nil)
	// it will panic
	// var _ Shape = (*Square)(nil)

	s := Square{len: 5}
	fmt.Printf("%d\n", s.Sides())
}
```

例如上面的代码, 将 nil 强转为 `Square 类型的指针` 然后赋值给 SquareIF 类型的变量, SquareIF 是一个Interface , 如果 Square 实现了 SquareIF 的全部接口, 那么这个赋值将会成功, 否则就像被注释掉的那句, 如果 Square 赋值给 Shape 类型的时候, 将会报错.

笔者也没有用过这种方式, 但猜测可以用来对一些类型判断是否有实现 接口. 主要是应用在一些灵活的实现上.

#### Time 

时间的处理过于 Difficult! 如果可以请尽量使用 标准库的 time.Time 和 time.Duration. 如果实在需要自己处理的话, 可以考虑使用 RFC 3339, 因为 flag 包, encoding/json 包, 还有 database/sql 和 gopkg.io/yaml.v2 包都对它有比较好的支持 .

#### Performance Tips

* 使用 strconv 代替 fmt

  ```go
  for i := 0; i < b.N; i++ {
      s := fmt.Sprint(rand.Int())   // 143 ns/op
  } 
  for i := 0; i < b.N; i++ {
      s := strconv.Itoa(rand.Int()) // 64.2 ns/op
  } 
  ```
  
* 避免 string 到 byte 的转换
  ```go
  for i := 0; i < b.N; i++ {
      w.Write([]byte("Hello world")) // 22.2 ns/op
  }
  data := []byte("Hello world")
  for i := 0; i < b.N; i++ {
      w.Write(data)                  // 3.25 ns/op
  }
  ```
  
* 新建大型切片的时候, 指定切片容量
  ```go
  for n := 0; n < b.N; n++ {
      data := make([]int, 0)         // 100000000 2.48s
      for k := 0; k < size; k++{
          data = append(data, k)    
      }
  }
  for n := 0; n < b.N; n++ {
      data := make([]int, 0, size)   // 100000000 0.21s
      for k := 0; k < size; k++{
          data = append(data, k)
      }
  }
  ```
  因为 会触发多次 Slice 扩容
  
* 使用 StringBuffer 或者 StringBuilder 来代替字符串拼接

  ```go
  var strLen int = 30000
  var str string
  for n := 0; n < strLen; n++ { // 12.7 ns/op
      str += "x"
  }
  
  var builder strings.Builder
  for n := 0; n < strLen; n++ { // 0.0265 ns/op
      builder.WriteString("x")
  }
  var buffer bytes.Buffer
  for n := 0; n < strLen; n++ { // 0.0088 ns/op
      buffer.WriteString("x")
  }
  ```
  
* 使多个 IO 操作异步进行

  * 并且可以使用 sync.WaitGroup 同步哪些操作

* 避免在热点代码(频繁运行的代码)中分配内存

  * 不仅需要占用 CPU 周期来分配内存，而且还会使垃圾收集器变得繁忙。 如果可以的话, 尽可能使用 sync.Pool 这类对象池重用对象，尤其是在程序热点.

* 支持无锁算法

  * 尽可能避免互斥。 可以使用以 sync包 或者 atomic 包中的一些数据结构来代替锁.

* 使用 缓冲(buffer) IO

  * 每个字节访问磁盘效率很低； 读取和写入更大的数据块可以大大提高速度。 使用bufio.NewWriter（）或bufio.NewReader（）可能会有所帮助

* 尽量使用已编译的正则表达式, 进行重复匹配

  * 在每次匹配之前编译相同的正则表达式效率低下

* 尽量使用 Protobuf 而不是 Json

  * JSON使用反射, 由于反射工作量较大，因此反射速度相对较慢. 可以考虑使用 protobuf 或者 MessagePack

* 延伸阅读

  * Effective Go
    * https://golang.org/doc/effective_go.html
  * Uber Go Style
    * https://github.com/uber-go/guide/blob/master/style.md
  * 50 Shades of Go: Traps, Gotchas, and
    Common Mistakes for New Golang Devs
    * http://devs.cloudimmunity.com/gotchas-and-common-mistakes-in-go-golang/
  * Go Advice
    * https://github.com/cristaloleg/go-advice
    * Chinese version: https://github.com/cristaloleg/go-advice/blob/master/README_ZH.md
  * Practical Go Benchmarks
    * https://www.instana.com/blog/practical-golang-benchmarks/
  * Benchmarks of Go serialization methods
    * https://github.com/alecthomas/go_serialization_benchmarks
  * Debugging performance issues in Go programs
    * https://github.com/golang/go/wiki/Performance
  * Go code refactoring: the 23x performance hunt
    * https://medium.com/@val_deleplace/go-code-refactoring-the-23x-performance-hunt-156746b522f7

### Delegation / Embed (嵌入模式)

#### Example 1

假设一个使用 Go 实现 GUI 的场景, 我们目前有两种组件 `Button` 和 `ListBox` , 然后 Button 需要有 Label 用于标识 字符

```go
// 基础属性 和 接口
type Widget struct {
	X, Y int
}
type Label struct {
	Widget        // Embedding (delegation)
	Text   string // Aggregation
}

func (label Label) Paint() {
	fmt.Printf("%p:Label.Paint(%q)\n", &label, label.Text)
}

type Painter interface {
	Paint()
}
type Clicker interface {
	Click()
}
```

```go
// 上层 组件
// 按钮
type Button struct {
	Label // Embedding (delegation)
}
func NewButton(x, y int, text string) Button {
	return Button{Label{Widget{x, y}, text}}
}
func (button Button) Paint() { // Override
	fmt.Printf("Button.Paint(%s)\n", button.Text)
}
func (button Button) Click() {
	fmt.Printf("Button.Click(%s)\n", button.Text)
}

// 下拉选框
type ListBox struct {
	Widget          // Embedding (delegation)
	Texts  []string // Aggregation
	Index  int      // Aggregation
}
func (listBox ListBox) Paint() {
	fmt.Printf("ListBox.Paint(%q)\n", listBox.Texts)
}
func (listBox ListBox) Click() {
	fmt.Printf("ListBox.Click(%q)\n", listBox.Texts)
}
```

通过嵌入模式, 使用者的代码将非常简洁

```go
func main() {
	label := Label{Text: "AT"}
	button1 := Button{Label{Widget{10, 70}, "OK"}}
	button2 := NewButton(50, 70, "Cancel")
	listBox := ListBox{Widget{10, 40},
		[]string{"AL", "AK", "AZ", "AR"}, 0}

	// 绘制 元素
	for _, painter := range []Painter{label, listBox, button1, button2} {
		painter.Paint()
	}
	// 点击
	for _, widget := range []interface{}{label, listBox, button1, button2} {
		if clicker, ok := widget.(Clicker); ok {
			clicker.Click()
		}
	}
}
```

#### Example 2

// TODO

### Error Handling

Go 的 err != nil 被各方诟病, 那有没有办法来优化它呢? 

#### `if err!=nil Checking` Hell

因为每一层都需要 判断是否出错, 再进行下一步操作, 这样很痛苦...

```go
func parse(r io.Reader) (*Point, error) {
	var p Point
	if err := binary.Read(r, binary.BigEndian, &p.Longitude); err != nil {
		return nil, err
	}
	if err := binary.Read(r, binary.BigEndian, &p.Latitude); err != nil {
		return nil, err
	}
	if err := binary.Read(r, binary.BigEndian, &p.Distance); err != nil {
		return nil, err
	}
	if err := binary.Read(r, binary.BigEndian, &p.ElevationGain); err != nil {
		return nil, err
	}
	if err := binary.Read(r, binary.BigEndian, &p.ElevationLoss); err != nil {
		return nil, err
	}
}
```

#### 只解决当下问题

那么我们第一步优化, 解决代码冗长的问题, 将判断函数抽出来作为一个闭包, 当错误发生时, 直接 return 即可.

```go
func parse(r io.Reader) (*Point, error) {
	var p Point
	var err error
	read := func(data interface{}) {  // Closure for errors
		if err != nil {
			return
		}
		err = binary.Read(r, binary.BigEndian, data)
	}
	read(&p.Longitude)
	read(&p.Latitude)
	read(&p.Distance)
	read(&p.ElevationGain)
	read(&p.ElevationLoss)
}
```

但这个方案有些局限, 毕竟不是每个方法都能抽象成这样子, 有没有什么通用些的方法? 

#### 看看 bufio.Scanner 是怎么做的

```go
scanner := bufio.NewScanner(input)
for scanner.Scan() {
    token := scanner.Text()
    // process token
}
if err := scanner.Err(); err != nil {
    // process the error
}
```

它的Scan方法执行基础的I / O，这当然会导致错误。 但是Scan方法根本不会暴露错误。 而是返回一个布尔值。在扫描结束时运行的另一种方法将报告是否发生错误。

接着去看看 Scan 对象的结构体

```go
type Scanner struct {
	// ....
	err          error     // Sticky error. <--- look at this
	// ....
}

// 接着 Scanner 有一个 Err 方法 , 用来确认是否产生错误
func (s *Scanner) Err() error {
	if s.err == io.EOF {
		return nil
	}
	return s.err
}
```

#### 使用一个带有 err 字段的 对象

```go
type Reader struct {
    r   io.Reader
    err error
}

func (r *Reader) read(data interface{}) {
    if r.err == nil {
        r.err = binary.Read(r.r, binary.BigEndian, data)
    }
}
```

接着使用这个字段 来写一段业务代码试试

```go
func parse(input io.Reader) (*Point, error) {
	var p Point
	r := Reader{r: input}
	r.read(&p.Longitude)
	r.read(&p.Latitude)
	r.read(&p.Distance)
	r.read(&p.ElevationGain)
	r.read(&p.ElevationLoss)

	if r.err != nil {
		return nil, r.err
	}

	return &p, nil
}
```

这么写之后, 代码清晰很多, 但是只有唯一的一个问题, 我们无法使其通用, **我们必须为每一种类型定义一个 包装器结构体**, 例如上面的 Reader 对象.

* 延伸阅读
  * Golang Error Handling lesson by Rob Pike
    * http://jxck.hatenablog.com/entry/golang-error-handling-lesson-by-rob-pike
  * Errors are values
    * https://blog.golang.org/errors-are-values 

#### github.com/pkg/errors

BTW ,  你也可以使用 `github.com/pkg/errors` 这个包来代替 标准库的 errors 包, 这个包除了基础的 错误包装功能之外, 还会自动带堆栈信息, 甚至支持 路径脱敏, 详情可以参考这一篇 [对 `github.com/pkg/errors` 的介绍]().

### Functional Option

由于 Go 没有支持不同类型 并且 可变数量的参数列表, 导致在一些需要选择参数的场景下会很不方便, 我们以 Http.Server 来举例

```go
type Server struct {
	Addr     string
	Port     int
	Protocol string
	Timeout  time.Duration
	MaxConns int
	TLS      *tls.Config
}

func NewServer(addr string, port int) (*Server, error) {
	//...
}
func NewTLSServer(addr string, port int, tls *tls.Config) (*Server, error) {
	//...
}
func NewServerWithTimeout(addr string, port int, timeout time.Duration) (*Server, error) {
	//...
}
func NewTLSServerWithMaxConnAndTimeout(addr string, port int, maxconns int, timeout time.Duration, tls *tls.Config) (*Server,
	error) {
	//...
}
```

为了方便用户 新建 Server 对象, 这个例子里提供了 4 个方法来方便不同的需求, 并且未来极有可能迅速增多. 这种代码实在是重复并且难以维护.  那么是否有更加优雅的方式来完成这个事情呢? 

#### 一种通用的解决方案

```go
// 专用的结构体
type Config struct {
	Protocol string
	Timeout  time.Duration
	Maxconns int
	TLS      *tls.Config
}

type Server struct {
	Addr string
	Port int
	Conf *Config
}

func NewServer(addr string, port int, conf *Config) (*Server, error) {
	//...
}

func main() {
	//Using the default configuration
	srv1, _ := NewServer("localhost", 9000, nil)

	conf := Config{Protocol: "tcp", Timeout: 60 * time.Second}
	srv2, _ := NewServer("locahost", 9000, &conf)
}
```

利用这样一个Config 结构体, 可以很好的区分 必填参数和选填参数. 但通过 这种 Config Struct 的方式, 库的编写者难以应用 一些默认值, 当 使用者将 Config Struct 传入的时候, 很难判断每个值是否有填,若没填给他默认值. 那么还有没有别的办法解决这个问题呢?

#### Functional Option

直译可以称为 功能选项(Functional Option), 通过向外暴露一组对 `选填参数` 的修改方法, 来达到二者接可得的目的, 可以来看看下面的例子.

```go

type (
	Server struct {
		Addr     string
		Port     int
		Protocol string
		Timeout  time.Duration
		MaxConns int
		TLS      *tls.Config
	}
	Option func(*Server)
)

func Timeout(timeout time.Duration) Option {
	return func(s *Server) { s.Timeout = timeout }
}
func TLS(tls *tls.Config) Option {
	return func(s *Server) { s.TLS = tls }
}
func Protocol(p string) Option {
	return func(s *Server) { s.Protocol = p }
}
func MaxConns(maxconns int) Option {
	return func(s *Server) { s.MaxConns = maxconns }
}

func NewServer(addr string, port int, options ...Option) (*Server, error) {
	srv := Server{
		Addr:     addr,
		Port:     port,
		Protocol: "tcp",
		Timeout:  30 * time.Second,
		MaxConns: 1000,
		TLS:      nil,
	}
	for _, option := range options {
		option(&srv)
	}
	//...
	return &srv, nil
}

func main() {
	s1, _ := NewServer("localhost", 1024)
	s2, _ := NewServer("localhost", 2048, Protocol("udp"))
	s3, _ := NewServer("0.0.0.0", 8080, Timeout(300*time.Second), MaxConns(1000))
}
```

先看看 Options 类型, Options 类型是一个 入参为 Server Struct 的指针的闭包, 

```go
type Option func(*Server)
```

提供了和 Server struct 结构体的可选字段相对应的修改方法, 接着来看看 NewServer 方法, 这个方法 第一个和第二个参数是 必填参数, 第三个参数可以传入多个 options 类型的变量 . 然后会在给 Server 结构体赋值完默认值后, 运行全部的 option

```go
func NewServer(addr string, port int, options ...Option) (*Server, error) {
```

基于上述几点, 也就意味着你可以通过上面的方式, 很方便的修改 Server 结构体的属性, 并且不会影响默认参数的赋值.

* Functional Option 的优点包含如下
  * 合理的默认值
  * 高度可配置
  * 易于维护
  * 自我记录
  * 对新人来说安全
  * 不需要nil或空值
* 沿伸阅读
  * “Self referential functions and design” by Rob Pike - http://commandcenter.blogspot.com.au/2014/01/self-referential-functions-and-design.html

#### Functional Option in micro/go-micro 

在 `micro/go-micro` 这个微服务框架中, 也大量用到了 Functional Option 来让用户灵活的设置或者自定义. 举个下面的例子.

```go
type service struct {
	opts Options

	once sync.Once
}

type Options struct {
	Broker    broker.Broker
	Cmd       cmd.Cmd
	Client    client.Client
	Server    server.Server
	Registry  registry.Registry
	Transport transport.Transport

	// Before and After funcs
	BeforeStart []func() error
	BeforeStop  []func() error
	AfterStart  []func() error
	AfterStop   []func() error

	// Other options for implementations of the interface
	// can be stored in a context
	Context context.Context

	Signal bool
}

type Option func(*Options)

// Name of the service
func Name(n string) Option {
	return func(o *Options) {
		o.Server.Init(server.Name(n))
	}
}
// RegisterTTL specifies the TTL to use when registering the service
func RegisterTTL(t time.Duration) Option {
	return func(o *Options) {
		o.Server.Init(server.RegisterTTL(t))
	}
}
// RegisterInterval specifies the interval on which to re-register
func RegisterInterval(t time.Duration) Option {
	return func(o *Options) {
		o.Server.Init(server.RegisterInterval(t))
	}
}
func main() {
	service := micro.NewService(
		micro.Name(config.OperatorServiceName),
		micro.RegisterTTL(time.Second*10),
		micro.RegisterInterval(time.Second*5),
	)

	r := etcd.NewRegistry(func(options *registry.Options) {
		options.Addrs = []string{
			"msc-etcd-cluster.default",
		}
	})
	service.Init(
		micro.Registry(r),
	)
}


```

在 go-micro 中, 把 所有的 service 配置项 移入到一个 叫做 Options 的结构体中, 然后也通过`Functional Option` 的方式提供修改. 

### Map && Reducs && Filter

// TODO

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