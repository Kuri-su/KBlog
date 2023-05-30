+++
date = "2021-03-22"
title = "Opentracing note"
slug = "opentracing-note-1efoz"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

Opentracing 是在分布式追踪的一个通用标准, 提供一系列 平台/厂商/具体实现 无关的 Api, 使得开发人员能够方便的添加和切换 Tracing 系统的实现.

但在此之前, 需要定义什么是 Trace, 也就是分布式追踪中的最小单位, 怎么定义一个链路, 或者一次链路.

## Trace

Trace 代表一次 `完整的分布式请求` 所经过的路径. 其中 每一段称为一个 `span`,  所以也可以认为 Trace 是 由多个 span 组成的 DAG(有向无环图). 

![210322-opentracing (1)](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/opentracing-1.png)

分布式追踪中的每一段都是一个 span, 而 span 之间有从属关系, 一个 span 可以有多个 `子 span`, 也允许一个 `子 span` 有多个 `父 span`. 下面举个例子帮助理解: 

![210322-opentracing-Page-2](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/opentracing-2.png)

在一些 tracing 的实现中, 会有如下三个ID `trace_id`, `parent_id`,`span_id` , trace_id 代表一次请求, 所以一次trace 中的所有 trace id 都一样, 同时利用 parent_id 和 span_id 去关联 span 们, 这样, 我们就可以根据这些信息, 绘制出一个访问时序的图. 

> 这种方式展示了 执行时间的上下文, 相关服务间的层级关系, 进程或者任务串行或并行的调用关系. 
>
> 这样的视图有助于发现系统调用的关键路径。通过关注关键路径的执行过程，项目团队可能专注于优化路径中的关键位置，最大幅度的提升系统性能。例如：可以通过追踪一个资源定位的调用情况，明确底层的调用情况，发现哪些操作有阻塞的情况。

![image-20210322135145964](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/opentracing-3.png)

我们也可以利用 这些信息, 绘制出 请求的拓扑结构, 这里就不赘述这一部分, 

## 术语和定义

下面我们明确下各个属于的定义.

### Traces 

* 一个 Trace 代表一个潜在的, 分布式的, 存在 并行数据 或 并行执行轨迹 的系统. 一个 Trace 可以认为是 由多个 Span 组成的 有向无环图 (DAG)

### Spans

* 一个 span 代表系统中 具有 `开始时间` 和 `执行时长` 的逻辑运行单元. Span 之间通过 嵌套 或者 顺序排列.

#### **Operation Names**(操作名称)

* 每一个 Span 都有一个 `Operation Names(操作名称)` , 这个名字需要简单, 并且可读性高. 

