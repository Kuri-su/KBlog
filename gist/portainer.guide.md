
## Install

> 前提: 已经安装 `Docker`
>
> 强力推荐

### Linux

```shell
$ docker volume create portainer_data
# 不过为了避免与 php-fpm 的 端口冲突, 建议把 9000:9000 改为 8999:9000
$ docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

### Windows

#### 使用 Linux 容器
```shell
$ docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v C:\ProgramData\Portainer:/data portainer/portainer
```

#### 使用 原生 Windows 容器
```shell
$ docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v \\.\pipe\docker_engine:\\.\pipe\docker_engine -v C:\ProgramData\Portainer:C:\data portainer/portainer
```

### Docker Swarm

参考 [此处](https://portainer.readthedocs.io/en/latest/deployment.html)

## What

Portainer 是在 Web 中 管理 `Docker 容器` 以及 `Docker Swarm` 集群的 工具, 通常用于本地 Docker 的可视化管理面板, 也可以用于 服务器 Docker 管理, 不过通常不建议暴露 服务器 Docker Daemon 端口, 你可以使用 [dry]() 在 cli 中对 服务器上的 Docker 容器进行管理.

Portainer 是个人认为目前本地环境 Docker 管理最好用的工具(当然有更好用的 工具非常欢迎打脸交流XD), `Container List` 中查看IP 或者 批量删除 Image / Container / Volume 或者对 Network 进行管理, 他全部都能很简单的做到, 而且操作简单直观, 效率很高.

## Why

那么就提出问题了, 例如类似于 `dry` 等的 Cli Container Dashboard 也很好用丫, 为什么我要在本地装 Portainer ? 

的确, dry 是很优秀的工具, 但是它在命令行环境下, 也有一些不足, 而 Portainer 正好能补足这些不足, 举个例子: 对 Container 批量删除, 这个时候 无论是用 docker 命令还是 dry 都很麻烦, docker 命令下面需要用脚本, 然后dry 不支持批量删除, 而 在 Portainer 中, 你只需要 `shift + 鼠标右键` 点几下, 就可以搞定这个很麻烦的事, 类似的爽点还有不少, 这里就不一一列举了.

## How

这里以 Docker 安装为例, 在 Docker 安装后, 你使用 8999 端口, 就访问 `localhost:8999`, 如果是 9000 就访问 `localhost:9000`, 在访问后, 初次访问会要求设置账号密码, 完成后即可对资源进行管理, 如下图所示:
![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/portainer/01.png)
