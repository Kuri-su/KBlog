+++
date = "2019-12-29"
title = "ctop"
slug = "ctop-qv9ur"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "ctop"
+++


![](https://raw.githubusercontent.com/bcicen/ctop/master/_docs/img/logo.png)

## Install

### Linux

```shell
# 前往 https://github.com/bcicen/ctop/releases 下载最新版本的二进制文件放到 $PATH 中
$ sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop
$ sudo chmod +x /usr/local/bin/ctop
```

或者假设你已经配置了 Go 环境的话

```shell
$ cd /tmp && git clone git@github.com:bcicen/ctop.git
$ cd ctop 
# 确认你的 $GOPATH/bin 在 $PATH 中
$ go install
```

> PS: 如果你需要 exec 进入容器的 feature, 则需要自行编译 ctop , 目前的最新 release (v0.7.2) 暂不包括该功能

### MacOS

```shell
$ brew install ctop
```

## What

类似于 Top 的 容器指标监控面板. 你可以用它来对 容器进行指标监控和管理, 他会忠实的像 top 一样, 列出来每个容器的 CPU/MEM/NET 资源的占用. 目前(2020.1.1) ctop 支持三种容器实现 `docker`/`mock`/`runc`

相似的, 容器监控面板有很多其他的同类软件, 例如 dry 和 dockly  , ctop 和他们有什么不同呢, 首选 ctop 支持的 容器实现比较多, 有 三种. dockly 和 dry 则只支持 docker. 另一方面 ctop 的面板 在想要快速获取性能指标的场景下会显得非常直观, 所有的 性能指标都列在 主面板中, 另外 ctop 甚至支持 你查看某个容器的指标趋势, 不过暂不支持调整时间间隔大小. 他的同类软件 dry 只支持同时观看一个容器的性能指标, dockly 则没有这一块的支持. 

此外, ctop 也支持下面这些常规的容器管理操作, 例如 dry 是不支持 exec 进入容器的, 在 ctop 中, 你可以在启动时 指定 `--shell` 参数, 对 exec 使用的 shell 进行指定 例如 `ctop -shell bash`.

* 容器重启
* 删除
* 暂停
* 筛选
* exec进入容器
* 查看日志

## How

ctop 的使用也非常简单, 下面是主页面展示
![](https://raw.githubusercontent.com/bcicen/ctop/master/_docs/img/grid.gif)

快捷键也比较简单, 主要的快捷键如下
* `enter` 打开 容器菜单, 可以对容器做基本的容器管理
  * 例如 暂停/重启 等的操作
* `a` 选择是否显示 非运行状态的容器
* `h` 查看帮助
* `s`选择容器的排序
* `r` 调转 容器的排序
* `o` 打开 `容器性能指标趋势视图`
* `l`查看容器日志
* `e` 使用默认 shell 进入容器
* `s` 保存当前配置到文件
* `q` 退出 ctop