| 操作名            | 指导意见                                                     |
| ----------------- | ------------------------------------------------------------ |
| `get`             | 太抽象                                                       |
| `get_account/792` | 太明确                                                       |
| `get_account`     | 正确的操作名，关于`account_id=792`的信息应该使用[Tag](https://wu-sheng.gitbooks.io/opentracing-io/content/pages/spec.html#tags)操作 |

#### **Inter-Span References** (Span 关联)

* 一个 Span 可以和若干个 span 之间存在因果关系. OpenTracing 定义了两种关系 `ChildOf` 和 `FollowFrom`. **这两种引用类型代表了子节点 和 父节点的直接因果关系**. 未来 Opentracing 还将支持 非因果关系的 span 引用关系.(例如: 多个 span 被批量处理, span 在同一个队列中. )`(笔者注: 自定义的 span 关联关系)`
* `ChildOf` , 表示当前的 span 是一个父级 span 的 子 span, 即 ChildOf 关系. 以下情况有可能会构成 ChildOf 关系.
  * RPC 调用服务端的 Span, 和 RPC 客户端的 span 构成 ChildOf 关系.
  * 一个 SQL 的 insert 操作的 span, 和 ORM 的 Save 方法的  Span 构成 ChildOf 关系
  * 很多 span 可以并行工作 都可能是一个 父级 span 的子项, 他会合并说有的子 span 的执行结果, 并在指定期限内返回.
* `FollowsFrom` , 一些父级节点不以任何方式依赖子 Span 的结果. 以下情况有可能会构成 `FollowsFrom`
  * 表示两个执行单元相对独立，不是强依赖。但也存在关联关系.
* 以上两个类型不存在绝对清晰的边界, 使用哪一种取决于业务开发者本身的决断, 带一些主观想法, 官网中的一些 Spans 之间的关系时序图,其实没有什么意义.直接理解一点:**span 是一个执行单元**,至于这个执行单元的粗细粒度,取决于业务需要.

#### **Logs** 

* Opentracing 提供方法将 span 和 logs 关联起来, 每一次 logs 操作, 都需要一个带时间戳的时间名称, 以及可选的任意大小的存储结构. 比较轻量.

#### **Tags**

* 每个 Span 可以有多个 KV 形式的 Tags, Tags 是没有时间戳的, 支持简单的对 span 进行注解和补充.

### **SpanContext**

* 每一个 Span 必须提供方法访问 SpanContext. SpanContext 更多是一种概念, 而非是一个强烈要求的对象, 虽然大多数实现里都有 SpanContext 这个存在. 大多数的用户只会在创建 新 Span , 或者 在 Inject 和 extract 操作 , 以及修改 **Baggage** 时, 与 SpanContext 交互. 
* **Baggage**(行李)
  * Baggage 是存储在 SpanContext 中的一个 KV 集合. 它会在一条 Trace 上的所有 span 上全局传输, 包含这些 Span 对应的 SpanContext. 
  * Baggage拥有强大功能,也会有很大的*消耗*.由于Baggage的全局传输,如果包含的数量量太大,或者元素太多,它将降低系统的吞吐量或增加RPC的延迟.

### Span Tags Vs Baggage

* Baggage 在全局范围内, 跨进程传输数据. Span 的 Tag 不会进行传输, 因为Span Tags 不会被 子 Span 集成.
* span tag 可以用来记录业务相关的数据, 并存储于 追踪系统中. 实现 Opentracing 时, 可以选择 

### Inject and Extract

SpanContexts 可以通过 Injected 操作向 Carrier 注入, 或者 通过 Extracted 操作从 Carrier 中提取. 通过指定的 key 注入到 header 头部或者通过指定的 key 从 header 取出 SpanContext

## Interface

### Span Interface

* `Get the span SpanContext` , 获取 Span 的 Context, 通过 span 获取 SpanContext,
* `Finish` , 完成已经开始的 `Span`. 除了获取 SpanContext 之外, Finish 方法必须是 Span 实例最后的一个被调用的方法. 
* `Set a key:value tag on the Span` , 为 span 设置 Tag, tag 的 key 必须是 `String ` 类型, 
* `Add a new log event` 为 span 添加一个 log 事件. 事件名称是 string 类型, 参数值 可以是任何类型 .
* `Set a Baggage item` 设置一个 `string:string` 的键值对. 
* `Get a Baggage item` 通过 key 获取 Baggage 中的元素.

### SpanContext Interface

用户可以通过 Span 实例或者 Tracer 的 Extract 能力提取 SpanContext 接口实例

* `Iterate over all Baggage items` 遍历所有的 Baggage 内容

### Tracer Interface

* `Start a new span` , 创建一个新的 Span , 调用者可以指定一个或者多个 SpanContext 关系, 声明一个开始的时间戳, 并设置 Span 的 Tags
* `Inject a SpanContext` , 将 SpanContext 注入 SpanContext, 
* `Extract a SpanContext` , 提取 SpanContext 信息.

### Global && No-op Tracer

每个平台的 OpenTracing Api 库 , 都必须实现一个空的  Tracer.

## Ref

> * [Opentracing 文档中文版(翻译) 吴晟](https://wu-sheng.gitbooks.io/opentracing-io)
> * [GOCN-OpenTracing——相关概念术语](https://gocn.vip/topics/8928)