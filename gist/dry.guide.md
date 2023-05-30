+++
date = "2019-12-18"
title = "Dry"
slug = "dry-qp8hs"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "dry"
+++

## Install

### Mac OS

```shell
$ brew tap moncho/dry
$ brew install dry
```

### Arch / Manjaro

```shell
$ sudo pacman -S dry-bin
# yay -S dry-bin
```

### 直接获取binary 可执行文件

目前 dry 的 `github release page` 提供 如下`四个平台`的 的 `i386` 和 `amd64` 版本的 可执行文件, 可以直接下载然后放到 PATH 下执行

* linux
* windows
* freebsd
* darwin

当前最新(2019-12-18)版本 `v0.10-beta.1`

```shell
# wget https://github.com/moncho/dry/releases/download/v0.10-beta.1/dry-linux-amd64
$ wget https://github.com/moncho/dry/releases/download/${version}/dry-${platform}-${ISA}
```

### 直接编译

此处假定读者拥有Go 开发环境, 以及已经设置 Go Module , 

```shell
$ cd /tmp
$ git clone git@github.com:moncho/dry.git
# 当然你也可以直接 Go Build
$ cd dry && go install
# move into $PATH
$ sudo cp $GOPATH/bin/dry /usr/local/bin/ 
```

## What

在 GitHub 的 Description 是  `A Docker manager for the terminal` (终端中的 Docker 管理器), 正如此所说, dry 可以对当前机器的如下几种 Docker 资源进行管理

1. 第一位当然是 Container , Terminal的Docker Manager 标配
2. Images
3. Networks
4. Volumes
5. Stacks , 这个在使用 Docker Compose 的时候会用到
6. Nodes , 这个是偏向 Docker Swarm 的特性
7. Services , 这个也是偏向 Docker Swarm 的特性, 基本比较少用到

所以, dry 基本涵盖了 Docker 中需要管理的资源, 还是比较实用的. 在dashboard上有, 唯一有个美中不足的地方是在 Container 的 list 页面, 不能一并输出 Container 的 IP, 不过这个不是太重要, 在 进入 container 的详情页就可以看到 Container IP. 

另外 , dry 没有好用的在面板上直接 exec 进入容器的能力. 这个也算是一个比较遗憾的点, 不知道之后会不会有 PR 把这个 Feature 补上, 不过看看和 dry 类似的工具, 例如 `ctop`/`dockly` 虽然提供了 直接 exec 进入 容器的能力, 但是其实也做的很难用...所以对于这个功能我就释然了.

除此之外, dry 还是相当好用的.

## Why

很多同学都会想, 我们已经有了 `portainer/portainer` 这么好用的 web 端 Docker 管理工具, 那么为什么我们还需要一款 Docker Terminal Dashboard, 关于这点可以参见这一篇文章: [在 cli 模式下推荐的 docker 仪表板](https://kuricat.com/articles/recommended-docker-dashboard-in-cli-mode-86fvu)

## How

在将 dry 加入 `PATH` 后,  直接 dry 即可运行, 在刚刚开始运行的时候, dry 会显示一个 Loading 界面, 此时 dry 在收集 Docker Daemon 的数据, 此后, 我们就可以看到 dry 的页面了, 大体如下面这个作者提供的视频所示:

[![asciicast](https://asciinema.org/a/35825.png)](https://asciinema.org/a/35825?autoplay=1&speed=1.5)

操作也很简单, 使用 number 键来切换 要管理的对象类别
* `1` 容器
* `2` 镜像
* `3` Network
* `4` Volume 挂载卷
* `5` Node (Swarm)
* `6` Service (Swarm)
* `7` Stacks (Swarm)

常用的快捷键还包括以下这些: 
* `%`  显示列表中包含关键字
* `F1` 切换列表排序
* `F2` 显示全部容器(包括已经停止的容器)
* `F5` 刷新列表
* `F10` 显示 Docker info
* `Q` 退出 dry
* `e` 删除容器
* `l` 查看容器 日志
* `C-r` 重启容器
* `C-t` 停止容器
* `C-k` 强制停止容器
* `Enter` 交互菜单
* `m` 监控容器 CPU 和 MEM 用量
