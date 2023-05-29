+++
date = "2020-07-13"
title = "recommended docker dashboard in cli mode "
slug = "recommended-docker-dashboard-in-cli-mode-86fvu"
categories = [ "tech","docker" ]
tags = [ "docker","cloudnative" ]
katex = false
headline = "通常, 我们会使用 `docker` 命令 这个 Docker Daemon 的 Client 来对 Docker 容器资源进行控制, 例如 容器的起停, 亦或者 Docker Image 的管理. 但是当我们镜像数量多起来之后,"
headImgUrl = "https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/recommendedDockerDashboardInCliMode.png"
+++


## Cli Docker DashBoard 的适用场景

通常, 我们会使用 `docker` 命令 这个 Docker Daemon 的 Client 来对 Docker 容器资源进行控制, 例如 容器的起停, 亦或者 Docker Image 的管理. 但是当我们镜像数量多起来之后, 仅仅使用 `docker ps` 或者 `docker rm` 这种命令有些效率低下, 需要经常 复制 和 上下翻页 查找需要处理的镜像 ID , 所以于是就想看看有没有什么 Cli 上的 Docker dashboard 可以帮我们快速找到某个 Container 或者 Image 然后进行处理,于是还真有一些收获, 这些就对这些工具做一些详细的说明.

首先如果你想找的是一个本地环境下的 Dashboard, 那么极力推荐 `portainer/portainer` 这个 Web 页面的 Container Dashboard,支持 信息聚合, 页面逻辑清晰, 支持批量管理 等等功能. 关于 `portainer` 更详细的介绍可以参考 [这篇 Gist](https://kuricat.com/gist/portainer-aebkv).

那么是否有了 `portainer` , 这些 cli 下的 Docker Dashboard 就没有意义了呢? 

我认为答案是否定的, 在服务器上或者是想走`纯键盘流`的场景下, Cli Docker DashBoard 还是有他的用武之地的, 例如我只是想删一些容器, 我不想 每次这样都大动干戈 的 通过`docker ps` 之后,然后手动的或者用脚本去删除. 

我也不想为了删除 一些容器方便点, 还需要在 服务器上搭一个 `portainer` , 然后使用浏览器通过 web 访问进行删除. 这个时候 Cli Docker DashBoard 的作用就体现出来了, 你只需要

1. 输入命令 运行 Dashboard
2. 选择需要删除的容器
3. 执行操作

你就完成了操作, 甚至你的手都不需要离开键盘, 如果有过相关经历的同学应该深有同感.

好了, 讲完了 Cli Docker DashBoard 存在的意义, 这里我们就对三款比较优秀的 Cli Docker DashBoard 做一个介绍.

* [moncho/dry](github.com/moncho/dry)
* [bcicen/ctop](github.com/bcicen/ctop)
* [lirantal/dockly](github.com/lirantal/dockly)

## Dry

目前我认为的当下最好用, 功能最全的 Cli Docker Dashboard, 支持包括 container/Image/Volumn/Stack 在内的 Docker 管理.

更多介绍查看 Gist : https://kuricat.com/gist/dry-qp8hs

> 项目地址 : https://github.com/moncho/dry
> 
> 详细介绍 Gist : https://kuricat.com/gist/dry-qp8hs

## Lazydocker

简单易用的 Cli Docker Dashboard , 功能上比 Dry 略逊, 但完全够用, 

更多介绍查看 Gist: https://kuricat.com/gist/lazydocker-chqdq

> 项目地址 : https://github.com/jesseduffield/lazydocker
>
> 详细介绍 Gist : https://kuricat.com/gist/lazydocker-chqdq

## Ctop

Top 风格的 Cli Docker Dashboard , 可以和 `dry` 互相补足

更多介绍查看 Gist : https://kuricat.com/gist/ctop-qv9ur

> 项目地址 : https://github.com/bcicen/ctop
>
> 详细介绍 Gist : https://kuricat.com/gist/ctop-qv9ur

## Dockly

勉强够用的 Docker Dashboard , 在找到 Dry 之后我就基本不用了, 不过如果你的场景较为简单, 没有那么多复杂的需求也可以考虑 dockly.

更多介绍查看 Gist : https://kuricat.com/gist/dockly-buuqs

> 项目地址 : https://github.com/lirantal/dockly
>
> 详细介绍 Gist : https://kuricat.com/gist/dockly-buuqs

## 结

总结一下, 我自己当前是 本地 `Portainer` , Cli 里 `dry`, 偶尔需要看大量 container 负载的场景会用 `ctop` 这么个配置.

一个好的工具会让你事半功倍.