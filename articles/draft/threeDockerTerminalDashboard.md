{}

# 常用的 Docker Terminal DashBoard 推荐

## Docker Terminal DashBoard 的适用场景

通常, 我们会使用 `docker` 这个 Docker Daemon 的 Client 来对 Docker 容器资源进行控制, 例如 容器的起停, 亦或者 Docker Image 的管理. 但是当我们镜像数量多起来之后, 仅仅使用 `docker ps` 或者 `docker rm` 这种命令有些效率低下, 需要经常 复制 和 上下翻页 查找需要处理的镜像 ID , 所以于是就想 , 有没有什么Terminal 上的 Docker dashboard 可以帮我们快速找到某个 Container 或者 Image 然后进行处理, 这些就对这些工具做一些详细的说明.

首先如果你想找的是一个本地环境下的 Dashboard, 那么极力推荐 `portainer/portainer` 这个 Web 页面的 Container Dashboard,支持 信息聚合, 页面逻辑清晰, 支持批量管理 等等功能. 关于 `portainer` 更详细的介绍可以参考 [这篇 Gist](https://kuricat.com/gist/).

 那么是否有了 `portainer` , 这些 Terminal 下的 Dashboard 就没有意义了呢? 我认为答案是否定的, 在 服务器上, 或者是想走`纯键盘流`的场景下, Docker Terminal DashBoard 还是有他的用武之地的, 例如我只是想删一些容器, 我不想 每次这样都大动干戈 的 通过`docker ps` 之后,然后手动的或者用脚本去删除. 我也不想为了删除 一些容器方便点, 还需要在 服务器上搭一个 `portainer` , 然后使用浏览器通过 web 访问进行删除. 这个时候 Docker Terminal DashBoard 的作用就体现出来了,  

1. 输入命令 
2. 选择需要删除的容器
3. 执行操作

你就完成了操作, 甚至你的手都不需要离开键盘, 如果有过相关经历的同学应该深有同感.

好了, 讲完了 Docker Terminal DashBoard 存在的意义, 这里我们就对三款比较优秀的 Docker Terminal DashBoard 做一个介绍.

* `moncho/dry`
* `bcicen/ctop`
* `lirantal/dockly`

## Dry

// TODO

> 项目地址 : https://github.com/moncho/dry
> 
> 详细介绍 Gist : https://kuricat.com/gist/ 

## Ctop

// TODO

> 项目地址 : https://github.com/bcicen/ctop
> 
> 详细介绍 Gist : https://kuricat.com/gist/ 

## Dockly

// TODO

> 项目地址 : https://github.com/lirantal/dockly
> 
> 详细介绍 Gist : https://kuricat.com/gist/ 


## 结
