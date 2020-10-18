!!! UNDONE!!!

# Service

> go-micro v1.18.0

[TOC]

// TODO 这块开头内容需要再整理

Service 是 Go-Micro 框架最上层的结构, 一个 Service 就代表 一个 Go-Micro 服务, 一个 Service 包含若干个 微服务所必须的部分, 例如 Registry 部分, 但它 并没有直接依赖具体实现, 而是将依赖的方法, 全部抽象成接口, 让下层的 实现来实现方法,  

Service 仅仅依赖 全部的 都是 Interface, 它有六个组成部分, 以及若干中间件 和 一些属性变量组成

Service 的 方法 和 他的属性变量是分开放的, 方法都放在 `service Struct` 下, 并由 service Struct 实现 `Service Interface`, 然后 service Struct 的 属性变量会放到 `Options Struct 中`,   Go-Micro 中的大部分 主要结构体都是这种结构,  

```go
// interface
type Service interface {
    // 有实际动作的方法
    Init(...Option)
    Run() error
    
    // 仅仅用于返回 成员变量
	Name() string
	Options() Options
	Client() client.Client
	Server() server.Server
	String() string
}

// struct
type service struct {
    // 成员内容
    opts Options

    // 用于确保 需要 Init 的内容只执行一次
	once sync.Once
}

// Options
type Options struct{
    Broker    broker.Broker         // 异步请求 Server 
	Cmd       cmd.Cmd				// 处理 CMD 事务, 基本上是用来处理 环境变量, 
	Client    client.Client			// Client 
	Server    server.Server			// Server 
	Registry  registry.Registry		// 服务注册与发现
	Transport transport.Transport   // 连接层

	// 前后的钩子
	BeforeStart []func() error
	BeforeStop  []func() error
	AfterStart  []func() error
	AfterStop   []func() error
	Context context.Context
    // 监听订阅信号
	Signal bool
}
```

Service 的代码较为简单, 基本上只有 Init 和 Run 以及 Start 和 Stop 方法里面有实际逻辑, 而 Start 和 Stop 方法里面只是 执行完 前后的钩子, 然后去调 Server 的方法而已, 所以我们实际上要看的只有 Init 方法 和 Run 方法.

## Init 方法

Init 方法也很简单, 开头在 初始化, 传入的各种 Option, 通常也用 Init 方法来执行这个 Option

```go
func (s *service) Init(opts ...Option) {
	// process options
	for _, o := range opts {
		o(&s.opts)   // 这里将
	}
    
    // ...
}
```

然后接着是一个 用 sync.Once 保证的一个 Service 只执行一次的 代码块. 用于加载 和 应用 环境变量 和 插件.

```go
func (s *service) Init(opts ...Option) {
    // ....
    
    s.once.Do(func() {
        for _, p := range strings.Split(os.Getenv("MICRO_PLUGIN"), ",") {
            if len(p) == 0 {
                continue
            }

            c, err := plugin.Load(p)
            if err != nil {
                log.Fatal(err)
            }

            if err := plugin.Init(c); err != nil {
                log.Fatal(err)
            }
        }

        _ = s.opts.Cmd.Init(
            cmd.Broker(&s.opts.Broker),
            cmd.Registry(&s.opts.Registry),
            cmd.Transport(&s.opts.Transport),
            cmd.Client(&s.opts.Client),
            cmd.Server(&s.opts.Server),
        )
	})
}
```

## Run 方法

Run 总体上分为四个部分, 

1. 插入了 一个 用于 Debug 的 Handler , 提供 `健康检查`/ `Runtime 指标`  以及 `日志收集`  的接口, 不过由于笔者使用 `自定义的 日志组件` 和 `基于 Prometheus 的指标收集Runtime 指标` , 所以这里就不展开

   ```go
   func (s *service) Run() error {
       s.opts.Server.Handle(
           // 注册 Handler
   		s.opts.Server.NewHandler(
               // 默认 Handler
   			handler.DefaultHandler,
   			server.InternalHandler(true),
   		),
   	)
       // ... 
   }
   ```

2. 判断是否存在 `MICRO_DEBUG_PROFILE`, 如果存在就默认开启 pprof , 将 CPU 和 MEM 的 性能数据保存到 /tmp 目录下. (对于性能影响较小)

   ```go
   func (s *service) Run() error {
       // ...
       
   	if prof := os.Getenv("MICRO_DEBUG_PROFILE"); len(prof) > 0 {
   		service := s.opts.Server.Options().Name
   		version := s.opts.Server.Options().Version
   		id := s.opts.Server.Options().Id
   		profiler := pprof.NewProfile(
   			profile.Name(service + "." + version + "." + id),
   		)
           // 启动 pprof 服务
   		if err := profiler.Start(); err != nil {
   			return err
   		}
   		defer profiler.Stop()
   	}
       
       // ... 
   }
   ```

3. 调用上面提到的 Service 的 `Start` 方法, 用于启动整个服务.
4. 然后监听退出信号或者 ctx 的消息, 调用上面提到的 Stop 方法, 用于停止整个 服务
   ```go
   
   func (s *service) Run() error {
   	// ... 
   
       // 启动服务
   	if err := s.Start(); err != nil {
   		return err
   	}
   
       // 注册系统信号
   	ch := make(chan os.Signal, 1)
   	if s.opts.Signal {
   		signal.Notify(ch, syscall.SIGTERM, syscall.SIGINT, syscall.SIGQUIT)
   	}
   
       // 等待 信号或者 Context 消息
   	select {
   	case <-ch:
   	case <-s.opts.Context.Done():
   	}
   
    // 停止服务
   	return s.Stop()
   }
   ```
   

## Function Service

// TODO