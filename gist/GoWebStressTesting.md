# Golang Web 程序压力测试要点

[TOC]

压测时除了我们最关注的 QPS 以外, 还有 进程的 CPU / MEM, HTTP 状态码, 是否有 Timeout, 响应时延, 网卡流量 这几个指标需要关注, 下面笔者一个一个指标来说.

## QPS

这个没啥好说的, 就是 每秒处理请求数, 对于 Golang web 程序来说

